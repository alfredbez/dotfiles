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

""""""""""""""""""""""""""""
" aktuelle Zeile hervorheben
""""""""""""""""""""""""""""
set cursorline
hi cursorline cterm=none term=none
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
highlight CursorLine guibg=#303000 ctermbg=234

""""""""""""""""""""""""""""""""""""""""""""""""
" Centralize backups, swapfiles and undo history
""""""""""""""""""""""""""""""""""""""""""""""""
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
    set undodir=~/.vim/undo
endif


"""""""""""""""""""""""""""""
" Show “invisible” characters
"""""""""""""""""""""""""""""
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_


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
set wildignore+=*/vendor/*
set wildignore+=*/bower_components/*
nnoremap <Leader>o :CtrlP<CR>
" Enter visual mode with <space><space>
nmap <Leader><Leader> V
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

""""""""""""""""""""""""""""""""
" Moving lines and selections with Ctrl-J and K
"""""""""""""""""""""""""""""""""
nnoremap <leader>k :m-2<cr>==
nnoremap <leader>j :m+<cr>==
inoremap <leader>j <esc>:m+<cr>==gi
inoremap <leader>k <esc>:m-2<cr>==gi
vnoremap <leader>j :m'>+<cr>gv=gv
vnoremap <leader>k :m-2<cr>gv=gv

" auto-close { and place cursor
inoremap {<CR> {<CR>}<C-o>O

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
set showcmd
set relativenumber
set undofile
set scrolloff=3
set encoding=utf-8
set colorcolumn=85

" Open splits
nmap vs :vsplit<cr>
nmap :sp :rightbelow sp<cr>

"open/toggle Nerdtree in Sidebar
nmap <C-b> :NERDTreeToggle<cr>

" move betwwen splits
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

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
let g:syntastic_mode_map={ 'mode': 'active',
                     \ 'active_filetypes': [],
                     \ 'passive_filetypes': ['xml'] }

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
