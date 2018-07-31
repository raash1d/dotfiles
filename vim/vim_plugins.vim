"Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
" Initialize plugin system
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Themes
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'rakr/vim-one'

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
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer', 'for': ['c', 'cpp', 'python', 'python3'] }

" Vim Surround
Plug 'tpope/vim-surround', { 'for': ['cpp', 'python', 'python3'] }

" Git plugin for vim
Plug 'tpope/vim-fugitive'

" Snippets utility
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

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
"Plug 'nvie/vim-flake8', { 'for': 'python' }

" tmux integration for vim
Plug 'benmills/vimux'

"Context aware pasting
Plug 'sickill/vim-pasta'

" NERDTree {
    Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'ryanoasis/vim-devicons'
"}

" markdown {
    Plug 'tpope/vim-markdown', { 'for': 'markdown' }
    " a simple tool for presenting slides in vim based on text files
    Plug 'sotte/presenting.vim', { 'for': 'markdown' }
" }

" Indentation guides
Plug 'nathanaelkane/vim-indent-guides', { 'for': ['cpp', 'python', 'python3'] }
call plug#end()

