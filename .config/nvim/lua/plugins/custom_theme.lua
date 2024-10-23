return {
  {
    dir = ".", -- This tells lazy.nvim that it's a local plugin
    name = "custom_theme",
    lazy = false,
    priority = 1000,
    config = function()
      -- Define the colors
      local colors = {
        bg = "#0E0E0E",
        fg = "#E2E2E3",
        red = "#F28FAD",
        green = "#ABE9B3",
        yellow = "#FAE3B0",
        blue = "#96CDFB",
        magenta = "#DDB6F2",
        cyan = "#89DCEB",
        black = "#1C1B1D",
        white = "#D9E0EE",
        bright_black = "#575268",
      }

      local function setup_theme()
        -- Clear existing highlights
        vim.cmd("hi clear")
        if vim.fn.exists("syntax_on") then
          vim.cmd("syntax reset")
        end

        -- Set color scheme name
        vim.opt.termguicolors = true
        vim.g.colors_name = "custom_theme"

        -- Set up highlight groups
        local highlights = {
          -- Editor highlights
          Normal = { fg = colors.fg, bg = colors.bg },
          LineNr = { fg = colors.bright_black },
          CursorLine = { bg = colors.black },
          CursorLineNr = { fg = colors.white },
          Visual = { bg = colors.bright_black },
          IncSearch = { fg = colors.bg, bg = colors.yellow },
          Search = { fg = colors.bg, bg = colors.blue },

          -- Syntax highlighting
          Comment = { fg = colors.bright_black, italic = true },
          String = { fg = colors.green },
          Number = { fg = colors.magenta },
          Function = { fg = colors.blue },
          Keyword = { fg = colors.magenta },
          Operator = { fg = colors.cyan },
          Type = { fg = colors.yellow },

          -- Status line
          StatusLine = { fg = colors.white, bg = colors.black },
          StatusLineNC = { fg = colors.bright_black, bg = colors.black },

          -- Tabs
          TabLine = { fg = colors.bright_black, bg = colors.black },
          TabLineFill = { bg = colors.black },
          TabLineSel = { fg = colors.white, bg = colors.bright_black },

          -- Popup menus
          Pmenu = { fg = colors.fg, bg = colors.black },
          PmenuSel = { fg = colors.bg, bg = colors.blue },

          -- Tree-sitter highlights
          ["@function"] = { fg = colors.blue },
          ["@keyword"] = { fg = colors.magenta },
          ["@string"] = { fg = colors.green },
          ["@variable"] = { fg = colors.white },
          ["@field"] = { fg = colors.cyan },
          ["@property"] = { fg = colors.cyan },
          ["@parameter"] = { fg = colors.white },

          -- Telescope
          TelescopeBorder = { fg = colors.bright_black },
          TelescopePromptBorder = { fg = colors.bright_black },
          TelescopeResultsBorder = { fg = colors.bright_black },
          TelescopePreviewBorder = { fg = colors.bright_black },
          TelescopeSelectionCaret = { fg = colors.blue },
          TelescopeSelection = { fg = colors.white, bg = colors.black },
          TelescopeMatching = { fg = colors.blue },

          -- Neo-tree
          NeoTreeNormal = { fg = colors.fg, bg = colors.bg },
          NeoTreeNormalNC = { fg = colors.fg, bg = colors.bg },
          NeoTreeVertSplit = { fg = colors.bright_black },
          NeoTreeWinSeparator = { fg = colors.bright_black },
          NeoTreeEndOfBuffer = { fg = colors.bg },
          NeoTreeRootName = { fg = colors.blue, bold = true },
          NeoTreeFileName = { fg = colors.fg },
          NeoTreeFileNameOpened = { fg = colors.blue },
          NeoTreeFloatNormal = { bg = colors.bg },
          NeoTreeFloatBorder = { fg = colors.bright_black, bg = colors.bg },

          -- Lualine can use these colors
          LualineNormal = { fg = colors.fg, bg = colors.black },
          LualineInsert = { fg = colors.bg, bg = colors.blue },
          LualineVisual = { fg = colors.bg, bg = colors.magenta },
          LualineReplace = { fg = colors.bg, bg = colors.red },
          LualineCommand = { fg = colors.bg, bg = colors.green },
        }

        -- Apply highlights
        for group, settings in pairs(highlights) do
          vim.api.nvim_set_hl(0, group, settings)
        end
      end

      -- Set up colorscheme command
      vim.api.nvim_create_user_command('CustomTheme', setup_theme, {})

      -- Apply the theme immediately
      setup_theme()
    end,
  }
}
