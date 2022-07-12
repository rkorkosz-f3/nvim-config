call plug#begin('~/.config/nvim/plugins')
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-fugitive'
Plug 'ruanyl/vim-gh-line'
Plug 'tyru/open-browser.vim'
Plug 'aklt/plantuml-syntax'
Plug 'ray-x/go.nvim'
Plug 'leoluz/nvim-dap-go'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'mtdl9/vim-log-highlighting'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'folke/trouble.nvim'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'lewis6991/gitsigns.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'joshdick/onedark.vim'
Plug 'preservim/tagbar'
Plug 'meain/vim-jsontogo'
Plug 'b3nj5m1n/kommentary'
Plug 'tami5/sqlite.lua'
Plug 'nvim-telescope/telescope-frecency.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'romgrk/barbar.nvim'
Plug 'lervag/vimtex'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
Plug 'ray-x/guihua.lua', {'do': 'cd lua/fzy && make' }
call plug#end()

set termguicolors
colorscheme onedark

set hidden
set number
set modeline
set linebreak
set showmatch
set visualbell
set hlsearch
set smartcase
set ignorecase
set incsearch
set autoindent
set shiftwidth=4
set smartindent
set smarttab
set softtabstop=4
set tabstop=4
set expandtab
set ruler
set backspace=indent,eol,start
set wildmenu
set laststatus=3
set showtabline=2
set lazyredraw
set nobackup
set nowb
set noswapfile
set encoding=utf-8
set ffs=unix,dos,mac
set autowrite
let mapleader = ","
set updatetime=100
set shortmess+=c
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable
set completeopt=menuone,noselect
set clipboard+=unnamedplus
set undodir=/home/rafal/.vim/undodir
set undofile
set scrolloff=2
let g:do_filetype_lua = 1

lua require('lemminx')
lua require('lsp')
lua require('misc')

let g:python_host_prog = '/home/rafal/.pyenv/versions/2.7.18/bin/python'
let g:python3_host_prog = '/home/rafal/.pyenv/versions/3.10.5/bin/python'
let g:node_host_prog = '/home/rafal/.yarn/bin/neovim-node-host'
let g:ruby_host_prog = '/home/rafal/.rbenv/versions/2.7.1/bin/neovim-ruby-host'

nmap <F8> :TagbarToggle<CR>

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fr <cmd>Telescope resume<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fs <cmd>Telescope grep_string<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap ra <cmd>Telescope lsp_code_actions<cr>
nnoremap gr <cmd>Telescope lsp_references<cr>
nnoremap gd <cmd>Telescope lsp_definitions<cr>
nnoremap gi <cmd>Telescope lsp_implementations<cr>
nnoremap <leader>gs <cmd>Telescope git_status<cr>
nnoremap <leader>gc <cmd>Telescope git_commits<cr>
nnoremap <leader>gbc <cmd>Telescope git_bcommits<cr>
nnoremap <leader>gbr <cmd>Telescope git_brabches<cr>

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

let g:nvim_tree_width = 60

augroup filetype_javascript
    autocmd!
    autocmd FileType javascript setlocal shiftwidth=2
    autocmd FileType javascript setlocal tabstop=2
    autocmd FileType javascript setlocal softtabstop=0
    autocmd FileType javascript setlocal expandtab
augroup END

augroup filetype_golang
    autocmd!
    autocmd FileType go setlocal shiftwidth=4
    autocmd FileType go setlocal tabstop=4
    autocmd FileType go setlocal softtabstop=0
    autocmd FileType go setlocal noexpandtab
    autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
augroup END
au! BufNewFile,BufReadPost *.yml,*.yaml set filetype=yaml
autocmd BufNewFile,BufRead *.yml,*yaml setlocal expandtab tabstop=2 shiftwidth=2 sts=2
autocmd Filetype html,xml setlocal expandtab tabstop=2 shiftwidth=2 sts=2
autocmd BufNewFile,BufRead *.I,*.V,*.Q,*.N set filetype=xml
autocmd VimResized * wincmd =

function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 0
let g:startify_lists = [
    \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
    \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
    \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
    \ { 'type': 'files',     'header': ['   MRU']            },
\ ]

let g:onedark_terminal_italics=1

nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle lsp_workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle lsp_document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>

" Move to previous/next
nnoremap <silent>    <A-,> :BufferPrevious<CR>
nnoremap <silent>    <A-.> :BufferNext<CR>
nnoremap <silent>    <A-c> :BufferClose<CR>
