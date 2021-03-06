runtime! debian.vim

if has("syntax")
	syntax on
endif

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
	source /etc/vim/vimrc.local
endif

syn on
colorscheme evening
" Supertab start
set wildmenu
setlocal omnifunc=syntaxcomplete#Complete
set cot+=menuone
highlight PmenuSel ctermbg=grey cterm=bold
set nocp
let g:SuperTabDefaultCompletionTypeDiscovery = [
  \ "&completefunc:<c-x><c-u>",
  \ "&omnifunc:<c-x><c-o>",
  \ ]
" Supertab end

"Show the trailing whitespaces
""If tabs should be shown too: set listchars=tab:�-,trail:�
"set list
set listchars=tab:>\ ,eol:$
set laststatus=2
"set listchars=tab:�-,trail:�

map <F2> :%s#\s*\r\?$##<CR>
map <F10> iprint "<pre>";<CR>var_dump($);<CR>print "</pre>";<CR><ESC>
map <F11> dd..

map <C-D> ddPP
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
set wmh=0

set autoindent
set smartindent
set sw=3
set tabstop=3
set softtabstop=3
set showmatch
set incsearch
set encoding=iso8859-1

au BufNewFile,BufRead *.hx                     setf haxe

if has("autocmd")
	" Enable filetype detection
	filetype plugin indent on
	 
	" Restore cursor position
	autocmd BufReadPost *
	  \ if line("'\"") > 1 && line("'\"") <= line("$") |
	  \   exe "normal! g`\"" |
	  \ endif
endif

if &t_Co > 2 || has("gui_running")
	" Enable syntax highlighting
	syntax on
endif

