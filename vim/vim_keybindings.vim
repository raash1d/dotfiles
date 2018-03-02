" Easier traversing between split windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Cancel a search with Escape (Esc)
nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>

" Re-Open previously opened file
nnoremap <leader><leader> :e#<cr>

" Reload vimrc after change
map <leader>s :source ~/.vimrc<cr>

