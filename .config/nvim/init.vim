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
"set title                               " show what's open
set ruler                               " always show current position
set showcmd                             " display command typed
set cursorline                          " highlight current line
set cmdheight=2                         " height of command bar
set scrolloff=3                        " buffer line space when scrolling up/down
set sidescrolloff=5                     " buffer line space when scrolling left/right
set relativenumber                      " line numbers relative to cursor
set number                              " show absolute line numbers
set textwidth=80                        " show the 80th column
set colorcolumn=+1"
set hlsearch                            " highlight search results
set splitbelow                          " new panes appear more natural
set splitright

set t_Co=256
set background=dark
colorscheme default

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
nnoremap gb :ls<CR>:b<Space>
" pressing esc can be annoying
inoremap jj <ESC>

" disable ex mode
noremap Q <NOP>

" Leader+/ clears search highlighting
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

map <Leader>z :tab split<CR>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <Leader>te :tabedit <c-r>=expand("%:p:h")<CR>/

" Open fuzzy finder
map <C-p> :FZF

" <C-:>w<CR> can get a little old.
map <Leader>w :w<CR>

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
"  Python stuff
"  -------------------
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'

"   -------------------
"   plugins
"   -------------------

call plug#begin('~/.local/share/nvim/plugged')

" colorschemes
Plug 'morhetz/gruvbox'

" functional plugins
Plug 'jiangmiao/auto-pairs'
Plug 'https://github.com/google/vim-searchindex'
Plug 'https://github.com/machakann/vim-highlightedyank'
Plug 'https://github.com/tpope/vim-commentary'
Plug '~/.fzf'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}

call plug#end()

"  -------------------
"  plugin settings
"  -------------------

" FZF settings

    map <Leader>p :FZFMru<CR>

    " TODO: submit pull request to update example to use fzf#wrap
    " https://github.com/junegunn/fzf/wiki/Examples-(vim)#filtered-voldfiles-and-open-buffers
    command! FZFMru call fzf#run(fzf#wrap(
    \ { 'source':  reverse(s:all_files()),
    \   'options': '-m -x +s',
    \   'down':    '40%' }))

    function! s:all_files()
      return extend(
      \ filter(copy(v:oldfiles),
      \        "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
      \ map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))
    endfunction

" End FZF settings

" COC vim settings

    " if hidden is not set, TextEdit might fail.
    set hidden

    " Some servers have issues with backup files, see #649
    set nobackup
    set nowritebackup

    " Better display for messages
    set cmdheight=2

    " Smaller updatetime for CursorHold & CursorHoldI
    set updatetime=300

    " don't give |ins-completion-menu| messages.
    set shortmess+=c

    " always show signcolumns
    set signcolumn=yes

    " Use tab for trigger completion with characters ahead and navigate.
    " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <C-Space> coc#refresh()

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
    " Coc only does snippet and additional edit on confirm.
    inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    " Use `[c` and `]c` to navigate diagnostics
    nmap <silent> [c <Plug>(coc-diagnostic-prev)
    nmap <silent> ]c <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Remap for rename current word
    nmap <Leader>rn <Plug>(coc-rename)

    " Remap for format selected region
    xmap <Leader>f  <Plug>(coc-format-selected)
    nmap <Leader>f  <Plug>(coc-format-selected)

    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Remap for do codeAction of selected region, ex: `<Leader>aap` for current paragraph
    xmap <Leader>a  <Plug>(coc-codeaction-selected)
    nmap <Leader>a  <Plug>(coc-codeaction-selected)

    " Remap for do codeAction of current line
    nmap <Leader>ac  <Plug>(coc-codeaction)
    " Fix autofix problem of current line
    nmap <Leader>qf  <Plug>(coc-fix-current)

    " Use `:Format` to format current buffer
    command! -nargs=0 Format :call CocAction('format')

    " Use `:Fold` to fold current buffer
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " use `:OR` for organize import of current buffer
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Add diagnostic info for https://github.com/itchyny/lightline.vim
    let g:lightline = {
          \ 'colorscheme': 'wombat',
          \ 'active': {
          \   'left': [ [ 'mode', 'paste' ],
          \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
          \ },
          \ 'component_function': {
          \   'cocstatus': 'coc#status'
          \ },
          \ }



    " Using CocList
    " Show all diagnostics
    " nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions
    " nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    " Show commands
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document
    nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols
    nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    " nnoremap <silent> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    " nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list
    " nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" end of COC vim settings

if has('win32')
  nmap <C-/> gcc<Space>
  vmap <C-/> gc<Space>
else
  nmap <C-_> gcc<Space>
  vmap <C-_> gc<Space>
endif

" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
" (see http://sunaku.github.io/tmux-24bit-color.html#usage )
" if (has("nvim"))
"     let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" endif

" For Neovim > 0.1.5 and Vim > patch 7.4.1799 <
" if (has("termguicolors"))
"     set termguicolors
" endif

colorscheme gruvbox
set bg=dark
