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
Plug 'lewis6991/gitsigns.nvim',
Plug 'onsails/lspkind.nvim',
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
Plug 'ibhagwan/fzf-lua',
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
" Plug 'miikanissi/modus-themes.nvim',
Plug 'EdenEast/nightfox.nvim',
Plug 'catppuccin/nvim', { 'as': 'catppuccin' },
Plug 'igankevich/mesonic',

" Initialize plugin system
 call plug#end()

" ========================================================================
set encoding=utf-8
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
set listchars+=space:.,eol:↴
syntax off
let g:tex_flavor = 'latex'
let g:livepreview_previewer = 'zathura'
let g:UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
let g:UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
let g:UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" lua stuff
lua require('config')
