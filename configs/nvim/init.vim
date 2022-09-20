set nocompatible

""""""""""""""""""""""""""""" Plugin Secion
call plug#begin("~/.vim/plugged")

" Theme
Plug 'morhetz/gruvbox'

" Statusline
Plug 'itchyny/lightline.vim'

" File Explorer
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'

" Fuzzing Finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Code Completion
Plug 'dense-analysis/ale'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'mzlogin/vim-markdown-toc'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
let g:coc_global_extensions = ['coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-svelte']

" Fugitive (Git support)
Plug 'tpope/vim-fugitive'

" Undo Tree
Plug 'mbbill/undotree'

call plug#end()


""""""""""""""""""""""""""""" Config Section

" ---------- Theme
if (has("termguicolors"))
 set termguicolors
endif

syntax enable
set background=dark
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE

" --------- General Settings

let mapleader=","

" Set svelte language server overrides

let g:svelte_indent_script = 2
let g:svelte_indent_style = 2

" Tab & Indent sizes
set expandtab
set shiftwidth=2
set tabstop=4

" Persistent undo
set undofile
set undodir=$HOME/.vim/undo
nnoremap <F5> :UndotreeToggle<CR>

set undolevels=1000
set undoreload=10000

" Incrementally Search for Text
set incsearch

" Scroll the page when cursor is n number of lines from edge
set scrolloff=10

" If there is a .vimrc file where I open this, use it
set exrc

" Enable mouse support
set mouse=a

" Search
nnoremap <esc> :noh<CR>

" Line numbers
set nu
set relativenumber
set laststatus=2

" Search and replace
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Clipboard
set clipboard=unnamedplus

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" ---------- AUTOGROUPS

fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

augroup ButterCoding
  autocmd!
  autocmd BufWritePre * :call TrimWhitespace()
augroup END


"---------- File Explorer
autocmd BufEnter * lcd %:p:h
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['\.git$', '\.idea$', '\.vscode$', '\.history$']
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

" ----------- Buffer navigation
" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" ------------ Fuzzy Find
" Find all files including .gitignored files
nnoremap <silent> <C-g> :Files<CR>

" Find all files not in .gitignored
nnoremap <silent> <C-p> :GFiles<CR>
nnoremap <silent> <C-o> :Buffers<CR>
let g:rg_command = 'rg --vimgrep -S'


let g:fzf_layout = { 'down': '40%' }
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}
