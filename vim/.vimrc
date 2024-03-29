" Author:        pdotl <Lovepreet Singh>
" Description:   My vim configuration file.

" So vim doesn't behave like vi
set nocompatible

" Finding files:

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" TAG JUMPING
" Create the `tags` file
" Ensure exuberant-ctags is installed instead of emacs-etags
command! MakeTags !ctags -R .
" ^] for reaching
" g^] for searching

" Setting the leader
let mapleader = ','
let maplocalleader = '\'

" The default 20 isn't nearly enough
set history=200

" Show the numbers on the left of the screen
set number

" Set relative numbering
set relativenumber

" Show the column/row
set ruler

" Set mouse to not select line numbers
set mouse=a

" Enable syntax and plugins
syntax on
filetype plugin on

" Show the matching when doing a search
set showmatch

" Allows the backspace to delete indenting, end of lines, and over the start
" of insert
set backspace=indent,eol,start

" Ignore case when doing a search as well as highlight it as it is typed
set ignorecase smartcase
set hlsearch
set incsearch

" Don't show the startup message
set shortmess=I

" Show the current command at the bottom
set showcmd

" Disable beeping and flashing.
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Use smarter defaults
set smartindent
set smarttab

" Use autoindenting
set autoindent

" The tabstop look best at 4 spacing
set tabstop=4
set softtabstop=4
set shiftwidth=4

" I have been converted to the dark side, I will use spaces to indent code
" from here on out
set expandtab

" Buffer Settings
set hidden

" Better completion
set completeopt+=longest,menuone

" Turn on persistent undo
" Thanks, Mr Wadsten: github.com/mikewadsten/dotfiles/
if has('persistent_undo')
    set undodir=~/.vim/undo//
    set undofile
    set undolevels=1000
    set undoreload=10000
endif

" Show two lines for the status line
set laststatus=2

" Always show the last line
set display+=lastline

" UTF-8
set encoding=utf-8

" When pushing j/k on a line that is wrapped, it navigates to the same line,
" just to the expected location rather than to the next line
nnoremap j gj
nnoremap k gk

" Ignore some defaults
set wildignore=*.o,*.obj,*~,*.pyc
set wildignore+=.env
set wildignore+=.env[0-9]+
set wildignore+=.git,.gitkeep
set wildignore+=.tmp
set wildignore+=.coverage
set wildignore+=*DS_Store*
set wildignore+=.sass-cache/
set wildignore+=__pycache__/
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=.tox/**
set wildignore+=.idea/**
set wildignore+=*.egg,*.egg-info
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/Library/**,*/.rbenv/**
set wildignore+=*/.nx/**,*.app

" Set on textwidth when in markdown files
autocmd FileType markdown set textwidth=80

" Smarter completion in C
autocmd FileType c set omnifunc=ccomplete#Complete

" Use 2 spaces when in Lua & Ruby
autocmd FileType lua,ruby set tabstop=2
autocmd FileType lua,ruby set shiftwidth=2


" Terminal mode (neovim)
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap <C-v><Esc> <Esc>
    highlight! link TermCursor Cursor
    highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15
endif
"
" Plugins using Vim-plug
"
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-obsession'
" Experimental
Plug 'OmniSharp/omnisharp-vim'
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'puremourning/vimspector'
Plug 'prettier/vim-prettier', { 'do': 'npm install' , 'branch' : 'release/1.x' }
Plug 'dense-analysis/ale'
Plug 'jiangmiao/auto-pairs'
call plug#end()

" NERDTree
map <F3> :NERDTreeToggle<CR>

"
" fzf mappings
"
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
map <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
" Fzf file search
map  <c-p> :GFiles<CR>
map  <c-f> :Files<CR>

" Let's give Omnisharp another shot
autocmd FileType cs nmap <silent> gd :OmniSharpGotoDefinition<CR>
autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>
autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
autocmd FileType cs nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>

let g:ale_linters = {
\ 'cs': ['OmniSharp']
\}

