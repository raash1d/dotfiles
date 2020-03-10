source ~/.vim/vim_keybindings.vim
source ~/.vim/vim_plugins.vim

" Appearance {
    set wrap " turn on line wrapping
    set wrapmargin=8 " wrap lines when coming within n characters from side
    set linebreak " set soft wrapping
    set showbreak=… " show ellipsis at breaking
    syntax on

    " Enable true color
    if exists('+termguicolors')
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      set termguicolors
    endif

    " OneHalf Theme {
      let hour = strftime("%H")
      if hour >= 11 && hour < 4 + 12
        colorscheme onehalflight
        let g:airline_theme='onehalflight'
      else
        colorscheme onehalfdark
        let g:airline_theme='onehalfdark'
      endif

      set t_Co=256
      set cursorline
      " lightline
      " let g:lightline.colorscheme='onehalfdark'
    " }
    " Dracula Theme {
      "let g:airline_theme='dracula'
      "colorscheme dracula
    " }
    " Vim-One theme {
      "let g:airline_theme='one'
      "colorscheme one
      "set background=light " for the light version
      "set background=dark " for the light version
    " }

    filetype plugin indent on
    set relativenumber

    "make the highlighting of tabs and other non-text less annoying
    highlight SpecialKey ctermfg=236
    highlight NonText ctermfg=236

    set encoding=utf-8
    set guifont=RobotoMono\ Nerd\ Font\ Mono\ 10
    set colorcolumn=80
    set number
    set ttyfast
    set cmdheight=1 "command bar height
    set showmatch "show matching braces
    set hlsearch "highlight all matching search pattern
    let &winheight = &lines * 7 / 10
    let &winwidth = &columns * 7 / 10
    "Airline {
        let g:airline_powerline_fonts=1
        let g:airline_left_sep=''
        let g:airline_right_sep=''
        let g:airline#extensions#tabline#show_splits = 0
        let g:airline#extensions#whitespace#enabled = 0
        " enable airline tabline
        let g:airline#extensions#tabline#enabled = 1
        " only show tabline if tabs are being used (more than 1 tab open)
        let g:airline#extensions#tabline#tab_min_count = 2
        " do not show open buffers in tabline
        let g:airline#extensions#tabline#show_buffers = 0
        " Show errors in airline from ALE
        let g:airline#extensions#ale#enabled = 1
    " }
" }

" signify {
  let g:signify_vcs_list = [ 'git' ]
  let g:signify_sign_add = '+'
  let g:signify_sign_delete = '_'
  let g:signify_sign_delete_first_line = '‾'
  let g:signify_sign_change = '~'
" }

" vim-autopep-8 {
  "let g:autopep8_indent_size = 2
  "let g:autopep8_on_save = 1
" }

" vim-flake8 {
  "autocmd BufWritePost *.py call Flake8()
  "let g:flake8_show_in_gutter=1
  "call flake8#Flake8UnplaceMarkers()
" }

" syntastic {
  let g:syntastic_always_populate_loc_list=0
  let g:syntastic_auto_loc_list=0
  let g:syntastic_check_on_open=0
  let g:syntastic_check_on_wq=0
  let g:syntastic_warning_symbol='WW'
  let g:syntastic_error_symbol='EE'
  let g:syntastic_quiet_messages={ 'regex' : ['E111',
        \ 'E114',
        \ 'superfluous-parens',
        \ 'missing-docstring',
        \ 'too-many-locals'] }
" }

" vim-fugitive {
    nmap <silent> <leader>gs :Gstatus<cr>
    nmap <leader>ge :Gedit<cr>
" }

" vim-pasta and ctrl-p conflict resolution {
  let g:pasta_disabled_filetypes = ['ctrlp']
" }

" NERDTree {
    " Toggle NERDTree
    function! ToggleNerdTree()
        if @% != "" && (!exists("g:NERDTree") || (g:NERDTree.ExistsForTab() && !g:NERDTree.IsOpen()))
            :NERDTreeFind
        else
            :NERDTreeToggle
        endif
    endfunction
    " toggle nerd tree
    nmap <silent> <leader>n :call ToggleNerdTree()<cr>
    " find the current file in nerdtree without needing to reload the drawer
    nmap <silent> <leader>f :NERDTreeFind<cr>
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    "autocmd VimEnter * if &filetype == 'c' || &filetype == 'cpp' || &filetype == 'python' ||  | NERDTreeToggle | endif
    "autocmd VimEnter * NERDTree
    "autocmd BufEnter * NERDTreeMirror
    "autocmd VimEnter * wincmd p

    "let NERDTreeShowHidden=1
    "let NERDTreeDirArrowExpandable = '▷'
    "let NERDTreeDirArrowCollapsible = '▼'
    let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
" }

if has('mac')
" ALE {
    let g:ale_sign_error = '✖'
    let g:ale_sign_warning = '⚠'

    "let g:ale_linters = {
    "\    'javascript': ['eslint'],
    "\    'typescript': ['tsserver', 'tslint'],
    "\    'html': []
    "\}
" }
endif

" 1 is the blinky block cursor
" 2 is the default (non-blinky) block cursor
" 3 is blinky underscore
" 4 fixed underscore
" 5 pipe bar (blinking)
" 6 fixed pipe bar
" Change cursor to pipe (|) in insert mode
"au InsertEnter * silent execute \"!echo -en \<esc>[5 q"
"au InsertLeave * silent execute \"!echo -en \<esc>[1 q"
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" Mouse scrolling
nmap <ScrollWheelUp> <C-Y>
nmap <S-ScrollWheelUp> <C-U>
nmap <ScrollWheelDown> <C-E>
nmap <S-ScrollWheelDown> <C-D>

" General scrolling
set scrolloff=5
"set lazyredraw

" Python {
  let python_highlight_all=1
  let g:ycm_python_binary_path = 'python3'

  au BufNewFile,BufRead *.py |
        \ set tabstop=4 |
        \ set softtabstop=4 |
        \ set shiftwidth=4 |
        \ set textwidth=79 |
        \ set expandtab |
        \ set autoindent |
        \ set fileformat=unix
" }

" Tagbar {
    nnoremap <leader>t :TagbarToggle<CR>
" }

" Javascript {
  au BufNewFile,BufRead *.js,*.html,*.css
        \ set tabstop=2 |
        \ set softtabstop=2 |
        \ set shiftwidth=2
" }

" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-<Tab>>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Keep more info in memory to speed things up:
set hidden
set history=100

" Smart tabbing and indentation
filetype indent on
set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=2 " the visible width of tabs
set shiftwidth=2 " number of spaces to use for indent and unindent
set softtabstop=2 " edit as if the tabs are 2 characters wide
set expandtab
set smartindent
set autoindent
set shiftround " round indent to a multiple of 'shiftwidth'
"let g:indent_guides_enable_on_vim_startup=1
"let g:indent_guides_guide_size=1
let g:indentLine_char = '│'
let g:indentLine_color_term = 239

" code folding settings
set foldmethod=indent " fold based on indent
set foldlevelstart=99
set foldnestmax=10 " deepest fold is 10 levels
set nofoldenable " don't fold by default
set foldlevel=99

" toggle invisible characters
set list
set listchars=tab:→\ ,trail:⋅,extends:❯,precedes:❮
set showbreak=↪

"set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors
"if &term =~ '256color'
    " disable background color erase
    "set t_ut=
"endif

 "enable 24 bit color support if supported
"if (has('mac') && empty($TMUX) && has("termguicolors"))
    "set termguicolors
"endif

" Remove white spaces on save
autocmd BufWritePre * :%s/\s+$//e

" enable . command in visual mode
vnoremap . :normal .<cr>

" Leader key by default is \

" using the variable g:os below you can create OS dependent vim config
"if !exists("g:os")
"    if has("win64") || has("win32") || has("win16")
"        let g:os = \"Windows"
"    else
"        let g:os = substitute(system('uname'), '\n', '', '')
"    endif
"endif

set clipboard=unnamed

" YouCompleteMe Configuration
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath("clangd")

