" This must be first, because it changes other options as side effect
set nocp

syntax on
filetype plugin indent on

" vim-plug
call plug#begin('~/.vim/plugged')
Plug 'hzchirs/vim-material'
Plug 'mileszs/ack.vim'
Plug 'dense-analysis/ale'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'preservim/nerdtree'
" Plug 'Raimondi/delimitMate'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'embear/vim-localvimrc'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-repeat'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'ryanoasis/vim-webdevicons'
Plug 'SirVer/ultisnips'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" PHP Plugins
Plug 'StanAngeloff/php.vim'
Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
Plug 'arnaud-lb/vim-php-namespace'
Plug 'shawncplus/phpcomplete.vim'
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install --no-dev -o'}
Plug 'vim-vdebug/vdebug'
Plug 'dantleech/vim-phpnamespace'

Plug 'ludovicchabant/vim-gutentags'
Plug 'voldikss/vim-floaterm'
Plug 'vim-test/vim-test'
"Plug 'glepnir/spaceline.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'mattn/emmet-vim'
Plug 'hashivim/vim-terraform'
call plug#end()

let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('ignore_sources', {'php': ['omni']})

let g:startify_custom_header = []
let g:startify_lists = [
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]
let g:startify_enable_special = 0

" phpactor settings
"let g:phpactorPhpBin = '~/.vim/plugged/phpactor/bin'
let g:phpactorPhpBin = "/usr/bin/php7.4"

""""""""""""""""""""""""""
" use utf-8
""""""""""""""""""""""""""
scriptencoding utf-8
set encoding=utf-8

""""""""""""""""""""""""""
" Colorscheme
""""""""""""""""""""""""""
syntax enable
set background=dark
set t_Co=256
set background=dark
colorscheme vim-material

""""""""""""""""""""""""""""
" highlight current line
""""""""""""""""""""""""""""
set cursorline
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
highlight CursorLine cterm=none term=none guibg=#303000 ctermbg=black
highlight Comment cterm=none term=none guibg=none ctermbg=none

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
nnoremap <Leader>t <C-]>
" Type <Space>q to close file
nnoremap <Leader>q :q<CR>
" do not map <CR> in quickfix
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
" Type <Space>o to open a new file
nnoremap <Leader>o :CtrlP<CR>
set wildignore+=*/node_modules/*
set wildignore+=*/vendor/*
set wildignore+=*/bower_components/*
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

noremap <leader>n :bn<cr>
noremap <leader>N :bp<cr>
noremap <leader>d :bd<cr>

nnoremap <leader>. :<C-U>call phpcd#JumpToDefinition('normal')<CR>
map <C-r> :CtrlPBufTag<CR>
map <C-e> :CtrlPBuffer<CR>

nmap <silent> <leader>l <Plug>(ale_previous_wrap)
nmap <silent> <leader>L <Plug>(ale_next_wrap)

nmap <silent> <leader>T :TestNearest<CR>
nmap <silent> <leader>t :TestSuite<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" make YCM compatible with UltiSnips (using supertab)
"""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

"""""""""""""""""""""""""""""""""""""""
" edit vimrc with <leader>v
"""""""""""""""""""""""""""""""""""""""
nmap <leader>v :tabedit ~/.vimrc<CR>

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
set colorcolumn=120
autocmd FileType gitcommit set colorcolumn=50,72
set pastetoggle=<F10>

" F3: Toggle line numbers
nnoremap <F3> :set rnu! nu!<CR>

" Open splits
nmap vs :vsplit<cr>
nmap :sp :rightbelow sp<cr>

" Nerdtree
map <Leader>1 :NERDTreeToggle<CR>
map <Leader>2 :NERDTreeFind<cr>
let g:NERDTreeShowHidden=1

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
let g:airline_theme='luna'
let g:airline_powerline_fonts = 1
"let g:airline_left_sep=''
"let g:airline_right_sep=''
"let g:airline_section_x=''
"let g:airline_section_y=''
let g:airline#extensions#tabline#enabled = 1
let airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_nr_format = '%s: '

""""""""""""""""
" php-cs-fixer settings
""""""""""""""""
let g:php_cs_fixer_enable_default_mapping = 0
nnoremap <silent><leader>f :w \| :silent call PhpCsFixerFixFile()<CR>

""""""""""""""""""""""""""""""""""
" php-refactoring-browser settings
""""""""""""""""""""""""""""""""""
let g:php_refactor_command='php ~/.dotfiles/submodules/refactor.phar'

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

" Gutentags Settings
let g:gutentags_cache_dir = '~/.vim/gutentags'
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root  = ['package.json', '.git', '.hg', '.svn']
let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git']
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_extra_args = ['--tag-relative=yes', '--fields=+ailmnS']
let g:gutentags_ctags_exclude = [
\  '*.css', '*.html', '*.js',
\  '*.git', '*.svn', '*.hg',
\  'cache', 'build', 'dist', 'bin', 'node_modules', 'bower_components',
\  '*-lock.json',  '*.lock',
\  '*.min.*',
\  '*.bak',
\  '*.zip',
\  '*.pyc',
\  '*.class',
\  '*.sln',
\  '*.csproj', '*.csproj.user',
\  '*.tmp',
\  '*.cache',
\  '*.vscode',
\  '*.pdb',
\  '*.exe', '*.dll', '*.bin',
\  '*.mp3', '*.ogg', '*.flac',
\  '*.swp', '*.swo',
\  '.DS_Store', '*.plist',
\  '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png', '*.svg',
\  '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
\  '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx', '*.xls',
\]

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

"""""""""""""""""""""""""""""""""
" Vagrantfile Syntax Highlighting
"""""""""""""""""""""""""""""""""
augroup vagrant
  au!
  au BufRead,BufNewFile Vagrantfile,Vagrantfile.local set filetype=ruby
augroup END

" F1 opens documentation for php/perl function under cursor
function! BrowseDoc()
    if b:current_syntax == "php"
        silent exec "!xdg-open 'http://php.net/manual-lookup.php?pattern=<cword>'"
    elseif b:current_syntax == "perl"
        ! xdg-open "http://perldoc.perl.org/search.html?q=<cword>"
    else
        return
    endif
endfunction
map <F1> :call BrowseDoc()^M^M<CR>

""""""""""""""""""
" Git commit macro
""""""""""""""""""
let @c = 'jjjjyyggPvtPxf-;r:a '
let @b = 'f-r '
let @a = '10@b'


let g:ackprg = 'rg --vimgrep'
cnoreabbrev ag Gcd <bar> Ack!
let g:localvimrc_ask = 0

let g:ale_php_phpcs_standard = 'PSR12'
let g:vdebug_options = {
    \'break_on_open': 0
\}
let test#strategy = "neovim"
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
