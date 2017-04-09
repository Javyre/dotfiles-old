" ---- VimPLug ----
call plug#begin('~/.vim/plugged')

" ColorSchemes
Plug 'tomasr/molokai'
Plug 'chriskempson/base16-vim'
Plug 'chriskempson/tomorrow-theme'

" Interface
Plug 'scrooloose/nerdtree'
Plug 'Shougo/denite.nvim'
Plug 'easymotion/vim-easymotion'
Plug 'Raimondi/delimitMate'
Plug 'terryma/vim-expand-region'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'hecal3/vim-leader-guide'

" Lang
Plug 'vim-syntastic/syntastic'

call plug#end()
" ---- End VimPlug ----




" ---- Colors
filetype plugin on
colorscheme molokai
syntax on
highlight Normal ctermbg=None
highlight nonText ctermbg=None

" ---- Interface
set relativenumber
filetype indent on
set lazyredraw
set laststatus=2 " make airline appear when no split

set showmatch " highlight matching bracket
set incsearch " search while typing
set hlsearch " highlight search





" ---- Keybinds
" -- Misc --
set mouse=a
let mapleader="\<space>"
" clear search highlight
noremap <Leader>sc :noh<CR>

" -- Quit --
noremap <Leader>qq :wqall<CR>

" -- Windows --
" move around windows
noremap <Leader>wh <C-w>h
noremap <Leader>wj <C-w>j
noremap <Leader>wk <C-w>k
noremap <Leader>wl <C-w>l

" split window
noremap <Leader>w- :sp<CR>
noremap <Leader>w/ :vsp<CR>

" maximize window (closes all other windows but focused one)
noremap <Leader>wm <C-w>o

" -- Buffers --
" close buffer
noremap <Leader>bd :bd<CR>
" noremap <Leader>bb :CtrlPBuffer<CR>
noremap <Leader>bb :Denite -winheight=13 buffer<CR>

" -- Tabs --
" Go to last active tab
let g:lasttab = 1
au TabLeave * let g:lasttab = tabpagenr()
noremap <silent> <Leader><tab> :exe "tabn ".g:lasttab<cr>

" -- Files --
noremap <Leader>fs :w<CR>
noremap <Leader>ff :DeniteBufferDir -winheight=13 file_rec<CR>
noremap <Leader>pf :DeniteProjectDir -winheight=13 file_rec<CR>

" -- Selection --
map <Leader>v <Plug>(expand_region_expand)
map <Leader>V <Plug>(expand_region_shrink)

" -- Navigation --
" override search
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

" <Leader>jj{char} to jump to {char}
map  <Leader>jj <Plug>(easymotion-bd-f)
nmap <Leader>jj <Plug>(easymotion-overwin-f)

" <Leader>jJ{char} to jump to {char}
map  <Leader>jJ <Plug>(easymotion-bd-f2)
nmap <Leader>jJ <Plug>(easymotion-overwin-f2)

" Jump to line
map <Leader>jl  <Plug>(easymotion-bd-jk)
nmap <Leader>jl <Plug>(easymotion-overwin-line)

" Jump to word
map  <Leader>jw <Plug>(easymotion-bd-w)
nmap <Leader>jw <Plug>(easymotion-overwin-w)

" Repeat last jump motion
map <Leader>j. <Plug>(easymotion-repeat)

" HJKL motions: Line motions
map <Leader>Jj <Plug>(easymotion-j)
map <Leader>Jk <Plug>(easymotion-k)
map <Leader>Jl <Plug>(easymotion-lineforward)
map <Leader>Jh <Plug>(easymotion-linebackward)


" ---- Plugins
" Easymotion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Denite
" Change mappings.
call denite#custom#map(
      \ 'insert',
      \ '<C-j>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<C-k>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
\)

" Change ignore_globs
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
      \ [ '.git/', '__pycache__/', 'venv/', '*.min.*', '*.pyc'])


" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" vim-airline
let g:airline_theme='base16'
let g:airline_powerline_fonts = 1

" Base16
"     If base16-shell exists, vim will activate the
"     right theme to match the base16-shell theme
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
  highlight Normal ctermbg=None
  highlight nonText ctermbg=None
endif





" set runtimepath+=~/.vim_runtime
"
" source ~/.vim_runtime/vimrcs/basic.vim
" source ~/.vim_runtime/vimrcs/filetypes.vim
" source ~/.vim_runtime/vimrcs/plugins_config.vim
" source ~/.vim_runtime/vimrcs/extended.vim
"
" try
" source ~/.vim_runtime/my_configs.vim
" catch
" endtry
"
" set number


