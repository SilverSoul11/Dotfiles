"__/\\\________/\\\___/\\\\\\\\\\\___/\\\\____________/\\\\_
"_\/\\\_______\/\\\__\/////\\\///___\/\\\\\\________/\\\\\\_
" _\//\\\______/\\\_______\/\\\______\/\\\//\\\____/\\\//\\\_
"  __\//\\\____/\\\________\/\\\______\/\\\\///\\\/\\\/_\/\\\_
"   ___\//\\\__/\\\_________\/\\\______\/\\\__\///\\\/___\/\\\_
"    ____\//\\\/\\\__________\/\\\______\/\\\____\///_____\/\\\_
"     _____\//\\\\\___________\/\\\______\/\\\_____________\/\\\_
"      ______\//\\\_________/\\\\\\\\\\\__\/\\\_____________\/\\\_
"       _______\///_________\///////////___\///______________\///__
"  vim.rc file
"



" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
 call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'nvim-lualine/lualine.nvim',
Plug 'nvim-tree/nvim-web-devicons',
Plug 'airblade/vim-gitgutter',
Plug 'windwp/nvim-autopairs',
Plug 'kylechui/nvim-surround',
Plug 'tpope/vim-commentary',
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'honza/vim-snippets',
Plug 'tpope/vim-dispatch',
Plug 'nvim-treesitter/nvim-treesitter',
Plug 'nvim-treesitter/nvim-treesitter-textobjects',
Plug 'neovim/nvim-lspconfig',
Plug 'junegunn/fzf',
Plug 'junegunn/fzf.vim',
Plug 'hrsh7th/cmp-nvim-lsp',
Plug 'hrsh7th/cmp-buffer',
Plug 'hrsh7th/cmp-path',
Plug 'hrsh7th/cmp-cmdline',
Plug 'hrsh7th/nvim-cmp',
Plug 'SirVer/ultisnips',
Plug 'sbdchd/neoformat',
Plug 'quangnguyen30192/cmp-nvim-ultisnips',
Plug 'ray-x/lsp_signature.nvim',
Plug 'lukas-reineke/indent-blankline.nvim',
Plug 'jakewvincent/texmagic.nvim',
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' },
Plug 'catppuccin/nvim', { 'as': 'catppuccin' },
Plug 'miikanissi/modus-themes.nvim',
Plug 'bluz71/vim-moonfly-colors', { 'as': 'moonfly' },
Plug 'igankevich/mesonic',

" Initialize plugin system
 call plug#end()

" ========================================================================
colorscheme modus_vivendi

set relativenumber number
set colorcolumn=81
set noshowmode
set laststatus=2
set encoding=utf-8
set fileencoding=utf-8
set completeopt=menu,menuone,noselect
set shortmess+=I
set cursorline
set cursorlineopt=number
set list
set listchars+=eol:↴
let g:tex_flavor = 'latex'
let g:livepreview_previewer = 'zathura'
let g:UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
let g:UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
let g:UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'

" lua stuff
lua require('config')
