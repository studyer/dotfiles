set nocompatible              " be iMproved, required
filetype off                  " required
" Change mapleader
" let mapleader=","

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Elixir syntax
" Plugin 'elixir-lang/vim-elixir'

" Track the engine.
Plugin 'SirVer/ultisnips'

" " Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

" " Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-x>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" filesystem tree
Plugin 'scrooloose/nerdtree'
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
map <C-n> :NERDTreeToggle<CR>
map <Leader>n :NERDTree %:p:h<CR>

Plugin 'godlygeek/tabular'
" Plugin 'plasticboy/vim-markdown'
" let g:vim_markdown_folding_disabled=1

Plugin 'Valloric/YouCompleteMe'

Plugin 'jiangmiao/auto-pairs'

" quick google search
Plugin 'szw/vim-g'

" Plugin 'vim-ruby/vim-ruby'

Plugin 'wlangstroth/vim-racket'

" Plugin 'fatih/vim-go'

Plugin 'cakebaker/scss-syntax.vim'

Plugin 'chrisbra/Colorizer'

let g:colorizer_auto_color = 1
let g:colorizer_auto_filetype='less,sass,scss,js,css,html'
let g:colorizer_syntax = 1

Plugin 'tpope/vim-commentary'

Plugin 'Chiel92/vim-autoformat'
noremap <F3> :Autoformat<CR><CR>

Plugin 'Lokaltog/vim-easymotion'

Plugin 'rking/ag.vim'

Plugin 'vim-scripts/DrawIt'

Plugin 'tpope/vim-eunuch'

Plugin 'vim-scripts/DeleteTrailingWhitespace'

Plugin 'sheerun/vim-polyglot'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'vim-scripts/EasyGrep'
Plugin 'szw/vim-tags'
Plugin 'nvie/vim-flake8'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Use the Solarized Dark theme
" set background=light
set background=dark
colorscheme solarized
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast = "high"
let g:solarized_visibility= "high"

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Don’t add empty newlines at the end of files
set binary
set noeol
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable line numbers
set number
" Enable syntax highlighting
syntax on
" Highlight current line
set cursorline
" Make tabs as wide as two spaces
set shiftwidth=4
set tabstop=4
set expandtab
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
"set list
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Use relative line numbers
"if exists("&relativenumber")
"	set relativenumber
"	au BufReadPost * set relativenumber
"endif
" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif

au FileType scss setl sw=2 sts=2 et

set t_Co=256

" basic keymapping
noremap <leader>c :! compass compile<CR>

" elixir keymapping
noremap <leader>ed :! mix deps.get<CR>
noremap <leader>ec :! mix compile<CR>
noremap <leader>et :! mix test<CR>
noremap <leader>xt :! mix test<CR>

" golang keymapping
noremap <leader>gd :! go get<CR>
noremap <leader>gc :! make<CR>
noremap <leader>gt :! make test<CR>


" web page
noremap <leader>eh :! open http://elixir-lang.org/docs/stable/elixir/<CR>
noremap <leader>exh :! open http://www.phoenixframework.org/v0.9.0/docs<CR>
noremap <leader>ehp :! open https://hex.pm<CR>

noremap <leader>gh :! open https://github.com<CR>

