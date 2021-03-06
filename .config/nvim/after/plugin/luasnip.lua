local ls = require("luasnip") --{{{

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
require("luasnip").config.setup({ store_selection_keys = "<A-p>" })

vim.cmd([[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]) --}}}

-- Virtual Text{{{
local types = require("luasnip.util.types")
ls.config.set_config({
  history = true, --keep around last snippet local to jump back
  updateevents = "TextChanged,TextChangedI", --update changes as you type
  enable_autosnippets = true,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "●", "GruvboxOrange" } },
      },
    },
    [types.insertNode] = {
    	active = {
    		virt_text = { { "●", "GruvboxBlue" } },
    	},
    },
  },
}) --}}}

-- Key Mapping --{{{

-- vim.keymap.set({ "n" }, "<Tab>", "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Esc>'")
vim.keymap.set({ "i", "s" }, "<S-Tab>", "<cmd>lua require'luasnip'.jump(-1)<Cr>")
vim.keymap.set({ "s", "s" }, "<C-n>", "<cmd>lua require('luasnip').jump(1)<Cr>")
vim.keymap.set({ "s", "s" }, "<S-Tab>", "<cmd>lua require('luasnip').jump(-1)<Cr>")
vim.keymap.set({ "i", "s" }, "<C-E>", "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'")
vim.keymap.set({ "s", "s" }, "<C-E>", "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'")

-- More Settings --

vim.cmd([[autocmd BufEnter */snippets/*.lua nnoremap <silent> <buffer> <CR> /-- End Refactoring --<CR>O<Esc>O]])
