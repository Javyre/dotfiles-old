" ---- VimPLug ---- {{{
" Auto-install vimplug if non-existant {{{
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif
" }}}
call plug#begin('~/.vim/plugged')

" ColorSchemes
Plug 'tomasr/molokai'
Plug 'chriskempson/base16-vim'
Plug 'chriskempson/tomorrow-theme'

" Interface
Plug 'scrooloose/nerdtree'
Plug 'Shougo/denite.nvim'
Plug 'easymotion/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Editing
Plug 'Raimondi/delimitMate'
Plug 'terryma/vim-expand-region'
Plug 'junegunn/vim-easy-align'

" Lang
" Plug 'vim-syntastic/syntastic'
Plug 'w0rp/ale'

call plug#end()
" ---- End VimPlug ---- }}}

" ---- Colors {{{1
filetype plugin on
colorscheme molokai
syntax on
highlight Normal ctermbg=None
highlight nonText ctermbg=None

" ---- Interface {{{1
set relativenumber
set number
filetype indent on
set softtabstop=2
set lazyredraw
set laststatus=2 " make airline appear when no split

set showmatch " highlight matching bracket
set incsearch " search while typing
set hlsearch " highlight search

" ---- Functionality {{{1
" make vim save and load the folding of the document each time it loads
" also places the cursor in the last place that it was left.
au BufWinLeave * :silent! mkview
au BufWinEnter * :silent! loadview
set modeline

" }}}1

" ---- Keybinds ---- {{{1
" -- Toggles -- {{{2
function! ToggleRelative()
  if &relativenumber
    set norelativenumber
  else
    set relativenumber
  endif
endfunction
function! ToggleNumber()
  if &number
    set nonumber
  else
    set number
  endif
endfunction
map <Leader>tr :call ToggleRelative()<CR>
map <Leader>tn :call ToggleNumber()<CR>
" -- Misc -- {{{2
set mouse=a
let mapleader="\<space>"
" clear search highlight
noremap <Leader>sc :noh<CR>
" increment and decrement
noremap <Leader>+ <C-a>
noremap <Leader>= <C-a>
noremap <Leader>- <C-x>

" -- Quit -- {{{2
noremap <Leader>qq :wqall<CR>

" -- Windows -- {{{2
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

" -- Buffers -- {{{2
" close buffer
noremap <Leader>bd :bd<CR>
" noremap <Leader>bb :CtrlPBuffer<CR>
noremap <Leader>bb :Denite -winheight=13 buffer<CR>

" -- Tabs -- {{{2
" Go to last active tab
let g:lasttab = 1
au TabLeave * let g:lasttab = tabpagenr()
noremap <silent> <Leader><tab> :exe "tabn ".g:lasttab<cr>

" -- Files -- {{{2
noremap <Leader>fs :w<CR>
noremap <Leader>ff :DeniteBufferDir -winheight=13 file_rec<CR>
noremap <Leader>pf :DeniteProjectDir -winheight=13 file_rec<CR>

" -- Selection -- {{{2
map <Leader>v <Plug>(expand_region_expand)
map <Leader>V <Plug>(expand_region_shrink)

" -- Navigation -- {{{2
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
map <Leader>Jh <Plug>(easymotion-linebackward)
map <Leader>Jl <Plug>(easymotion-lineforward)

map <C-j> <Plug>(easymotion-j)
map <C-k> <Plug>(easymotion-k)
map <C-h> <Plug>(easymotion-linebackward)
map <C-l> <Plug>(easymotion-lineforward)
" -- Editing -- {{{2
xmap <Leader>ea <Plug>(EasyAlign)
nmap <Leader>ea <Plug>(EasyAlign)
" }}}
" }}}

" ---- Plugins ---- {{{1
" Vim-Plug {{{2
let g:plug_window = 'botright 13 new'
" auto-install plugins
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" Easymotion {{{2
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Denite {{{2
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


" Syntastic {{{2
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
"
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" A.L.E.{{{2
set statusline+=%#warningmsg#
set statusline+=%{ALEGetStatusLine()}
set statusline+=%*

let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']

let g:ale_python_flake8_executable = 'python3'
let g:ale_python_flake8_args = '-m flake8'

let g:ale_python_pylint_executable = 'python3'
" vim-airline {{{2
let g:airline_theme='jellybeans'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Base16 {{{2
"     If base16-shell exists, vim will activate the
"     right theme to match the base16-shell theme
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
  highlight Normal ctermbg=None
  highlight nonText ctermbg=None
endif

" }}}
" }}}

" vim:foldmethod=marker:foldlevel=0
