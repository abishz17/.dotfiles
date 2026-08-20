import datetime
import socket
import subprocess
import os
from kitty.fast_data_types import Screen, get_options
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    TabBarData,
    as_rgb,
    draw_title,
)
from kitty.utils import color_as_int

# --- Configuration & Colors ---
COLOR_MAUVE = as_rgb(0xcba6f7)
COLOR_GREEN = as_rgb(0xa6e3a1)
COLOR_YELLOW = as_rgb(0xf9e2af)
COLOR_BLUE = as_rgb(0x89b4fa)
COLOR_PEACH = as_rgb(0xfab387)
COLOR_SURFACE = as_rgb(0x313244)
COLOR_TEXT = as_rgb(0xcdd6f4)
COLOR_CRUST = as_rgb(0x11111b)

# Cache for status items
last_status_update = 0
cached_status = {
    "ip": "?.?.?.?",
    "batt": "",
    "cpu": "0%",
    "ram": "0%",
}

def get_local_ip():
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80))
        ip = s.getsockname()[0]
        s.close()
        return ip
    except:
        return "127.0.0.1"

def get_battery():
    try:
        output = subprocess.check_output(["pmset", "-g", "batt"]).decode()
        if "InternalBattery" in output:
            percent = output.split('\t')[1].split(';')[0].strip()
            return percent
        return ""
    except:
        return ""

def get_stats():
    try:
        # CPU usage (simple load average)
        cpu = os.getloadavg()[0]
        # RAM usage on macOS using vm_stat
        ram_output = subprocess.check_output("vm_stat | grep 'Pages active' | awk '{print $3}'", shell=True).decode().strip().replace('.', '')
        # Convert pages to GB (rough)
        ram_gb = (int(ram_output) * 4096) / (1024**3)
        return f"{cpu:.1f}", f"{ram_gb:.1f}G"
    except:
        return "0.0", "0.0G"

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
    global last_status_update
    
    # --- Tab Styling (Rounded Bubbles) ---
    if tab.is_active:
        screen.cursor.bg = 0
        screen.cursor.fg = COLOR_MAUVE
        screen.draw("") 
        screen.cursor.bg = COLOR_MAUVE
        screen.cursor.fg = COLOR_CRUST
        screen.draw(f" {index}   {tab.title} ")
        screen.cursor.bg = 0
        screen.cursor.fg = COLOR_MAUVE
        screen.draw("")
    else:
        screen.cursor.bg = 0
        screen.cursor.fg = COLOR_SURFACE
        screen.draw("")
        screen.cursor.bg = COLOR_SURFACE
        screen.cursor.fg = COLOR_TEXT
        screen.draw(f" {index} {tab.title} ")
        screen.cursor.bg = 0
        screen.cursor.fg = COLOR_SURFACE
        screen.draw("")

    screen.draw(' ')

    # --- Status Bar (Right Side) ---
    if is_last:
        now = datetime.datetime.now().timestamp()
        if now - last_status_update > 5:
            cpu, ram = get_stats()
            cached_status["ip"] = get_local_ip()
            cached_status["batt"] = get_battery()
            cached_status["cpu"] = cpu
            cached_status["ram"] = ram
            last_status_update = now

        # Color-coded segments
        ip_seg = f"  {cached_status['ip']} "
        cpu_seg = f"  {cached_status['cpu']} "
        ram_seg = f"  {cached_status['ram']} "
        batt_seg = f"  {cached_status['batt']} " if cached_status['batt'] else ""
        time_seg = datetime.datetime.now().strftime("  %H:%M ")
        
        status = f"{ip_seg}{cpu_seg}{ram_seg}{batt_seg}{time_seg}"
        
        # Calculate push to right
        cells_left = screen.columns - screen.cursor.x - len(status) - 2
        if cells_left > 0:
            screen.draw(' ' * cells_left)
            
        # Draw with colors
        screen.cursor.fg = COLOR_GREEN
        screen.draw(ip_seg)
        screen.cursor.fg = COLOR_YELLOW
        screen.draw(cpu_seg)
        screen.cursor.fg = COLOR_BLUE
        screen.draw(ram_seg)
        screen.cursor.fg = COLOR_PEACH
        screen.draw(batt_seg)
        screen.cursor.fg = COLOR_MAUVE
        screen.draw(time_seg)

    return screen.cursor.x
