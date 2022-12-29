set nocompatible

""""""""""""""""""""""""""""" Plugin Secion
call plug#begin("~/.vim/plugged")

" Theme
Plug 'morhetz/gruvbox'
Plug 'nanotech/jellybeans.vim'
Plug 'adrian5/oceanic-next-vim'

" Statusline
Plug 'itchyny/lightline.vim'

" File Explorer
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

" Code
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'mzlogin/vim-markdown-toc'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'https://github.com/tpope/vim-commentary'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

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
set cursorline
colorscheme oceanicnext
" statusline
set laststatus=2
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'oceanicnext',
      \ }

" for transparent background
function! AdaptColorscheme()
  highlight clear CursorLine
  highlight Normal guibg=none ctermbg=none
  highlight LineNr ctermbg=none
  highlight Folded ctermbg=none
  highlight NonText ctermbg=none
  highlight SpecialKey ctermbg=none
  highlight VertSplit ctermbg=none
  highlight SignColumn ctermbg=none
endfunction
autocmd ColorScheme * call AdaptColorscheme()

highlight Normal guibg=NONE ctermbg=NONE
highlight CursorColumn cterm=NONE ctermbg=NONE ctermfg=NONE
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE
highlight CursorLineNr cterm=NONE ctermbg=NONE ctermfg=NONE
highlight EndOfBuffer guibg=NONE ctermbg=NONE
highlight Normal ctermbg=none guibg=none
highlight NonText ctermbg=none guibg=none
highlight clear LineNr
highlight clear SignColumn
highlight clear StatusLine

" Change Color when entering Insert Mode
autocmd InsertEnter * set nocursorline

" Revert Color to default when leaving Insert Mode
autocmd InsertLeave * set nocursorline

" trasparent end
" Add title to term
autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
set title

" --------- General Settings
let mapleader=" "
nnoremap <SPACE> <Nop>

" Source this file and then install any missing deps
nnoremap <silent><leader>1 :source ~/.config/nvim/init.vim \| :PlugInstall<CR>

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

" Search
set incsearch
set ignorecase
set smartcase

" Scroll the page when cursor is n number of lines from edge
set scrolloff=10

" If there is a .vimrc file where I open this, use it
set exrc

" Enable mouse support
set mouse=a

" Remove highlights for search
nnoremap <esc> :noh<CR>

" Line numbers
set nu
set relativenumber

" Search and replace
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Clipboard
set clipboard=unnamedplus

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=UTF-8

" TextEdit might fail if hidden is not set.
set hidden

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

" --------- Telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

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

" ----------- Nerdtree
let g:NERDTreeWinPos = "left"
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['\.git$', '\.idea$', '\.vscode$', '\.history$']
let g:NERDTreeStatusline = ''
set autochdir
let NERDTreeChDirMode=2
nnoremap <leader>n :NERDTree .<CR>
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

" --------------- Treesitter
" This is special because it requires it to be configured by lua
" This must also be on a single line
lua require'nvim-treesitter.configs'.setup{highlight={enable=true}}

" --------------- Conqueror of Code

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

