-- Blink completion
vim.pack.add({
  'https://github.com/rafamadriz/friendly-snippets',
  'https://github.com/xzbdmw/colorful-menu.nvim',
  'https://github.com/saghen/blink.cmp',
})

require("colorful-menu").setup({
  ls = {
    ["rust-analyzer"] = {
      extra_info_hl = "@comment",
      align_type_to_right = true,
      preserve_type_when_truncate = true,
    },
    lua_ls = {
      arguments_hl = "@comment",
    },
    gopls = {
      align_type_to_right = true,
      preserve_type_when_truncate = true,
    },
    clangd = {
      extra_info_hl = "@comment",
      align_type_to_right = true,
      preserve_type_when_truncate = true,
    },
    ts_ls = {
      extra_info_hl = "@comment",
    },
    fallback = true,
  },
  max_width = 60,
})

require("blink.cmp").setup({
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
        columns = { { "kind_icon" }, { "label", gap = 1 } },
        components = {
          label = {
            text = function(ctx)
              local ok, text = pcall(require("colorful-menu").blink_components_text, ctx)
              if ok then
                return text
              end
              return ctx.label
            end,
            highlight = function(ctx)
              local ok, highlight = pcall(require("colorful-menu").blink_components_highlight, ctx)
              if ok then
                return highlight
              end
              return {}
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
    default = { "lsp", "path", "snippets" },
  },
  cmdline = { enabled = false },
})
