return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets", "xzbdmw/colorful-menu.nvim" },
  version = "*",
  opts = {
    keymap = {
      preset = "enter",
      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return require("blink.cmp").select_next()
          end
        end,
        "snippet_forward",
        "fallback",
      },
      ["<S-Tab>"] = {
        "select_prev",
        "snippet_forward",
        "fallback",
      },
    },
    signature = {
      enabled = true,
    },
    appearance = {
      nerd_font_variant = "mono",
      kind_icons = {
        Text = "󰉿",
        Method = "󰊕",
        Function = "󰊕",
        Constructor = "󰒓",

        Field = "󰜢",
        Variable = "󰆦",
        Property = "󰖷",

        Class = "󱡠",
        Interface = "󱡠",
        Struct = "󱡠",
        Module = "󰅩",

        Unit = "󰪚",
        Value = "󰦨",
        Enum = "󰦨",
        EnumMember = "󰦨",

        Keyword = "󰻾",
        Constant = "󰏿",

        Snippet = "󱄽",
        Color = "󰏘",
        File = "󰈔",
        Reference = "󰬲",
        Folder = "󰉋",
        Event = "󱐋",
        Operator = "󰪚",
        TypeParameter = "󰬛",
      },
    },

    completion = {
      menu = {
        draw = {
          components = {
            label = {
              width = { fill = true, max = 60 },
              text = function(ctx)
                local highlights_info = require("colorful-menu").highlights(ctx.item, vim.bo.filetype)
                if highlights_info ~= nil then
                  return highlights_info.text
                else
                  return ctx.label
                end
              end,
              highlight = function(ctx)
                local highlights_info = require("colorful-menu").highlights(ctx.item, vim.bo.filetype)
                local highlights = {}
                if highlights_info ~= nil then
                  for _, info in ipairs(highlights_info.highlights) do
                    table.insert(highlights, {
                      info.range[1],
                      info.range[2],
                      group = ctx.deprecated and "BlinkCmpLabelDeprecated" or info[1],
                    })
                  end
                end
                for _, idx in ipairs(ctx.label_matched_indices) do
                  table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                end
                return highlights
              end,
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 100,
        update_delay_ms = 50,
        window = {
          scrollbar = true,
        },
      },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      cmdline = {},
    },
  },
  opts_extend = { "sources.default" },
}
