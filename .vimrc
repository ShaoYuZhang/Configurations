"  ---------------------------------------------------------------------------

" Don't use vi stuff
set nocompatible
set notitle

"tab control
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab " Convert tab to spaces

set ls=2

set hlsearch
set autoindent
"set cindent

set showcmd
set incsearch
"set number " Show line-numbers
set ignorecase
set smartcase
set history=1000

set linebreak
set wrapscan " wrap around when searching

syntax on

"set ff=dos " Write in dos format

" look in the current directory for tag files, and work up the tree towards root
" until one is found. IOW, now can be anywhere in source tree
" originally 'set tags=tags;/', 
" but bug:
" if there is a directory called /home/jack/proj/trunk and another called
" /home/jack/proj/trunk_too, searching for tags in trunk_too directory also
" returns tags from trunk directory. 
set tags+=./tags;$HOME " now stop at home instead of root 

"Ignore white space in vimdiff
"set diffopt+=iwhite

"set foldmethod=syntax
"set foldnestmax=1
"set foldlevel=0

"set nowrap
"
" auto trim trailing spaces without modifying buffer
autocmd FileType c,cc,cpp,java,h autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

" ======================= Mappings ===========================================
nnoremap k gk
nnoremap j gj
nnoremap <Up> gk
nnoremap <Down> gj
inoremap <Up> <Esc>gka
inoremap <Down> <Esc>gja

"with smartcase on, we usually dont want *, # to search case sensitive 
"from http://vim.wikia.com/wiki/VimTip1
nnoremap * /\<<C-R>=expand('<cword>')<CR>\><CR>
nnoremap # ?\<<C-R>=expand('<cword>')<CR>\><CR>

imap <C-SPACE> <Esc>

nnoremap <C-p> zfa

" build tags libs for the current working directory.
" TODO: need a bit of fixing so that it can be used anywhere.
"       make it part of make
"map <F8> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" A-] open the definition in a vertical split
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
" remember C-W C-] is open definition in a horizontal split

" Block commenting for a number of known extensions.
au FileType haskell,vhdl,ada let b:comment_leader = '-- '
au FileType vim let b:comment_leader = '" '
au FileType c,cpp,java let b:comment_leader = '// '
au FileType sh,make let b:comment_leader = '# '
au FileType tex let b:comment_leader = '% '
noremap <silent> ,c :<C-B>sil <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
noremap <silent> ,u :<C-B>sil <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:noh<CR>
" ======================= Others ==========================================

set backspace=eol,indent,start 

set showmatch
"cause cursor to briefly jump to brace/paren/brack match when closing
"set guioptions-= t //turn off gui vim's toolbar
set mouse=a "use mouse everywhere


" LateX settings
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" ======================= Functions ==========================================

" Make function that searches up the current directory until 
" a 'Makefile' is  found
fun! SetMkfile()
  let filemk = "Makefile" "maybe makefile as well..
  let pathmk = "./"
  let depth = 1
  while depth < 4
    if filereadable(pathmk . filemk)
      return pathmk
    endif
    let depth += 1
    let pathmk = "../" . pathmk
  endwhile
  return "."
endf

"command! -nargs=* Make tabnew | let $mkpath = SetMkfile() | make <args> -C $mkpath | cwindow 10
" create Make command that finds the file
command! -nargs=* Make let $mkpath = SetMkfile() | make <args> -C $mkpath 

