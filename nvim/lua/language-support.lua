------------- highlighting via treesitters --------------
require'nvim-treesitter.configs'.setup {
	ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	highlight = {
		enable = true, -- false will disable the whole extension
		additional_vim_regex_highlighting = false
	}
}

--------------- lsp set up ------------------
------ autocmp
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
local cmp = require 'cmp'
cmp.setup({
	snippet = {
		expand = function(args) require('luasnip').lsp_expand(args.body) end
	},
	mapping = {
		['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
		['<C-e>'] = cmp.mapping.close(),
		['<cr>'] = cmp.mapping.confirm({select = true})
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'buffer' },
		{ name = 'path' },
		{ name = 'nvim-lua' },
		{ name = 'treesitter' },
		{ name = 'spell' }
	}
})

------ language servers
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	require("lsp_signature").on_attach(client, bufnr)

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = {noremap = true, silent = true}

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
	buf_set_keymap('n', 'gk',  '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
	buf_set_keymap('n', 'grr', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
	buf_set_keymap('n', 'gca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
	buf_set_keymap('n', 'gee', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)
	buf_set_keymap('n', '[[',  '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
	buf_set_keymap('n', ']]',  '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
	buf_set_keymap('n', 'FF',  '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
	buf_set_keymap('n', 'sh',  ':ClangdSwitchSourceHeader<cr>', opts)
	-- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
	-- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
	-- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {'pyright', 'rust_analyzer', 'tsserver', 'clangd', 'bashls', 'sumneko_lua', 'tex_lab', 'tailwindcss', 'volar' }
for _, lsp in ipairs(servers) do
	if lsp == 'sumneko_lua' then
		nvim_lsp[lsp].setup {
			capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
			cmd = { 'lua-language-server', "-E" },
			settings = {
				Lua = {
					runtime = {
						version = 'LuaJIT',
						path = vim.split(package.path, ';')
					},
					diagnostics = {globals = {'vim'}},
					workspace = {
						-- Make the server aware of Neovim runtime files
						library = vim.api.nvim_get_runtime_file("", true)
					},
					telemetry = { enable = false }
				}
			}
		}
	else
		nvim_lsp[lsp].setup {
			capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
			on_attach = on_attach,
			flags = { debounce_text_changes = 150 }
		}
	end
end
