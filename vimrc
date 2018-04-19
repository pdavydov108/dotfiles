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
set shortmess+=c " disable 'pattern not found' messages for autocomplete

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
Plug 'ryanoasis/vim-devicons' " TODO : patch fonts
Plug 'derekwyatt/vim-scala', { 'for': 'scala' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'rhysd/vim-clang-format', {'for': ['c','cpp']}
Plug 'xolox/vim-misc', {'for': 'lua'}
Plug 'xolox/vim-lua-ftplugin', {'for': 'lua'}
Plug 'bling/vim-airline'
Plug 'haya14busa/is.vim'
Plug 'bruno-/vim-man', { 'on': 'Man' }
Plug 'tmux-plugins/vim-tmux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'alepez/vim-gtest', {'for': 'cpp'}
Plug 'alepez/vim-llvmcov', {'for': 'cpp'}
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Yggdroot/vim-mark'
Plug 'tweekmonster/braceless.vim', { 'for': 'python' }
Plug 'junegunn/gv.vim'
Plug 'KabbAmine/yowish.vim'
Plug 'cespare/vim-toml'
Plug 'Chiel92/vim-autoformat'
Plug 'morhetz/gruvbox'
Plug 'timonv/vim-cargo'
Plug 'mbbill/undotree'
Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp', {'for': ['rust', 'cpp', 'c', 'python']}
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neco-vim'
Plug 'pdavydov108/vim-lsp' , {'branch': 'flickering'}
Plug 'pdavydov108/vim-lsp-cquery', {'for': ['cpp', 'c']}
Plug 'prabirshrestha/asyncomplete.vim' ", {'for': ['rust', 'cpp', 'c']}
Plug 'prabirshrestha/asyncomplete-lsp.vim' ", {'for': ['rust', 'cpp', 'c']}
Plug 'prabirshrestha/asyncomplete-necosyntax.vim'
Plug 'prabirshrestha/asyncomplete-necovim.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
if has('python3')
    Plug 'SirVer/ultisnips' 
    Plug 'honza/vim-snippets'
    Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
endif

call plug#end()

set noeb vb t_vb=
set vb
set nobackup
set tags=./tags;/

" set wildignore+=*/tmp/*,*/Debug/*,*/Release/*,*/MinSizeRel/*,*/build/*,*/target/*,*.so,*.swp,*.zip,*.jar,*.class,*.o

""" nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
nmap <F6> :NERDTreeToggle<CR>

""" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
set laststatus=2
set noshowmode

""" ultisnips
let g:UltiSnipsSnippetDirectories=["~/dotfiles/ultisnips"]
let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0
function ExpandSnippetOrCarriageReturn()
    let l:snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return l:snippet
    else
        return "\<CR>"
    endif
endfunction

inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"

""" vim autoformat
let g:formatterpath = ['/home/pablo/llvm/build/bin/']
let g:autoformat_remove_trailing_spaces = 1
let g:autoformat_retab = 1
nnoremap <Leader>cf :Autoformat<CR>

""" man
autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <S-k>  :Man <C-r><C-w><CR>

""" colorscheme
set background=dark
colorscheme gruvbox 

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

command! RcSearch call fzf#run({'source': 'rc -S', 'sink': 'botright split'})

command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)

nnoremap <Leader>rg :Rg


""" braceless python
autocmd FileType python BracelessEnable +indent

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

let g:gruvbox_contrast_dark="hard"

""" cargo
let g:cargo_command = "Dispatch cargo {cmd}"
autocmd FileType rust nnoremap <leader>mk :CargoBuild<CR>

""" undotree
nnoremap <leader>ut :UndotreeToggle<CR>

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
         \ 'initialization_options': { 'cacheDirectory': '/home/pablo/.cquery', 'cacheFormat': 'msgpack' },
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

" asyncomplete setup
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#necosyntax#get_source_options({
    \ 'name': 'necosyntax',
    \ 'whitelist': ['*'],
    \ 'completor': function('asyncomplete#sources#necosyntax#completor'),
    \ }))

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'whitelist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))

call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'whitelist': ['*'],
    \ 'blacklist': ['go'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ }))

if has('python3')
    call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
            \ 'name': 'ultisnips',
            \ 'whitelist': ['*'],
            \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
            \ }))
endif

highlight link LspErrorText GruvboxRedSign
highlight link LspWarningText GruvboxYellowSign
autocmd FileType c,cc,cpp,cxx,h,hpp,rust,python nnoremap <leader>t :LspHover<CR>
autocmd FileType c,cc,cpp,cxx,h,hpp,rust,python nnoremap <leader>fr :LspReferences<CR>
autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <leader>fv :LspCqueryDerived<CR>
autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <leader>fc :LspCqueryCallers<CR>
autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <leader>fp :LspCqueryBase<CR>
autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <leader>fi :LspCqueryVars<CR>
autocmd FileType c,cc,cpp,cxx,h,hpp,rust,python nnoremap <leader>jj :LspDefinition<CR>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
let g:lsp_log_file = expand('~/vim-lsp.log')
" let g:asyncomplete_log_file = expand('~/asyncomplete.log')
let g:lsp_signs_enabled = 1
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '‼'}
let g:lsp_diagnostics_echo_cursor = 1
let g:asyncomplete_auto_popup = 1
let g:lsp_async_completion = 1
" let g:asyncomplete_min_chars = 3
let g:asyncomplete_smart_completion = 1
