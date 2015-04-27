" This must be first, because it changes other options as side effect
set nocp

""""""""""""""""""""""""""
" pathogen init
""""""""""""""""""""""""""
execute pathogen#infect()
syntax on
filetype plugin indent on

""""""""""""""""""""""""""
" solarized - Colorscheme
""""""""""""""""""""""""""
syntax enable
set background=dark
colorscheme solarized
set t_Co=256

"""""""""""""""""""""""
" Datei-Icons anzeigen
""""""""""""""""""""""""
set guifont=Sauce\ Code\ Powerline\ Plus\ Nerd\ File\ Types\ Mono.otf\ 11

""""""""""""""""""""""""""""""""""""""""""""""""
" Moving lines and selections with Ctrl-J and K
""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <c-k> :m-2<cr>==
nnoremap <c-j> :m+<cr>==
inoremap <c-j> <esc>:m+<cr>==gi
inoremap <c-k> <esc>:m-2<cr>==gi
vnoremap <c-j> :m'>+<cr>gv=gv
vnoremap <c-k> :m-2<cr>gv=gv

""""""""""""""""""""""""""""
" aktuelle Zeile hervorheben
""""""""""""""""""""""""""""
set cursorline
hi cursorline cterm=none term=none
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
highlight CursorLine guibg=#303000 ctermbg=234


""""""""""""""""""""""""""
" Keybindings
""""""""""""""""""""""""""
let mapleader = "\<Space>"
" Type <Space>q to close file
nnoremap <Leader>q :q<CR>
" Type <Space>w to save file
nnoremap <Leader>w :w<CR>
" Type <Space>o to open a new file
set wildignore+=*/node_modules/*
nnoremap <Leader>o :CtrlP<CR>
" Copy & paste to system clipboard with <Space>p and <Space>y
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
" Enter visual mode with <space><space>
nmap <Leader><Leader> V
" expand selection to character, word, block
" v: Selection erweitern
" CTRL + v: Selection verringern
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

"""""""""""""""""""""""""""""
" improved search and replace
"""""""""""""""""""""""""""""
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>
" search for visually selected text
vnoremap // y/<C-R>"<CR>

""""""""""""""""""""""""""
" my config
""""""""""""""""""""""""""
set smarttab
set tags=tags
set softtabstop=4                           " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                               " expand tabs by default (overloadable per file type later)
set nowrap                                  " don't wrap lines
set tabstop=4                               " a tab is four spaces
set backspace=indent,eol,start              " allow backspacing over everything in insert mode
set autoindent                              " always set autoindenting on
set copyindent                              " copy the previous indentation on autoindenting
set number                                  " always show line numbers
set shiftwidth=4                            " number of spaces to use for autoindenting
set shiftround                              " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch                               " set show matching parenthesis
set ignorecase                              " ignore case when searching
set smartcase                               " ignore case if search pattern is all lowercase,
                                            "   case-sensitive otherwise
set smarttab                                " insert tabs on the start of a line according to
                                            "shiftwidth, not tabstop
set hlsearch                                " highlight search terms
set incsearch                               " show search matches as you type
set laststatus=2
set timeout timeoutlen=200 ttimeoutlen=100
set visualbell                              " don't beep
set noerrorbells                            " don't beep
set autowrite                               "Save on buffer switch
set mouse=a
set showcmd
set relativenumber
set undofile
set scrolloff=3
set encoding=utf-8
set colorcolumn=85

" Open splits
nmap vs :vsplit<cr>
nmap sp :split<cr>

"Resize vsplit
nmap <C-v> :vertical resize +5<cr>
nmap 25 :vertical resize 40<cr>
nmap 75 :vertical resize 120<cr>

"open/toggle Nerdtree in Sidebar
nmap <C-b> :NERDTreeToggle<cr>

" Create split below
nmap :sp :rightbelow sp<cr>

" move betwwen splits
nnoremap <C-z> <C-W><C-J>
nnoremap <C-u> <C-W><C-K>
nnoremap <C-i> <C-W><C-L>
nnoremap <C-o> <C-W><C-H>

" Quickly go forward or backward to buffer
nmap :bp :BufSurfBack<cr>
nmap :bn :BufSurfForward<cr>

highlight Search cterm=underline

autocmd cursorhold * set nohlsearch
autocmd cursormoved * set hlsearch

" strip trailing whitespace
autocmd FileType javascript,html,php,css,vim autocmd BufWritePre <buffer> StripWhitespace
" Convert Tabs to Spaces
autocmd BufWritePre <buffer> retab

"""""""""""""""""""""""
" Airline Einstellungen
"""""""""""""""""""""""
let g:airline_theme='powerlineish'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_section_z=''

""""""""""""""""
" Syntax-Check
""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

""""""""""""""""""""""""""""""""""""""""""""""
" automatically jump to end of text you pasted
""""""""""""""""""""""""""""""""""""""""""""""
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]
" select pasted text
noremap gV `[v`]

" show tags
nmap <F8> :TagbarToggle<CR>

" emmet
let g:user_emmet_mode='a'    "enable all function in all mode.
let g:user_emmet_install_global = 0
autocmd FileType html,css,scss EmmetInstall
