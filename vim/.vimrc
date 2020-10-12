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



set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'preservim/nerdtree'
Plugin 'itchyny/lightline.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'jiangmiao/auto-pairs'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'nvie/vim-flake8'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'dracula/vim', { 'name': 'dracula' }


autocmd vimenter * NERDTree
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }
let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
let g:ycm_key_list_accept_completion = ['<C-y>']
map <C-]> :YcmCompleter GoToImprecise<CR>
let g:ycm_global_ycm_extra_conf = '/home/mazin/.ycm_extra_conf.py'

" Gecko includes a .ycm_extra_conf.py file in the root directory.
" Update this glob path to your Gecko source code location.
let g:ycm_extra_conf_globlist = ['~/Dev/gecko/*']

" This is less secure, but this option will load any ycm config
" file found without a confirmation.
" let g:ycm_confirm_extra_conf = 0

let g:ycm_confirm_extra_conf = 0
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_semantic_triggers = {
  \   'python': [ 'import ' ]
  \ }
"=====================================================================
"Ultisnips config
" Track the engine.
Plugin 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
"=====================================================================


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
"
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
set number
syntax on
set colorcolumn=80
highlight ColorColumn ctermbg=darkgray
set noshowmode

set tabstop=4
set autoindent
set smartindent
set shiftwidth=4
set expandtab
colorscheme dracula

