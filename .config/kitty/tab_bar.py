"""Custom tab bar for kitty — Rosé Pine themed.

Status info (IP, CPU, RAM, battery) is collected on a background thread so the
render thread never blocks on subprocess calls, and the clock is cached to 1s
granularity instead of being rebuilt on every repaint.
"""

import datetime
import os
import socket
import subprocess
import threading
import time

from kitty.fast_data_types import Screen
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    TabBarData,
    as_rgb,
)

# --- Rosé Pine palette ---
COLOR_BASE    = as_rgb(0x191724)  # background
COLOR_SURFACE = as_rgb(0x26233a)  # inactive bubble
COLOR_TEXT    = as_rgb(0xe0def4)  # foreground
COLOR_SUBTLE  = as_rgb(0x908caa)  # muted text
COLOR_PINE    = as_rgb(0x31748f)  # green
COLOR_GOLD    = as_rgb(0xf6c177)  # yellow
COLOR_ROSE    = as_rgb(0xebbcba)  # peach/rose
COLOR_FOAM    = as_rgb(0x9ccfd8)  # blue
COLOR_IRIS    = as_rgb(0xc4a7e7)  # mauve

REFRESH_INTERVAL = 5.0  # seconds between background status refreshes

_lock = threading.Lock()
_status = {"ip": "?.?.?.?", "batt": "", "cpu": "0.0", "ram": "0.0G"}
_clock = [0, "--:--"]  # [last second rendered, cached clock string]


def get_local_ip():
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        try:
            s.connect(("8.8.8.8", 80))
            return s.getsockname()[0]
        finally:
            s.close()
    except OSError:
        return "127.0.0.1"


def get_battery():
    try:
        out = subprocess.check_output(["pmset", "-g", "batt"], timeout=2).decode()
        if "InternalBattery" in out:
            return out.split("\t")[1].split(";")[0].strip()
    except Exception:
        pass
    return ""


def get_stats():
    try:
        # CPU usage (simple load average)
        cpu = os.getloadavg()[0]
        # RAM usage on macOS via vm_stat (no shell needed)
        out = subprocess.check_output(["vm_stat"], timeout=2).decode()
        for line in out.splitlines():
            if line.startswith("Pages active:"):
                pages = int(line.split()[2].rstrip("."))
                break
        else:
            raise ValueError("Pages active not found")
        ram_gb = (pages * 4096) / (1024 ** 3)
        return f"{cpu:.1f}", f"{ram_gb:.1f}G"
    except Exception:
        return "0.0", "0.0G"


def _collect():
    cpu, ram = get_stats()
    return {
        "ip": get_local_ip(),
        "batt": get_battery(),
        "cpu": cpu,
        "ram": ram,
    }


def _refresh_loop():
    """Keep the status cache fresh without ever blocking the render thread."""
    while True:
        try:
            fresh = _collect()
            with _lock:
                _status.update(fresh)
        except Exception:
            pass
        time.sleep(REFRESH_INTERVAL)


# Kitty reloads this module on every config reload; only ever run one worker
if not any(
    t.name == "kitty-tabbar-status" and t.is_alive()
    for t in threading.enumerate()
):
    threading.Thread(target=_refresh_loop, name="kitty-tabbar-status", daemon=True).start()


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    # --- Tab Styling (Rounded Bubbles) ---
    if tab.is_active:
        screen.cursor.bg = 0
        screen.cursor.fg = COLOR_IRIS
        screen.draw("")
        screen.cursor.bg = COLOR_IRIS
        screen.cursor.fg = COLOR_BASE
        screen.draw(f" {index}   {tab.title} ")
        screen.cursor.bg = 0
        screen.cursor.fg = COLOR_IRIS
        screen.draw("")
    else:
        screen.cursor.bg = 0
        screen.cursor.fg = COLOR_SURFACE
        screen.draw("")
        screen.cursor.bg = COLOR_SURFACE
        screen.cursor.fg = COLOR_SUBTLE
        screen.draw(f" {index} {tab.title} ")
        screen.cursor.bg = 0
        screen.cursor.fg = COLOR_SURFACE
        screen.draw("")

    screen.draw(" ")

    # --- Status Bar (Right Side) ---
    if is_last:
        with _lock:
            status = dict(_status)

        # Clock: rebuild at most once per second, not per frame
        now = int(time.time())
        if now != _clock[0]:
            _clock[0] = now
            _clock[1] = datetime.datetime.now().strftime("  %H:%M ")

        ip_seg = f"  {status['ip']} "
        cpu_seg = f"  {status['cpu']} "
        ram_seg = f"  {status['ram']} "
        batt_seg = f"  {status['batt']} " if status["batt"] else ""
        time_seg = _clock[1]

        full = f"{ip_seg}{cpu_seg}{ram_seg}{batt_seg}{time_seg}"

        # Push to the right edge
        cells_left = screen.columns - screen.cursor.x - len(full) - 2
        if cells_left > 0:
            screen.draw(" " * cells_left)

        # Draw with color-coded segments
        screen.cursor.fg = COLOR_PINE
        screen.draw(ip_seg)
        screen.cursor.fg = COLOR_GOLD
        screen.draw(cpu_seg)
        screen.cursor.fg = COLOR_FOAM
        screen.draw(ram_seg)
        screen.cursor.fg = COLOR_ROSE
        screen.draw(batt_seg)
        screen.cursor.fg = COLOR_IRIS
        screen.draw(time_seg)

    return screen.cursor.x
