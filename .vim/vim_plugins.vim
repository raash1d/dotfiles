"Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
" Initialize plugin system
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Themes
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'rakr/vim-one'
Plug 'sonph/onehalf', {'rtp': 'vim/'}

" NERD Commenter
Plug 'scrooloose/nerdcommenter'

" Vim Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" SuperTab for tab completion
Plug 'ervandew/supertab'

" Git gutter
"Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-signify'

" YouCompleteMe
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --clangd-completer --go-completer --ts-completer --rust-completer', 'for': ['c', 'cpp', 'python', 'python3', 'go', 'rust', 'js', 'ts'] }

" Vim Surround
Plug 'tpope/vim-surround', { 'for': ['cpp', 'python', 'python3'] }

" Git plugin for vim
Plug 'tpope/vim-fugitive'

"Doxygen comment helper
Plug 'vim-scripts/DoxygenToolkit.vim', { 'for': ['cpp', 'python', 'python3'] }

" Fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'

" Syntax checker/linter
if has('mac')
    " Asynchronous Linting Engine (needs vim 8+)
    Plug 'w0rp/ale' " Asynchonous linting engine
else
    " syntastic (works with vim 7+)
    Plug 'vim-syntastic/syntastic'
endif

" Python linter
"Plug 'nvie/vim-flake8', { 'for': 'python3' } " makes saving py files too slow
Plug 'plytophogy/vim-virtualenv', { 'for': ['python', 'python3'] }
Plug 'majutsushi/tagbar', { 'for': ['c', 'h', 'cpp', 'python', 'python3'] }

" tmux integration for vim
Plug 'benmills/vimux'

"Context aware pasting
Plug 'sickill/vim-pasta'

" NERDTree {
    Plug 'scrooloose/nerdtree' , { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'ryanoasis/vim-devicons'
"}

" markdown {
    Plug 'tpope/vim-markdown', { 'for': 'markdown' }
    " a simple tool for presenting slides in vim based on text files
    Plug 'sotte/presenting.vim', { 'for': 'markdown' }
" }

" Indentation guides
"Plug 'nathanaelkane/vim-indent-guides', { 'for': ['cpp', 'python', 'python3'] }
Plug 'Yggdroot/indentLine', { 'for': ['cpp', 'python', 'python3', 'js', 'html', 'css'] }

" Javascript Plugins
" {
    Plug 'pangloss/vim-javascript', { 'for': ['js', 'css', 'html'] }
    Plug 'moll/vim-node', { 'for': ['js', 'css', 'html'] }
    Plug 'sergioramos/jsctags', { 'for': ['js', 'css', 'html'] }
    Plug 'othree/html5-syntax.vim', { 'for': ['js', 'css', 'html'] }
    Plug 'othree/html5.vim', { 'for': ['js', 'css', 'html'] }
    Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['js', 'css', 'html'] }
    Plug 'ternjs/tern_for_vim', { 'for': ['js', 'css', 'html'] }
" }

" TypeScript Plugins
" {
    " REQUIRED: Add a syntax file. YATS is the best
    Plug 'HerringtonDarkholme/yats.vim'
    Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
" }
call plug#end()

