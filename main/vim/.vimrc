" ~/.vimrc
"
" Autor: Rafael Cavalcanti
"

set nocompatible				" Don't try to mimic Vi


" vim-plug automatic instalation (copied from vim-plug's github)
"======================================================================
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug
"=======================================================================
" Note: needs single quotes
call plug#begin('~/.vim/plugged')		" Specify a directory for plugins
Plug 'powerline/powerline', { 'rtp': 'powerline/bindings/vim/' }	" option needed
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }   		" load only on demand
Plug 'junegunn/goyo.vim'
" Syntax
Plug 'joanrivera/vim-zimwiki-syntax'
Plug 'PotatoesMaster/i3-vim-syntax'
" Editing
Plug 'tpope/vim-surround'
Plug 'alvan/vim-closetag'
Plug 'scrooloose/nerdcommenter'
"Colorschemes
Plug 'hzchirs/vim-material'
Plug 'jakwings/vim-colors'
Plug 'lu-ren/SerialExperimentsLain'
Plug 'exitface/synthwave.vim'
Plug 'w0ng/vim-hybrid'
call plug#end()


" APPEARANCE
"=========================================================================
" If both terminal and VIM support truecolor
if $COLORTERM == "truecolor" && has("termguicolors")
	set termguicolors             " Use truecolors
	colorscheme vim-material      " This colorscheme needs truecolor
"	colorscheme hybrid
else
	set bg=dark
	colorscheme industry
endif

set nu
set relativenumber
"highlight ColorColumn ctermbg=lightgrey guibg=lightgrey 	" Line colour
set linebreak                   " More inteligent wrapping (don't break words)
set scrolloff=10                " Minimum lines below cursor
set showmatch                   " Show matching brackets

" Highlight current line in normal mode
set cursorline
autocmd InsertEnter,InsertLeave * set cursorline!

" Set colors for highlighting current line
"highlight CursorLine cterm=none ctermbg=239 ctermfg=white
" Set colors for insert mode completion (^X)
"highlight Pmenu ctermbg=238 ctermfg=white

set showcmd                     " Show partial command
set noshowmode                  " Don't show modes below status line (redundant to Powerline)
set laststatus=2                " Always show status line
set showtabline=2               " Always show tab line
set splitbelow                  " Splitting puts new window below current


" SYNTAX AND FILE TYPES
"=======================================================================
" Enable syntax highlighting
if has("syntax")
	syntax on
endif

" Load indentation rules and plugin according to the detected filetype
if has("autocmd")
	filetype plugin indent on
endif

" Nginx syntax
autocmd BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/* if &ft == '' | setfiletype nginx | endif
" Zim Wiki syntax
autocmd BufRead,BufNewFile $HOME/Private/Notebooks/* set filetype=zimwiki


" TABS
"=======================================================================
set tabstop=2
set shiftwidth=2
set noexpandtab

" Ruby: For some reason, I have to repeat my preferences for Ruby files
autocmd Filetype ruby setlocal noexpandtab tabstop=2 shiftwidth=2

" Python: 4 spaces hard tab (softtabstop=4 faz backspace/delete excluir os 4 espaços de uma vez)
" (http://www.vex.net/~x/python_and_vim.html)
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4


" FEATURES
"=======================================================================
" Uncomment to have Vim jump to the last position when reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

set modeline                        " Enable modeline
set hidden                          " Allow buffers to be hidden without saving
set mouse=r                         " (Não sei por quẽ) Fazer copia/cola do mouse funcionar
"set clipboard=unnamedplus							" Use clipboard as default register
set spelllang=pt_br,en_us,es_es     " Set spellcheck languages

function! AutoTrim()
	if !&binary && &filetype != 'diff'
		:%s/\s\+$//e 											" remove trailing whitespace in every line
		:%s/^\n\+\%$//e 									" remove blank lines at the end of the file
	endif
endfunction
autocmd BufWrite * call AutoTrim()	  " call AutoTrim when saving

" Turn on spell check for Git commits and use English
autocmd Filetype gitcommit,markdown setlocal spelllang=en_us spell

" Use friendlier line navigation on prose files
autocmd Filetype markdown noremap j gj
autocmd Filetype markdown noremap k gk
autocmd Filetype markdown noremap <Down> gj
autocmd Filetype markdown noremap <Up> gk
autocmd Filetype markdown noremap <Home> g<Home>
autocmd Filetype markdown noremap <End> g<End>

" PLUGINS CONFIGURATION
"=======================================================================
" vim-closetag
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.erb"	"enable it in erb files


" SEARCH ON BUFFER
"=======================================================================
set ignorecase           " Do case insensitive matching
set smartcase            " Do smart case matching
set incsearch            " Incremental search


" COMMAND COMPLETION
"=======================================================================
set history=500          " Number of command lines remembered
set wildmode=longest,list,full
set wildmenu
"set path+=**											" :find to search files recursively


" SHORTCUTS
"=======================================================================
" Clipboard operations
noremap <Leader>y "+y
noremap <Leader>d "+d
noremap <Leader>p "+p
set pastetoggle=<F2>

" Buffer operations
nnoremap <Leader>l :bn<CR>|                      " Go to next buffer
" Maps useful for when working in split windows. Current buffer in full window.
nnoremap <Leader>to :tabedit %<CR>|              " Open current buffer on tab
nnoremap <Leader>tc :tabclose %<CR>|             " Close current tab
" Save as root
cmap w!! w !sudo tee % > /dev/null

" Panels operations
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

map <F6> :setlocal spell!<CR>|                   " Toggle spellcheck

" Edit preset files
nnoremap <Leader>ev :e ~/.vimrc<CR>
nnoremap <Leader>e3 :e ~/.config/i3/config<CR>

" Addons
nnoremap <Leader>f :NERDTreeToggle<CR>|          " Nerdtree (original: <C-n>)

" Create the "tags" file (simply run ctags)
" NOW WE CAN: ^] to jump to tag under cursor; g^] for ambiguous tags; ^t to jump back up the tag stack
command! MakeTags !ctags -R .


" ABBREVIATIONS
"=======================================================================
iab rcc [RC]
iab rca [RC added]
iab rcr [RC removed]
iab rcm [RC modified]


" PATHS
"=======================================================================
" Set a safe directory for swapfiles, so my SSD isn't destroyed.
" Note: "Using double trailing slashes in the path tells vim to enable a feature
" where it avoids name collisions."
silent !mkdir -p ~/.cache/vim/swap > /dev/null 2>&1
set directory=$HOME/.cache/vim/swap//,/tmp//

" Change viminfo path
set viminfo+=n~/.cache/vim/viminfo

" Set transparency
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE


" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif
