" 
" My personal vim configuration
" pdavydov108@gmail.com
"

" enable terminal colors
set t_Co=256

" set leader timeout
set timeout ttimeoutlen=100 timeoutlen=1000

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

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

set fileencodings=utf-8,cp1251,koi8-r,cp866

" enable line numbers
set number

set ffs=unix,dos

autocmd BufReadPost * nested
      \ if !exists('b:reload_dos') && !&binary && &ff=='unix' && (0 < search('\r$', 'nc')) |
      \   let b:reload_dos = 1 |
      \   e ++ff=dos |
      \ endif

filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-rsi'
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
" Plugin 'vhdirk/vim-cmake.git'
Plugin 'derekwyatt/vim-scala.git'
Plugin 'scrooloose/nerdtree'
" Plugin 'hewes/unite-gtags'
" Plugin 'lervag/vim-latex'
Plugin 'ktvoelker/sbt-vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky'
" Plugin 'majutsushi/tagbar'
Plugin 'fatih/vim-go'
" Plugin 'flazz/vim-colorschemes'
Plugin 'rhysd/vim-clang-format'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-lua-ftplugin'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Valloric/YouCompleteMe'
Plugin 'bling/vim-airline'
Plugin 'haya14busa/incsearch.vim'
Plugin 'Shougo/unite.vim'
Plugin 'bruno-/vim-man'
Plugin 'lyuts/vim-rtags'
" Plugin 'jpalardy/vim-slime'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'wting/rust.vim'
Plugin 'rking/ag.vim'
Plugin 'sjl/badwolf'
Plugin 'dag/vim2hs'
Plugin 'eagletmt/neco-ghc'
Plugin 'alepez/vim-gtest'
Plugin 'alepez/vim-llvmcov'
Plugin 'airblade/vim-gitgutter'
" Plugin 'ensime/ensime-vim'
Bundle 'mark'

call vundle#end()
filetype plugin indent on

set noeb vb t_vb=
set vb
set nobackup
set tags=./tags;/

set wildignore+=*/tmp/*,*/Debug/*,*/Release/*,*/MinSizeRel/*,*/build/*,*/target/*,*.so,*.swp,*.zip,*.jar,*.class,*.o
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

""" tagbar
nmap <F8> :TagbarToggle<CR>

""" nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
nmap <F6> :NERDTreeToggle<CR>

""" youcompleteme
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
noremap <Leader>t :YcmCompleter GetType<CR>
noremap <Leader>fx :YcmCompleter FixIt<CR>
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>

""" cmake
" let g:cmake_c_compiler="clang"
" let g:cmake_cxx_compiler="clang++"
" let g:cmake_build_type="Debug"
" let g:cmake_build_directories="Debug"

" hi Search cterm=none ctermfg=red ctermbg=yellow
" hi SpellBad cterm=none ctermfg=yellow ctermbg=red

""" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
set laststatus=2
set noshowmode

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


""" ultisnips
let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"


""" incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

""" ctrl-p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_extensions = ['line', 'buffer']
set wildignore+=*/tmp/*,*/Debug/*,*/Release/*,*/MinSizeRel/*,*/build/*,*/target/*,*.so,*.swp,*.zip,*.jar,*.class,*.o
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_funky_matchtype = 'path'
let g:ctrlp_funky_syntax_highlight = 1
nnoremap <Leader>fu :CtrlPFunky<CR>
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<CR>
nnoremap <Leader>fl :CtrlPLine<CR>
nnoremap <Leader>fb :CtrlPBuffer<CR>

""" clang format
let g:clang_format#command = "clang-format-3.7"
autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cc,cpp,cxx,h,hpp vnoremap <buffer><Leader>cf :ClangFormat<CR>

""" rtags
autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <silent> <C-]> :call rtags#JumpTo()<CR>

""" man
autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <S-k>  :Man <C-r><C-w><CR>

""" slime
let g:slime_target = "tmux"

""" Conque GDB
let g:ConqueGdb_Leader="'"

""" colorscheme
colorscheme badwolf

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
autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <leader>mk :Dispatch make -C Debug -j4<CR>
autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <leader>ct :Dispatch -compiler=make /home/pablo/llvm/build/bin/clang-tidy -p Debug/ -checks="*" %:p<CR> 
autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <leader>ctf :Dispatch -compiler=make /home/pablo/llvm/build/bin/clang-tidy -p Debug/ -checks="*" -fix-errors -fix %:p<CR> 

nnoremap <leader>A :A<CR>
nnoremap <leader>AT :AT<CR>

inoremap jj <ESC>
