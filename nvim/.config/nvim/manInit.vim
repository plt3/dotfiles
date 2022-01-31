set hidden
set termguicolors
set tabstop=2 softtabstop=2
set shiftwidth=2
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
set incsearch
set undofile
set noswapfile
set nobackup
set scrolloff=8

" remap leader key
let mapleader = " "
" to copy/paste to/from system clipboard
nnoremap <leader>y  "+y
nnoremap <leader>Y  "+y$
" easier way to switch to alternate buffer
nnoremap <leader>c <C-^>

" use ripgrep for :Grep command
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat=%f:%l:%c:%m,%f:%l:%m
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

" Write all buffers before navigating from Vim to tmux pane
let g:tmux_navigator_save_on_switch = 2

nnoremap <silent> - :HopWord<CR>

augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END

let g:gruvbox_italic=1
let g:gruvbox_bold=1
let g:gruvbox_contrast_dark='hard'

call plug#begin('~/.vim/plugged')

Plug 'unblevable/quick-scope'
Plug 'gruvbox-community/gruvbox'
Plug 'christoomey/vim-tmux-navigator'
Plug 'romainl/vim-cool'
Plug 'phaazon/hop.nvim'
Plug 'karb94/neoscroll.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'

call plug#end()

set background=dark
colorscheme gruvbox

lua require('scroll')
lua require('statusline')
lua require('hop').setup()

" fix some really weird gruvbox things
highlight Visual gui=NONE guifg=NONE guibg=#3a3a3a
highlight QuickFixLine guifg=Pink guibg=NONE
