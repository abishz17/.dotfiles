local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local spaces = {}

for i = 1, 9, 1 do
  -- Use regular "item" instead of "space" for macOS 26.0 compatibility
  local space = sbar.add("item", "space." .. i, {
    icon = {
      font = { family = settings.font.numbers },
      string = i,
      padding_left = 8,
      padding_right = 4,
      color = colors.white,
      highlight_color = colors.red,
    },
    label = {
      padding_right = 8,
      color = colors.grey,
      highlight_color = colors.white,
      font = "sketchybar-app-font:Regular:16.0",
      y_offset = -1,
    },
    padding_right = 1,
    padding_left = 1,
    background = {
      color = colors.transparent,
      border_width = 1,
      height = 26,
      border_color = colors.red,
    },
    popup = { background = { border_width = 5, border_color = colors.black } }
  })

  spaces[i] = space

  -- Single item bracket for space items to achieve double border on highlight
  local space_bracket = sbar.add("bracket", { space.name }, {
    background = {
      color = colors.transparent,
      border_color = colors.bg2,
      height = 28,
      border_width = 2
    }
  })

  -- Padding space (using regular item for macOS 26.0 compatibility)
  sbar.add("item", "space.padding." .. i, {
    script = "",
    width = 2,
  })

  local space_popup = sbar.add("item", {
    position = "popup." .. space.name,
    padding_left= 5,
    padding_right= 0,
    background = {
      drawing = true,
      image = {
        corner_radius = 9,
        scale = 0.2
      }
    }
  })

  space:subscribe("aerospace_workspace_change", function(env)
    local selected = env.FOCUSED_WORKSPACE == tostring(i)
    local color = selected and colors.grey or colors.bg2
    space:set({
      icon = { highlight = selected, },
      label = { highlight = selected },
      background = { border_color = selected and colors.black or colors.bg2 }
    })
    space_bracket:set({
      background = { border_color = selected and colors.grey or colors.bg2 }
    })
  end)

  space:subscribe("mouse.clicked", function(env)
    if env.BUTTON == "other" then
      space_popup:set({ background = { image = "space." .. i } })
      space:set({ popup = { drawing = "toggle" } })
    else
      sbar.exec("aerospace workspace " .. i)
    end
  end)

  space:subscribe("mouse.exited", function(_)
    space:set({ popup = { drawing = false } })
  end)
end

local space_window_observer = sbar.add("item", {
  drawing = false,
  updates = true,
})

-- Function to update workspace apps using aerospace
local function update_workspace_apps()
  sbar.exec("aerospace list-windows --all --format '%{workspace},%{app-name}'", function(result)
    -- Clear all workspace labels first
    for j = 1, 9 do
      spaces[j]:set({ label = " —" })
    end
    
    -- Parse aerospace output and group apps by workspace
    local workspace_apps = {}
    for line in result:gmatch("[^\r\n]+") do
      local workspace, app = line:match("^(%d+),(.+)$")
      if workspace and app then
        workspace = tonumber(workspace)
        if workspace and workspace >= 1 and workspace <= 10 then
          if not workspace_apps[workspace] then
            workspace_apps[workspace] = {}
          end
          workspace_apps[workspace][app] = true
        end
      end
    end
    
    -- Update labels for each workspace
    for workspace_num, apps in pairs(workspace_apps) do
      local icon_line = ""
      for app, _ in pairs(apps) do
        local lookup = app_icons[app]
        local icon = ((lookup == nil) and app_icons["Default"] or lookup)
        icon_line = icon_line .. icon
      end
      
      if icon_line == "" then
        icon_line = " —"
      end
      
      sbar.animate("tanh", 10, function()
        spaces[workspace_num]:set({ label = icon_line })
      end)
    end
  end)
end

local spaces_indicator = sbar.add("item", {
  padding_left = -3,
  padding_right = 0,
  icon = {
    padding_left = 8,
    padding_right = 9,
    color = colors.grey,
    string = icons.switch.on,
  },
  label = {
    width = 0,
    padding_left = 0,
    padding_right = 8,
    string = "Spaces",
    color = colors.bg1,
  },
  background = {
    color = colors.with_alpha(colors.grey, 0.0),
    border_color = colors.with_alpha(colors.bg1, 0.0),
  }
})

-- Subscribe to aerospace workspace change and update periodically
space_window_observer:subscribe("aerospace_workspace_change", function(env)
  update_workspace_apps()
end)

-- Update apps periodically (every 2 seconds)
space_window_observer:subscribe("routine", function(env)
  update_workspace_apps()
end)

-- Initial update
update_workspace_apps()

spaces_indicator:subscribe("swap_menus_and_spaces", function(env)
  local currently_on = spaces_indicator:query().icon.value == icons.switch.on
  spaces_indicator:set({
    icon = currently_on and icons.switch.off or icons.switch.on
  })
end)

spaces_indicator:subscribe("mouse.entered", function(env)
  sbar.animate("tanh", 30, function()
    spaces_indicator:set({
      background = {
        color = { alpha = 1.0 },
        border_color = { alpha = 1.0 },
      },
      icon = { color = colors.bg1 },
      label = { width = "dynamic" }
    })
  end)
end)

spaces_indicator:subscribe("mouse.exited", function(env)
  sbar.animate("tanh", 30, function()
    spaces_indicator:set({
      background = {
        color = { alpha = 0.0 },
        border_color = { alpha = 0.0 },
      },
      icon = { color = colors.grey },
      label = { width = 0, }
    })
  end)
end)

spaces_indicator:subscribe("mouse.clicked", function(env)
  sbar.trigger("swap_menus_and_spaces")
end)
