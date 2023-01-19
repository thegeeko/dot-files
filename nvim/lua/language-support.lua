------------- highlighting via treesitters --------------
require("nvim-treesitter.configs").setup({
	ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	highlight = {
		enable = true, -- false will disable the whole extension
		additional_vim_regex_highlighting = false,
	},
	context_commentstring = {
		enable = true,
	},
})

--------------- lsp set up ------------------
--copilot
nnoremap({"<space>cb", "<cmd> Copilot<cr>" })
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

--   פּ ﯟ   some other good icons
local kind_icons = {
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

-- vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
local lsp = require("lsp-zero")
lsp.preset("recommended")

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }
	local bind = vim.keymap.set

	bind("n", "FF", "<cmd> LspZeroFormat<cr>", opts)
	-- more code  ...
end)

local cmp = require("cmp")
lsp.setup_nvim_cmp({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
		["<C-e>"] = cmp.mapping.close(),
		["<cr>"] = cmp.mapping.confirm({ select = true }),
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
			-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
			vim_item.menu = ({
				luasnip = "[Snippet]",
				buffer = "[Buffer]",
				path = "[Path]",
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = {
    {name = "crates"},
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		documentation = cmp.config.window.bordered(),
	},
	experimental = {
		ghost_text = false,
		native_menu = false,
	},
})

lsp.setup()

-- null-ls
local mason_nullls = require("mason-null-ls")
mason_nullls.setup({
	automatic_installation = true,
	automatic_setup = true,
})
mason_nullls.setup_handlers({})

-- 	buf_set_keymap('n', 'FF',  '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)

-- ----- null-ls
-- local null_ls = require('null-ls')
-- -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
-- local formatting = null_ls.builtins.formatting
-- -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
-- local diagnostics = null_ls.builtins.diagnostics
--
-- null_ls.setup {
--   debug = false,
--   sources = {
--     formatting.prettier,
--     formatting.black,
--     formatting.stylua,
--     diagnostics.flake8,
--     diagnostics.eslint
--   },
-- }
--
-- ------ language servers
-- local nvim_lsp = require('lspconfig')
--
-- -- Use an on_attach function to only map the following keys
-- -- after the language server attaches to the current buffer
-- local on_attach = function(client, bufnr)
--
--   if client.name == "tsserver" then
--     client.server_capabilities.documentFormattingProvider = false
--   end
--
-- 	local function buf_set_keymap(...)
-- 		vim.api.nvim_buf_set_keymap(bufnr, ...)
-- 	end
--
-- 	local function buf_set_option(...)
-- 		vim.api.nvim_buf_set_option(bufnr, ...)
-- 	end
--
-- 	require("lsp_signature").on_attach(client, bufnr)
--
--   -- enable complation
--   buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
--
-- 	-- Mappings.
-- 	local opts = {noremap = true, silent = false}
--
-- 	-- See `:help vim.lsp.*` for documentation on any of the below functions
-- 	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
-- 	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
-- 	buf_set_keymap('n', 'gk',  '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
-- 	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
-- 	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
-- 	buf_set_keymap('n', 'grn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
-- 	buf_set_keymap('n', 'gca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
-- 	buf_set_keymap('n', 'gee', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)
-- 	buf_set_keymap('n', '[[',  '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
-- 	buf_set_keymap('n', ']]',  '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
-- 	buf_set_keymap('n', 'sh',  ':ClangdSwitchSourceHeader<cr>', opts)
-- 	-- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
-- 	-- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
-- 	-- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)
-- end
--
-- -- Use a loop to conveniently call 'setup' on multiple servers and
-- -- map buffer local keybindings when the language server attaches
-- local servers = {'pyright', 'rust_analyzer', 'tsserver', 'cmake', 'clangd', 'bashls', 'sumneko_lua', 'tex_lab', 'tailwindcss', 'volar', 'prismals', 'zls' }
-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
--
-- for _, lsp in ipairs(servers) do
-- 	if lsp == 'sumneko_lua' then
-- 		nvim_lsp[lsp].setup {
-- 			capabilities = capabilities,
-- 			cmd = { 'lua-language-server', "-E" },
-- 			settings = {
-- 				Lua = {
-- 					runtime = {
-- 						version = 'LuaJIT',
-- 						path = vim.split(package.path, ';')
-- 					},
-- 					diagnostics = {globals = {'vim'}},
-- 					workspace = {
-- 						-- Make the server aware of Neovim runtime files
-- 						library = vim.api.nvim_get_runtime_file("", true)
-- 					},
-- 					telemetry = { enable = false }
-- 				}
-- 			}
-- 		}
-- 	else
-- 		nvim_lsp[lsp].setup {
-- 			capabilities = capabilities,
-- 			on_attach = on_attach,
-- 			flags = { debounce_text_changes = 150 }
-- 		}
-- 	end
-- end
