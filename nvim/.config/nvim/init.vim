set hidden
set termguicolors
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set ignorecase
set smartcase
set splitright
set splitbelow
set encoding=utf-8
set mouse=a
set nu
set cursorline
set relativenumber
set nowrap
set incsearch
set undofile
set noswapfile
set nobackup
set scrolloff=8
set signcolumn=yes
set colorcolumn=89
set inccommand=nosplit
" only wrap long comments to 88 characters
set textwidth=88
set formatoptions=jcrql
" required for nvim-cmp
set completeopt=menu,menuone,noselect

" settings when using markdown documents (often for vimwiki)
autocmd FileType markdown nnoremap <buffer> j gj
autocmd FileType markdown nnoremap <buffer> k gk
autocmd FileType markdown nnoremap <buffer> gj j
autocmd FileType markdown nnoremap <buffer> gk k
autocmd FileType markdown setlocal wrap lbr
autocmd FileType markdown setlocal textwidth=0

" only set cursorline when not in insert mode in current window
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

" remap leader key
let mapleader = " "
" to write with mm instead of :w
nnoremap mm :w<CR>
" write all buffers
nnoremap <leader>w :wall<CR>
" to exit terminal insert mode or whatever
tnoremap <C-h> <C-\><C-n>
" to copy/paste to/from system clipboard
nnoremap <leader>y  "+y
nnoremap <leader>Y  "+y$
nnoremap <leader>p "+p
" easier way to switch to alternate buffer
nnoremap <leader>c <C-^>
" insert blank lines above/below current line
nnoremap <silent> <leader>k O<ESC>j^
nnoremap <silent> <leader>j o<ESC>k^
" be able to repeat indents on visual selections
xnoremap <  <gv
xnoremap >  >gv
" avoid automatic formatting with neoformat when exiting with :wq[a]
cnoremap <expr> wq ((&ft == "gitcommit") ? 'wq': 'noautocmd wq')

" move visual selection up/down with J/K
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" fzf-lua remaps (first one runs FzfLua git_files but falls back to FzfLua files if not in git repo)
nnoremap <expr> <leader>h (len(system('git rev-parse')) ? ':FzfLua files<CR>' : ':FzfLua git_files<CR>')
nnoremap <leader>r :FzfLua grep_project<CR>
nnoremap <leader>b :FzfLua buffers<CR>
" get last entries in registers from neoclip
nnoremap <leader>f :lua require('neoclip.fzf')()<CR>

" use ripgrep for :Grep command
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat=%f:%l:%c:%m,%f:%l:%m
" add | copen if I really want it to the end of this command
command! -nargs=+ Grep :silent grep <args>

" quickfix window mappings
function! QuickfixToggle()
  if filter(range(1, winnr('$')), 'getwinvar(v:val, "&ft") == "qf"') == []
    copen
  else
    cclose
  endif
endfunction

nnoremap <silent><C-n> :cnext<CR>
nnoremap <silent><C-p> :cprev<CR>
nnoremap <silent><leader>q :call QuickfixToggle()<CR>

" nice netrw setup
let g:netrw_browse_split=4
let g:netrw_banner=0

function! NetrwToggle()
  let l:netrw_list = filter(range(1, winnr('$')), 'getwinvar(v:val, "&ft") == "netrw"')
  if len(l:netrw_list) == 0
    execute "Vexplore" getcwd()
    vertical resize 30
  else
    let l:netrw_index = l:netrw_list[0]
    execute "q". l:netrw_index
  endif
endfunction

" open and close netrw split easily
nnoremap <silent> <leader>s :call NetrwToggle()<CR>

let g:markdown_fenced_languages = ["sql", "python", "sh", "html", "css", "javascript", "dockerfile", "yaml", "json", "vim", "cpp"]

let g:gruvbox_italic=1
let g:gruvbox_bold=1
let g:gruvbox_contrast_dark='hard'
let g:tokyonight_style='night'

" Write all buffers before navigating from Vim to tmux pane
let g:tmux_navigator_save_on_switch = 2

" not great bc this overrides the way to background nvim, but the <C-y> default is problematic
let g:user_emmet_leader_key='<C-z>'

" this was setting markdown filetype as vimwiki
let g:vimwiki_global_ext=0
" this was interfering with UltiSnips trigger
let g:vimwiki_table_mappings = 0
let g:vimwiki_conceal_pre=1
let g:vimwiki_markdown_link_ext=1
" this was interfering with my <leader>w mapping
let g:vimwiki_key_mappings={'global': 0}
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

nmap <leader><leader>w <Plug>VimwikiIndex
nmap <leader><leader>t <Plug>VimwikiTabIndex
" horrible remap to generate link to index file from any file
nnoremap <leader><leader>l :execute "VimwikiGenerateLinks index.md" <bar> norm Gkd2k2xddggo<ESC>p0f]ci[Home<ESC><CR>
" this interferes with my easymotion mapping so remap it to something useless (probably
" a better way to do this lol)
nmap <leader><leader>& <Plug>VimwikiRemoveHeaderLevel

nnoremap <silent> - :HopWord<CR>

augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END

" neoformat configuration
" don't run Neoformat on text files
autocmd BufWritePre * if index(['text'], &ft) < 0 | Neoformat
let g:neoformat_enabled_python=["black", "isort"]
let g:neoformat_enabled_javascript=["prettier"]
let g:neoformat_run_all_formatters = 1
let g:neoformat_basic_format_trim = 1

" luasnip remaps
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

" delete this when I want
nnoremap <silent> <leader><leader>s :silent wall <bar> source ~/dotfiles/nvim/.config/nvim/lua/snippets.lua<CR>

"vimtex remaps
let g:vimtex_view_method='skim'
let g:vimtex_quickfix_mode=0
autocmd FileType tex nnoremap <buffer> <leader>tc :VimtexCompile<CR>
autocmd FileType tex nnoremap <buffer> <silent> <leader>tl :VimtexClean<CR> <bar> :silent !rm *.synctex.gz<CR>

" vimux remaps
let g:VimuxOrientation = "h"
let g:VimuxHeight = "45"
let g:VimuxLastCommand = "make && ./a.out"
nnoremap <silent> <leader>vp :silent wall <bar> VimuxPromptCommand<CR>
" because my weird .inputrc makes VimuxClearTerminalScreen not work
nnoremap <silent> <leader>vc :call VimuxSendKeys("ii")<CR>
nnoremap <silent> <leader>vs :VimuxCloseRunner<CR>
nnoremap <silent> <leader>vi :VimuxInspectRunner<CR>
nnoremap <silent> <leader>vz :VimuxZoomRunner<CR>
nnoremap <silent> <leader>vk :VimuxInterruptRunner<CR>
nnoremap <silent> <C-s> :silent wall <bar> VimuxRunLastCommand<CR>

" vimspector remaps
fun! GotoWindow(id)
    call win_gotoid(a:id)
    MaximizerToggle
endfun

fun! AddToWatch()
  let word = expand("<cexpr>")
  call vimspector#AddWatch(word)
endfun

nnoremap <leader>mt :MaximizerToggle!<CR>
nnoremap <leader>dv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>do :call GotoWindow(g:vimspector_session_windows.output)<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>

" all the silent calls are to make these mappings dot-repeatable <3
nmap <leader>dl <Plug>VimspectorStepInto
nmap <silent> <leader>dj <Plug>VimspectorStepOver :silent! call repeat#set("\<Plug>VimspectorStepOver", v:count)<CR>
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>d_ <Plug>VimspectorRestart
nmap <silent> <leader>d<space> <Plug>VimspectorContinue :silent! call repeat#set("\<Plug>VimspectorContinue", v:count)<CR>

nmap <silent> <leader>dc <Plug>VimspectorRunToCursor :silent! call repeat#set("\<Plug>VimspectorRunToCursor", v:count)<CR>
nmap <silent> <leader>db <Plug>VimspectorToggleBreakpoint :silent! call repeat#set("\<Plug>VimspectorToggleBreakpoint", v:count)<CR>
nmap <leader>dtcb <Plug>VimspectorToggleConditionalBreakpoint
nmap <leader>di <Plug>VimspectorBalloonEval
nnoremap <leader>dw :call AddToWatch()<CR>

" Git remaps (Fugitive, Diffview)
nnoremap <silent> <leader>gs :G<CR>
" use the diffget remaps when running Gvdiffsplit!
nnoremap <silent> <leader>gu :diffget //2<CR>
nnoremap <silent> <leader>gh :diffget //3<CR>
nnoremap <leader>gd :DiffviewOpen
nnoremap <silent> <leader>gdc :DiffviewOpen<CR>
nnoremap <silent> <leader>gc :DiffviewClose<CR>

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sleuth'
Plug 'vim-scripts/indentpython.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-surround'
Plug 'unblevable/quick-scope'
Plug 'gruvbox-community/gruvbox'
Plug 'airblade/vim-rooter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'lervag/vimtex'
Plug 'romainl/vim-cool'
Plug 'vimwiki/vimwiki'
Plug 'preservim/vimux'
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'
Plug 'neovim/nvim-lspconfig'
Plug 'phaazon/hop.nvim'
Plug 'karb94/neoscroll.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'sbdchd/neoformat'
Plug 'p00f/nvim-ts-rainbow'
Plug 'rafamadriz/friendly-snippets'
Plug 'ray-x/lsp_signature.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'numToStr/Comment.nvim'
Plug 'tpope/vim-repeat'
Plug 'ibhagwan/fzf-lua'
Plug 'AckslD/nvim-neoclip.lua'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'jbyuki/venn.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'L3MON4D3/LuaSnip'
Plug 'sindrets/diffview.nvim'
Plug 'tpope/vim-fugitive'

" nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'saadparwaiz1/cmp_luasnip'

call plug#end()

set background=dark
colorscheme tokyonight

lua require('lsp')
lua require('completion')
lua require('scroll')
lua require('statusline')
lua require('treesitter')
lua require('snippets')
lua require('hop').setup()
lua require('Comment').setup()
lua require('fzf-lua').setup({})
lua require('neoclip').setup()
lua require('diffview').setup({use_icons = false})

" use custom vimspector launch function to handle Java as well as other languages
nnoremap <silent> <leader>dd :lua startVimspector()<CR>

" need this last for it to take precedence
autocmd FileType vimwiki setlocal colorcolumn=""

" fix some really weird gruvbox things
" highlight Visual gui=NONE guifg=NONE guibg=#3a3a3a
" highlight QuickFixLine guifg=Pink guibg=NONE
