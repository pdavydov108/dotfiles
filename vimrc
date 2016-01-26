" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2006 Nov 16
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.

"let mapleader=","
"let maplocalleader=","
set timeout timeoutlen=1000

if v:progname =~? "evim"
  finish
endif

"set t_Co=256

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
"map Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

set ts=2
set sw=2
set expandtab

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	 	\ | wincmd p | diffthis

"map q :q<CR>

set fileencodings=utf-8,cp1251,koi8-r,cp866

set number

set ffs=unix,dos

autocmd BufReadPost * nested
      \ if !exists('b:reload_dos') && !&binary && &ff=='unix' && (0 < search('\r$', 'nc')) |
      \   let b:reload_dos = 1 |
      \   e ++ff=dos |
      \ endif

""" vundle
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-tbone'
Plugin 'a.vim'
Plugin 'grep.vim'
Plugin 'nginx.vim'
Bundle 'mark'
Plugin 'derekwyatt/vim-scala.git'
Plugin 'scrooloose/nerdtree'
Plugin 'hewes/unite-gtags'
Plugin 'lervag/vim-latex'
Plugin 'ktvoelker/sbt-vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'majutsushi/tagbar'
Plugin 'fatih/vim-go'
Plugin 'flazz/vim-colorschemes'
Plugin 'rhysd/vim-clang-format'
Plugin 'Valloric/YouCompleteMe'
Plugin 'bling/vim-airline'
Bundle 'Shougo/vimproc.vim'
Bundle 'Shougo/unite.vim'
Plugin 'haya14busa/incsearch.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'sirver/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'junegunn/limelight.vim'
Plugin 'lyuts/vim-rtags'
Plugin 'bruno-/vim-man'
Plugin 'rking/ag.vim'
Plugin 'tmux-plugins/vim-tmux'
" Plugin 'scrooloose/syntastic.git'
Bundle 'jalcine/cmake.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'wting/rust.vim'
Plugin 'ebfe/vim-racer'
Plugin 'dag/vim2hs'
Plugin 'eagletmt/neco-ghc'

call vundle#end()
filetype plugin indent on

set noeb vb t_vb=
set vb
set nobackup
set tags=./tags;/
"set grepprg=grep\ --color=always\ -n\ $* 

"let g:ctrlp_custom_ignore = { 'dir':  '\v[\/]\.(git|hg|svn)$', 'file': '\v\.(exe|so|dll)$', 'link': 'SOME_BAD_SYMBOLIC_LINKS' }

autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

""" fugitive
hi! DiffAdd ctermfg=red ctermbg=yellow guibg=yellow guifg=red


""" tagbar
nmap <F8> :TagbarToggle<CR>

""" nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
nmap <F6> :NERDTreeToggle<CR>

""" clang
function! ClangCheckImpl(cmd)
  if &autowrite | wall | endif
  echo "Running " . a:cmd . " ..."
  let l:output = system(a:cmd)
  cexpr l:output
  cwindow
  let w:quickfix_title = a:cmd
  if v:shell_error != 0
    cc
  endif
  let g:clang_check_last_cmd = a:cmd
endfunction

function! ClangCheck()
  let l:filename = expand('%')
  if l:filename =~ '\.\(cpp\|cxx\|cc\|c\)$'
    call ClangCheckImpl("clang-check " . l:filename)
  elseif exists("g:clang_check_last_cmd")
    call ClangCheckImpl(g:clang_check_last_cmd)
  else
    echo "Can't detect file's compilation arguments and no previous clang-check invocation!"
  endif
endfunction

"nmap <silent> <F5> :call ClangCheck()<CR><CR>

""" youcompleteme
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
noremap <Leader>t :YcmCompleter GetType<CR>
noremap <Leader>fx :YcmCompleter FixIt<CR>

nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>

let g:ycm_semantic_triggers = {'haskell' : ['.']}

""" conque-gdb
let g:ConqueTerm_StartMessages = 0

""" cmake
let g:cmake_c_compiler="gcc"
let g:cmake_cxx_compiler="g++"
let g:cmake_build_type="Debug"
let g:cmake_build_directories=["Debug"]

""" grep
let Grep_Skip_Dirs="Debug Release"
let Grep_Default_Filelist="*.c *.cpp *.h *.hpp *.hxx *.py"

set background=dark
colorscheme badwolf
hi Search cterm=none ctermfg=red ctermbg=yellow
hi SpellBad ctermfg=black

let &path.="/usr/include/,/usr/include/linux/,/usr/include/c++/5.1.1/,/usr/include/boost/"

""" airline
let g:airline_powerline_fonts = 1
"set timeoutlen=50
set laststatus=2
let g:airline#extensions#tabline#enabled = 1

""" unite
let g:unite_enable_start_insert = 1
let g:unite_split_rule = "botright"
let g:unite_force_overwrite_statusline = 0
let g:unite_winheight = 10
let g:unite_candidate_icon="▶"
let g:unite_source_line_enable_highlight = 1
"let g:unite_options_ignorecase = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('file,file/new,buffer,file_rec,line', 'matchers', 'matcher_fuzzy')
nnoremap <leader>f :<C-u>Unite -buffer-name=search -start-insert line<cr>

""" ctrl-p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_extensions = ['line']
set wildignore+=*/tmp/*,*/Debug/*,*/Release/*,*/MinSizeRel/*,*/build/*,*/target/*,*.so,*.swp,*.zip,*.jar,*.class,*.o
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_funky_matchtype = 'path'
let g:ctrlp_funky_syntax_highlight = 1
nnoremap <Leader>fu :CtrlPFunky<CR>
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<CR>
nnoremap <Leader>fl :CtrlPLine<CR>

""" incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

""" ultisnips
let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

""" colors-solarized
"let g:solarized_termcolors=256
"set t_Co=16
"colorscheme solarized

""" limelight
let g:limelight_conceal_ctermfg=0xbec9fc

""" rtags
let g:rtagsUseLocationList = 0
let g:rtagsUseDefaultMappings = 1
nnoremap <silent> <C-]> :call rtags#JumpTo()<CR>

""" cppman
nnoremap K :Man <C-r><C-w><CR>

""" ag
let g:ag_working_path="r"
nnoremap <leader>ag :Ag <cword><CR>

""" Conque GDB
let g:ConqueGdb_Leader="'"

""" ClangFormat
autocmd FileType c,cpp,h,hpp nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,h,hpp vnoremap <buffer><Leader>cf :ClangFormat<CR>

""" vim2hs
set nofoldenable " disable folding

""" syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_cpp_compiler_options = "-std=c++11"
" let g:syntastic_cppcheck_config_file = "Debug/compile_commands.json"

""" some pain =)
map <Up> <Nop>
map <Down> <Nop>
map <Left> <Nop>
map <Right> <Nop>
imap <Up> <Nop>
imap <Down> <Nop>
imap <Left> <Nop>
imap <Right> <Nop>

""" dispatch
nnoremap <leader>mk :Dispatch make -j4 -C Debug<CR>

""" a.vim
nnoremap <leader>A :A<CR>
nnoremap <leader>AT :AT<CR>

""" run units
nnoremap <leader>ru :Tmux splitw -h -p 30 './Debug/tests/unit_tests'<CR>
