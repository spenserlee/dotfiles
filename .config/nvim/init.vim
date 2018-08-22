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
set clipboard=unnamedplus               " use system clipboard
set noerrorbells                        " so loud
set mouse=n                             " use mouse in normal mode
set backspace=indent,eol,start          " backspace acts sensibly

"  -------------------
"  ui
"  -------------------

scriptencoding utf-8                    " needed for listchars on windows
set encoding=utf-8                      " language encoding
set cursorline                          " highlight current line
set title                               " show what's open
set ruler                               " always show current position
set showcmd                             " display command typed
set cmdheight=2                         " height of command bar
set scrolloff=3                         " buffer line space when scrolling up/down
set sidescrolloff=5                     " buffer line space when scrolling left/right
set relativenumber                      " line numbers relative to cursor
set number                              " show absolute line numbers
set textwidth=80                        " show the 80th column
set colorcolumn=+1"
set hlsearch                            " highlight search results
set splitbelow                          " new panes appear more natural
set splitright

"set background=dark
"colorscheme default
"set t_Co=256
set background=dark

"  -------------------
"  text formatting
"  -------------------

set ignorecase                          " ignore case when searching
set smartcase                           " when searching try to be smart
set smarttab                            " be smart about tabbing
"set wrap                                " wrap text
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

" Use relative numbers by default (normal/visual), but absolue in insert mode
autocmd! BufLeave,FocusLost,InsertEnter   * set norelativenumber
autocmd! BufEnter,FocusGained,InsertLeave * set relativenumber

" return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" File to ignore for autocomplete, also used by Ctrlp
set wildignore+=*.swp,*.jpg,*.png,*.gif,*.pdf,*.bak,*.tar,*.zip,*.tgz
set wildignore+=*/.hg/*,*/.svn/*,*/.git/*
set wildignore+=*/vendor/cache/*,*/public/system/*,*/tmp/*,*/log/*,*/solr/data/*,*/.DS_Store

"  -------------------
"  mappings
"  -------------------

" pressing esc can be annoying
inoremap jj <ESC>

" esc in terminal mode to exit insert mode
:tnoremap <ESC> <C-\><C-n>

" search visually selected text, press //
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

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
"  Python stuff
"  -------------------
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'

"  -------------------
"  setup vim plug
"  -------------------
" ensure we actually have vim plug
let s:vim_plug = '~/.local/share/nvim/site/autoload/plug.vim'

if empty(glob(s:vim_plug))
    execute 'silent !curl -fLo' s:vim_plug '--create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"  -------------------
"  plugins
"  -------------------

call plug#begin('~/.local/share/nvim/plugged')

" colorschemes
Plug 'ayu-theme/ayu-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'chriskempson/base16-vim'

" functional plugins
Plug 'jiangmiao/auto-pairs' " toggle disable with ALT+P
Plug 'ctrlpvim/ctrlp.vim'   " should probably switch to fzf?
Plug 'chrisbra/Colorizer'   " highlight hex code colours

call plug#end()

"  -------------------
"  plugin settings
"  -------------------

" Use MRU as default for CTRLP
let g:ctrlp_map='<c-p>'
let g:ctrlp_cmd='CtrlPMRU'

" URXVT doesn't support true color, leave this for now
" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
" (see http://sunaku.github.io/tmux-24bit-color.html#usage )
"if (has("nvim"))
"    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"endif
"
"" For Neovim > 0.1.5 and Vim > patch 7.4.1799 <
"if (has("termguicolors"))
"   set termguicolors
"endif


let g:nord_uniform_diff_background = 1
let g:nord_underline = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1
colorscheme nord
