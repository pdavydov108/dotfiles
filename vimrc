" 
" My personal vim configuration
" pdavydov108@gmail.com
"
" remap leader
let mapleader = "\<space>"

" enable terminal colors
" set t_Co=256

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
set smartcase

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=

set ts=4
set sw=4
set expandtab

syntax on
set hlsearch

""" auto detect cpp headers
au BufRead * if search('\M-*- C++ -*-', 'nw', 1) | setlocal ft=cpp | endif

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

set fileencodings=utf-8,cp1251,koi8-r,cp866

" enable line numbers
set number

set ffs=unix,dos

" autocmd BufReadPost * nested
"       \ if !exists('b:reload_dos') && !&binary && &ff=='unix' && (0 < search('\r$', 'nc')) |
"       \   let b:reload_dos = 1 |
"       \   e ++ff=dos |
"       \ endif

" automatically download vim plug if it is not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

Plug 'tpope/vim-surround'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-projectionist'
" Plug 'nginx.vim'
Plug 'ryanoasis/vim-devicons' " TODO : patch fonts
Plug 'derekwyatt/vim-scala', { 'for': 'scala' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'lervag/vim-latex', { 'for': 'latex' }
" Plug 'ktvoelker/sbt-vim', { 'for': 'scala' }
" Plugin 'ctrlpvim/ctrlp.vim'
" Plugin 'tacahiroy/ctrlp-funky'
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'rhysd/vim-clang-format', {'for': ['c','cpp']}
Plug 'xolox/vim-misc', {'for': 'lua'}
Plug 'xolox/vim-lua-ftplugin', {'for': 'lua'}
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py', 'for': ['c', 'cpp', 'rust', 'python', 'go', 'java', 'scala'] }
" autocmd! User YouCompleteMe if !has('vim_starting') | call youcompleteme#Enable() | endif
Plug 'bling/vim-airline'
Plug 'haya14busa/is.vim'
" Plugin 'Shougo/unite.vim'
Plug 'bruno-/vim-man', { 'on': 'Man' }
" Plug 'lyuts/vim-rtags', {'for': ['c','cpp']}
" Plugin 'jpalardy/vim-slime'
Plug 'tmux-plugins/vim-tmux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'rust-lang/rust.vim', {'for': 'rust'}
" Plugin 'rking/ag.vim'
Plug 'dag/vim2hs', {'for': 'haskell'}
Plug 'eagletmt/neco-ghc', {'for': 'haskell'}
Plug 'enomsg/vim-haskellConcealPlus', { 'for': 'haskell' }
Plug 'mpollmeier/vim-scalaconceal', {'for': 'scala'}
Plug 'alepez/vim-gtest', {'for': 'cpp'}
Plug 'alepez/vim-llvmcov', {'for': 'cpp'}
Plug 'airblade/vim-gitgutter'
" Plug 'pdavydov108/ensime-vim', {'for': ['scala', 'java']}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'Yggdroot/vim-mark'
Plug 'tweekmonster/braceless.vim', { 'for': 'python' }
Plug 'junegunn/gv.vim'
Plug 'KabbAmine/yowish.vim'
Plug 'cespare/vim-toml'
" Plug 'DoxygenToolkit.vim'
Plug 'Chiel92/vim-autoformat'
Plug 'morhetz/gruvbox'
Plug 'timonv/vim-cargo'
Plug 'mbbill/undotree'
" Plug 'neomake/neomake'
Plug 'w0rp/ale', {'for': ['vim']}
" Rust RLS support
Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp', {'for': ['rust', 'cpp', 'c', 'python']}
Plug 'pdavydov108/vim-lsp' ", {'for': ['rust', 'cpp', 'c', 'python']}
Plug 'pdavydov108/vim-lsp-cquery', {'for': ['cpp', 'c']}
Plug 'prabirshrestha/asyncomplete.vim' ", {'for': ['rust', 'cpp', 'c']}
Plug 'prabirshrestha/asyncomplete-lsp.vim' ", {'for': ['rust', 'cpp', 'c']}

call plug#end()

set noeb vb t_vb=
set vb
set nobackup
set tags=./tags;/

set wildignore+=*/tmp/*,*/Debug/*,*/Release/*,*/MinSizeRel/*,*/build/*,*/target/*,*.so,*.swp,*.zip,*.jar,*.class,*.o
" let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

""" tagbar
nmap <F8> :TagbarToggle<CR>

""" nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
nmap <F6> :NERDTreeToggle<CR>

""" youcompleteme
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_confirm_extra_conf = 0
" let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
" let g:ycm_rust_src_path = '/home/pablo/rust/rust-git/src'
" autocmd FileType c,cc,cpp,cxx,h,hpp noremap <Leader>fx :YcmCompleter FixIt<CR>
" autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>

"autocmd FileType python nnoremap <leader>jj :YcmCompleter GoTo<CR>
" Jautocmd FileType python nnoremap <leader>gd  :YcmCompleter GetDoc<CR>
let g:ycm_python_binary_path = '/usr/bin/python3'



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

""" ultisnips
let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

""" vim autoformat
let g:formatterpath = ['/home/pablo/llvm/build/bin/']
let g:autoformat_remove_trailing_spaces = 1
let g:autoformat_retab = 1
nnoremap <Leader>cf :Autoformat<CR>

""" clang format
" let g:clang_format#command = "clang-format-5.0"
" autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
" autocmd FileType c,cc,cpp,cxx,h,hpp vnoremap <buffer><Leader>cf :ClangFormat<CR>

""" rtags
" autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <silent> <leader>jj :call rtags#JumpTo(g:SAME_WINDOW)<CR>
" autocmd FileType c,cpp,h,hpp nnoremap <leader>jj :LspDefinition<CR>

""" man
autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <S-k>  :Man <C-r><C-w><CR>

""" slime
let g:slime_target = "tmux"

""" colorscheme
set background=dark
colorscheme gruvbox 

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
" imap <BS> <nop>
imap <ESC> <nop>
cmap <ESC> <nop>
inoremap jj <ESC>
cnoremap jj <ESC>

""" dispatch
autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <leader>mk :Dispatch<CR>
autocmd FileType rust nnoremap <leader>mk :Dispatch cargo build<CR>
autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <leader>ct :Dispatch -compiler=make clang-tidy-6.0 -p Debug/  %:p<CR>
autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <leader>ctf :Dispatch -compiler=make clang-tidy-6.0 -p Debug/ -fix-errors -fix %:p<CR>

nnoremap <leader>aa :A<CR>
nnoremap <leader>at :AT<CR>
nnoremap <leader>av :AV<CR>
nnoremap <leader>ww :w<CR>
nnoremap <leader>wa :wa<CR>
nnoremap <leader>wq <c-w>q
nnoremap <leader>wo <c-w>o
nnoremap <leader>wv <c-w>v

""" enable persistent undo check
set undofile                " Save undo's after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

""" FZF
set rtp+=~/.fzf
nnoremap <leader>ff :FZF<CR>
nnoremap <Leader>fj :BLines<CR>
nnoremap <Leader>fJ :Lines<CR>
nnoremap <Leader>fb :Buffers<CR>
nnoremap <Leader>fa :Ag 

command! RcSearch call fzf#run({'source': 'rc -S', 'sink': 'botright split'})

""" braceless python
autocmd FileType python BracelessEnable +indent

""" syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0
" let g:syntastic_clang_tidy_config_file = "Debug/compile_commands.json"
" let g:syntastic_cppcheck_config_file = "Debug/compile_commands.json"

""" open class
function! ProcessResult(result) 
  try
    let args = {'F': '"'.a:result.'"'}
    let results = rtags#ExecuteRC(args)
    let loc = rtags#parseSourceLocation(results[0])
    call rtags#jumpToLocation(loc[0], loc[1], loc[2])
  catch 
    echo v:exception
endfunction

function! RtagsSelectProject(result) 
  try
    let args = {'w': '"'.a:result.'"'}
    call rtags#ExecuteRC(args)
  catch 
    echo v:exception
endfunction

" , 'options': '--expect=ctrl-t,ctrl-v,ctrl-x'

""" rtags and fzf integration
command! -nargs=0 FClass call fzf#run({'source': 'rc -S class', 'down': '40%', 'sink': function('ProcessResult')}) 
command! -nargs=0 FSymbol call fzf#run({'source': 'rc -S', 'down': '40%', 'sink': function('ProcessResult')}) 
command! -nargs=0 FProject call fzf#run({'source': 'rc -w', 'down': '40%', 'sink': function('RtagsSelectProject')}) 
nnoremap <leader>rc :FClass<CR>
nnoremap <leader>rm :FSymbol<CR>
nnoremap <leader>rP :FProject<CR>
set shell=/bin/bash

""" Doxygen
autocmd FileType c,cc,cpp,cxx,h,hpp noremap <Leader>dx :Dox<CR>

""" llvm cov
let g:llvmcov#bin = "Debug"
let g:llvmcov#pwd = "Debug"

""" gtest
let g:gtest#gtest_command = "Debug"
let g:gtest#highlight_failing_tests = 1
nnoremap <leader>tj :GTestRunUnderCursor<CR>
nnoremap <leader>tt :GTestRun<CR>

""" ensime
autocmd FileType java,scala nnoremap <silent> <C-]> :EnGoDefinition<CR>
autocmd FileType java,scala nnoremap <leader>t :EnInspectType<CR>

""" enable terminal true color
set termguicolors

""" highlight cursor position
set number
set cursorline
set relativenumber
hi cursorline cterm=none ctermbg=none
hi cursorlinenr ctermfg=red

let g:gruvbox_contrast_dark="hard"

""" cargo
let g:cargo_command = "Dispatch cargo {cmd}"
autocmd FileType rust nnoremap <leader>mk :CargoBuild<CR>

""" undotree
nnoremap <leader>ut :UndotreeToggle<CR>

""" ale
" highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '‼'
let g:ale_set_quickfix = 0
let g:ale_set_loclist = 0
let g:ale_cpp_clangtidy_executable = 'clang-tidy-5.0'
let g:ale_cpp_clangtidy_checks = ['-google-readability*', '-llvm-include-order*', '-readability-implicit-bool-cast', 'performance*', 'cppcoreguidelines*', '-cppcoreguidelines-pro-bounds-array-to-pointer-decay', '-cppcoreguidelines-special-member-functions', 'cert*', 'misc*', '-misc-macro-parentheses', '-misc-unused-parameters', 'boost*', 'bugprone*', 'google*', 'modernize*']
let g:ale_linters = {
            \   'python': ['mypy'],
            \   'rust': ['cargo'],
            \   'cpp': ['clangtidy'],
            \   'vim': ['all']
            \}
nmap <silent> <leader>k <Plug>(ale_previous_wrap)
nmap <silent> <leader>j <Plug>(ale_next_wrap)

" rust RLS config
if executable('rls')
    au User lsp_setup call lsp#register_server({
            \ 'name': 'rls',
            \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
            \ 'whitelist': ['rust'],
            \ })
endif
" cpp clangd config
" if executable('clangd-6.0')
"     au User lsp_setup call lsp#register_server({
"             \ 'name': 'clangd',
"             \ 'cmd': {server_info->['clangd-6.0']},
"             \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
"             \ })
" endif
" cpp cquery config
let g:pablo_cquery_bin = '/home/pablo/cquery/build/release/bin/cquery'
if executable(g:pablo_cquery_bin)
   au User lsp_setup call lsp#register_server({
         \ 'name': 'cquery',
         \ 'cmd': {server_info->[g:pablo_cquery_bin]},
         \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
         \ 'initialization_options': { 'cacheDirectory': '/code/cquery', 'cacheFormat': 'msgpack' },
         \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
         \ })
endif
" python language server config
if executable('pyls')
    au User lsp_setup call lsp#register_server({
            \ 'name': 'pyls',
            \ 'cmd': {server_info->['pyls']},
            \ 'whitelist': ['python'],
            \ })
endif
autocmd FileType c,cc,cpp,cxx,h,hpp,rust,python nnoremap <leader>t :LspHover<CR>
autocmd FileType c,cc,cpp,cxx,h,hpp,rust,python nnoremap <leader>fr :LspReferences<CR>
autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <leader>fv :LspCqueryDerived<CR>
autocmd FileType c,cc,cpp,cxx,h,hpp,rust,python nnoremap <leader>jj :LspDefinition<CR>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
" let g:lsp_log_file = expand('~/vim-lsp.log')
" let g:asyncomplete_log_file = expand('~/asyncomplete.log')
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:asyncomplete_auto_popup = 1
let g:lsp_async_completion = 1
let g:asyncomplete_min_chars = 3
let g:asyncomplete_smart_completion = 0
" autocmd FileType c,cc,cpp,cxx,h,hpp,rust,python setlocal omnifunc=lsp#complete
