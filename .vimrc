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
colorscheme ego
set t_Co=256

"""""""""""""""""""""""
" Datei-Icons anzeigen
""""""""""""""""""""""""
set guifont=Sauce\ Code\ Powerline\ Plus\ Nerd\ File\ Types\ Mono.otf\ 11

""""""""""""""""""""""""""""
" highlight current line
""""""""""""""""""""""""""""
set cursorline
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
highlight CursorLine cterm=none term=none guibg=#303000 ctermbg=black

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
autocmd FileType nerdtree setlocal nolist
" F4: Toggle list (display unprintable characters).
nnoremap <F4> :set list!<CR>

""""""""""""""""""""""""""
" Keybindings
""""""""""""""""""""""""""
let mapleader = "\<Space>"
nnoremap t <C-]>
" Type <Space>q to close file
nnoremap <Leader>q :q<CR>
" Type <Enter> to write file
map <Enter> :w<CR>
" do not map <CR> in quickfix
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
" Type <Space>o to open a new file
nnoremap <Leader>o :CtrlP<CR>
set wildignore+=*/node_modules/*
set wildignore+=*/vendor/*
set wildignore+=*/bower_components/*
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
nnoremap <C-d> :call pdv#DocumentWithSnip()<CR>
" Enter visual line mode with <space><space>
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

" auto-close { and place cursor
inoremap {<CR> {<CR>}<C-o>O

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" make YCM compatible with UltiSnips (using supertab)
"""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

"""""""""""""""""""""""""""""""""""""""
" edit vimrc with <leader>v
"""""""""""""""""""""""""""""""""""""""
nmap <leader>v :tabedit $MYVIMRC<CR>

"""""""""""""""""""""""""""""
" improved search and replace
"""""""""""""""""""""""""""""
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
" search for visually selected text
vnoremap // y/<C-R>"<CR>

""""""""""""""""""""""""""
" my config
""""""""""""""""""""""""""
set smarttab
set tags=tags;/
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
                                            " shiftwidth, not tabstop
set hlsearch                                " highlight search terms
set incsearch                               " show search matches as you type
set laststatus=2
set timeout timeoutlen=200 ttimeoutlen=100
set visualbell                              " don't beep
set noerrorbells                            " don't beep
set autowrite                               " Save on buffer switch
set showcmd
set relativenumber
set undofile
set scrolloff=3
set encoding=utf-8
set colorcolumn=85
set pastetoggle=<F10>

" F3: Toggle line numbers
nnoremap <F3> :set rnu! nu!<CR>

" Open splits
nmap vs :vsplit<cr>
nmap :sp :rightbelow sp<cr>

" Nerdtree
nmap <C-b> :NERDTreeToggle<cr>
nmap <F6> :NERDTreeFind<cr>


" move betwwen splits
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

" Quickly go forward or backward to buffer
nmap :bp :BufSurfBack<cr>
nmap :bn :BufSurfForward<cr>
noremap <leader>n :bn<cr>
noremap <leader>p :bp<cr>
noremap <leader>d :bd<cr>
noremap <leader>b :buffer

highlight Search cterm=underline

autocmd cursorhold * set nohlsearch
autocmd cursormoved * set hlsearch

noremap <leader>h :noh<cr>

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
let g:airline#extensions#tabline#enabled = 1
let airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_nr_format = '%s: '

""""""""""""""""
" php-cs-fixer settings
""""""""""""""""
let g:php_cs_fixer_enable_default_mapping = 0
nnoremap <silent><leader>f :silent call PhpCsFixerFixFile()<CR>

""""""""""""""""""""""""""""""""""
" php-refactoring-browser settings
""""""""""""""""""""""""""""""""""
let g:php_refactor_command='php ~/.dotfiles/submodules/refactor.phar'

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
nnoremap <F9> :SyntasticToggleMode<CR>

""""""""""""""""
" text bubbling
""""""""""""""""
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

""""""""""""""""""""""""""""""""""""""""""""""
" automatically jump to end of text you pasted
""""""""""""""""""""""""""""""""""""""""""""""
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

"select pasted text
noremap gV `[v`]

" show tags
nmap <F8> :TagbarToggle<CR>

""""""""""""""""
" emmet Settings
""""""""""""""""
let g:user_emmet_mode='a'    "enable all function in all mode.
let g:user_emmet_install_global = 0
autocmd FileType html,css,scss EmmetInstall

"""""""""""""""""""""""
" EditorConfig Settings
"""""""""""""""""""""""
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
let g:EditorConfig_exec_path = '/usr/bin/editorconfig'

""""""""""""""""""""
" Make Ctrl-P faster
""""""""""""""""""""
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

"""""""""""""""""""""""""
" PHP Syntax Optimization
"""""""""""""""""""""""""
function! PhpSyntaxOverride()
  hi! def link phpDocTags  phpDefine
  hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END
