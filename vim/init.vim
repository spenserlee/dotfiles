"  -------------------
"  general
"  -------------------

syntax on
filetype plugin indent on
let mapleader = " "
set autoread                            " update files if changed externally
set history=1000                        " command history
set undofile                            " save mistakes
set undolevels=1000
set undoreload=1000
set clipboard=unnamed                   " use system clipboard
set noerrorbells                        " so loud
set mouse=ni                            " use mouse in normal and insert mode
set backspace=indent,eol,start          " backspace acts sensibly

"  -------------------
"  ui
"  -------------------

scriptencoding utf-8                    " needed for listchars on windows
set encoding=utf-8                      " language encoding
set title                               " show what's open
set ruler                               " always show current position
set showcmd                             " display command typed
set cmdheight=2                         " height of command bar
set scrolloff=10                        " buffer line space when scrolling up/down
set sidescrolloff=5                     " buffer line space when scrolling left/right
set number                              " absolue line numbers
"set relativenumber                      " line number relative to cursor
set hlsearch                            " highlight search results
set splitbelow                          " new panes appear more natural
set splitright

set t_Co=256
set background=dark
"colorscheme desert

"  -------------------
"  text formatting
"  -------------------

set ignorecase                          " ignore case when searching
set smartcase                           " when searching try to be smart
set smarttab                            " be smart about tabbing
set wrap                                " wrap text
set expandtab                           " tabs = spaces
set shiftwidth=4                        " 1 tab == 4 spaces as it should be
set tabstop=4
set ai                                  " auto indent
set si                                  " smart indent
set list                                " visualize whitespace
set listchars=tab:→→,trail:⋅,nbsp:⋅     " characters to show

"  -------------------
"  misc
"  -------------------

" return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" File to ignore for autocomplete, also used by Ctrlp
set wildignore+=*.swp,*.jpg,*.png,*.gif,*.pdf,*.bak,*.tar,*.zip,*.tgz
set wildignore+=*/.hg/*,*/.svn/*,*/.git/*
set wildignore+=*/vendor/cache/*,*/public/system/*,*/tmp/*,*/log/*,*/solr/data/*,*/.DS_Store

"  -------------------
"  mappings
"  -------------------

" disable ex mode
noremap Q <NOP>

" leader+/ clears search highlighting
map <silent> <Leader>/ :noh<CR>

" spell checking
map <Leader>ss :setlocal spell!<CR> 

map <Leader>sn ]s
map <Leader>sp [s
map <Leader>sa zg
map <Leader>s? z=

" window navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" tab navigation
map <Leader>tn :tabnew<CR>
map <Leader>to :tabonly<CR>
map <Leader>tc :tabclose<CR>
map <Leader>tm :tabmove 
map <Leader>t<Leader> :tabnext 

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <Leader>te :tabedit <c-r>=expand("%:p:h")<CR>/

"  -------------------
"  setup vim plug
"  -------------------
" ensure we actually have vim plug
let s:vim_plug = '~/.local/share/nvim/site/autoload/plug.vim'

" if we dont have vimplug yet use this to disable erring first run sections
let s:first_run = 0
if empty(glob(s:vim_plug, 1))
    let s:first_run = 1
    execute 'silent !curl -fLo' s:vim_plug '--create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

"  -------------------
"  plugins
"  -------------------

call plug#begin('~/.local/share/nvim/plugged')

" colorschemes
Plug 'joshdick/onedark.vim'
Plug 'cocopon/iceberg.vim'

" functional plugins


call plug#end()

"  -------------------
"  plugin settings
"  -------------------

if s:first_run == 0
    colorscheme iceberg
endif
