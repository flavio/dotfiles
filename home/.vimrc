filetype off
" call pathogen#infect()

" vim plug
call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'stamblerre/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'rking/ag.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'godlygeek/tabular'
Plug 'sjbach/lusty'
Plug 'vim-scripts/YankRing.vim'
Plug 'powerline/powerline', { 'rtp': 'powerline/bindings/vim' }
Plug 'yggdroot/indentline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Initialize plugin system
call plug#end()

filetype plugin on
set omnifunc=syntaxcomplete#Complete

syntax on

" Indentation stuff
set tabstop=2
set shiftwidth=2
set expandtab
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
"set autoindent

set number
set hlsearch  " highlight search terms
set incsearch " show search matches as you type
set nocompatible
filetype plugin indent on

if exists("g:btm_rainbow_color") && g:btm_rainbow_color
  call rainbow_parenthsis#LoadSquare ()
  call rainbow_parenthsis#LoadRound ()
  call rainbow_parenthsis#Activate ()
endif

" hidden chars
set list
set listchars=tab:▸\ ,eol:¬,trail:~,extends:>,precedes:< 

"Theming stuff
set background=dark
"set background=light
colorscheme solarized8

"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

"Highlight long lines
:au BufWinEnter * let w:m1=matchadd('Search', '\%<81v.\%>77v', -1)
:au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

" Yankring
nnoremap <silent> <F3> :YRShow<cr>
inoremap <silent> <F3> <ESC>:YRShow<cr>

" Restore cursor position
 autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Changelog
let g:changelog_username = "Flavio Castelli <flavio@castelli.me>"
let g:changelog_dateformat = "%a %b %d %H:%M:%S %Z %Y"

" CtrlP
nmap <leader>t :CtrlP<CR>
let g:ctrlp_working_path_mode = 'a'

" Highlight current word
" autocmd CursorMoved * silent! exe printf('match IncSearch /\<%s\>/', expand('<cword>'))

"statusline setup
set statusline=%f "tail of the filename
"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*
"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h "help file flag
set statusline+=%y "filetype
set statusline+=%r "read only flag
set statusline+=%m "modified flag
" show Sytntastics warnings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"always show status line
set laststatus=2

" Syntastics
let g:syntastic_enable_signs=1
let g:syntastic_quiet_messages = {'level': 'warnings'}
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']

" Paste large amount of text into Vim
set pastetoggle=<F2>

" Clearing highlighted searches
nmap <silent> ,/ :nohlsearch<CR>

" When you forget to run sudo before editing files
cmap w!! w !sudo tee % >/dev/null

set title        " change the terminal's title
set visualbell   " don't beep
set noerrorbells " don't beep
set hidden

" vim powerline
let g:Powerline_symbols = 'fancy'

" vim rust
let g:rustfmt_autosave = 1
let g:ycm_rust_src_path = '/usr/lib/rustlib/src/rust/src'

" coc
" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
