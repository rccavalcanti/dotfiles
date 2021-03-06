" Author: Rafael Cavalcanti - rafaelc.org

" Create a Markdown-link structure for the current word or visual selection.
" Optionally insert the current system clipboard as an URL.
" Adapted from https://stackoverflow.com/a/14284350.
nnoremap <Leader>l "lciw[<C-r>l]()<Esc>
vnoremap <Leader>l "lc[<C-r>l]()<Esc>
nnoremap <Leader>L "lciw[<C-r>l](<Esc>"*pla)<Esc>
vnoremap <Leader>L "lc[<C-r>l](<Esc>"*pla)<Esc>
