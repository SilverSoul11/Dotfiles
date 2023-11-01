require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = {"c", "lua", "rust", "javascript"},

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- List of parsers to ignore installing (for "all")
    ignore_install = {},

    indent = {enable = false},

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        disable = {},

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false
    }
}

require("nvim-autopairs").setup {}
local cmp = require 'cmp'
-- local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

cmp.setup({
    snippet = {
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
            vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Select
        })),
        ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Select
        })),
        ['<Tab>'] = cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Replace
        })
    }),
    sources = cmp.config.sources({
        {name = 'nvim_lsp'}, -- { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'snippy' }, -- For snippy users.
        {name = 'ultisnips'}, -- For ultisnips users.
        {name = 'path'} -- For ultisnips users.
    }, {{name = 'buffer'}})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        {name = 'cmp_git'} -- You can specify the `cmp_git` source if you were installed it.
    }, {{name = 'buffer'}})
})

require"lsp_signature".setup(cfg)

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {{name = 'buffer'}}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = {noremap = true, silent = true, buffer = bufnr}
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder,
                   bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilties

require('lspconfig')['clangd'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags
}

require'lspconfig'.jedi_language_server.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags
}

require'lspconfig'.flow.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags
}

require('lspconfig').eslint.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags
}

require('lspconfig').tsserver.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags
}

require('texmagic').setup {}

require('lspconfig').texlab.setup {
    cmd = {"texlab"},
    filetypes = {"bib", "plaintex", "tex"},
    settings = {
        texlab = {
            rootDirectory = nil,
            build = _G.TeXMagicBuildConfig,
            forwardSearch = {executable = "zathura", args = {"%p"}}
        }
    }
}

require'lspconfig'.rust_analyzer.setup {
    settings = {['rust-analyzer'] = {diagnostics = {enable = false}}},
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags
}

cfg = {
    debug = false, -- set to true to enable debug logging
    log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
    -- default is  ~/.cache/nvim/lsp_signature.log
    verbose = false, -- show debug line number

    bind = true, -- This is mandatory, otherwise border config won't get registered.
    -- If you want to hook lspsaga or other signature handler, pls set to false
    doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
    -- set to 0 if you DO NOT want any API comments be shown
    -- This setting only take effect in insert mode, it does not affect signature help in normal
    -- mode, 10 by default

    max_height = 12, -- max height of signature floating_window
    max_width = 80, -- max_width of signature floating_window
    noice = false, -- set to true if you using noice to render markdown
    wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long

    floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

    floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
    -- will set to true when fully tested, set to false will use whichever side has more space
    -- this setting will be helpful if you do not want the PUM and floating win overlap

    floating_window_off_x = 1, -- adjust float windows x position.
    -- can be either a number or function
    floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
    -- can be either number or function, see examples

    -- close_timeout = 4000, -- close floating window after ms when laster parameter is entered
    fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
    hint_enable = true, -- virtual hint enable
    hint_prefix = "", -- for parameter, NOTE: for the terminal not support emoji, might crash
    hint_scheme = "String",
    hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
    handler_opts = {
        border = "none" -- double, rounded, single, shadow, none, or a table of borders
    },

    always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

    auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
    extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
    zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

    padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

    transparency = nil, -- disabled by default, allow floating win transparent value 1~100
    shadow_blend = 36, -- if you using shadow as border use this set the opacity
    shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
    timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
    toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'

    select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
    move_cursor_key = nil -- imap, use nvim_set_current_win to move cursor between current win and floating
}

require("ibl").setup{
	indent = {
		char = "┇",
	},

	scope = {
		show_start =  false,
		show_end = false,
	}
}

require("nvim-surround").setup({
    -- Configuration here, or leave empty to use defaults
})

