" ---- VimPLug ---- {{{
" Auto-install vimplug if non-existant {{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
" }}}
call plug#begin('~/.vim/plugged')

" ColorSchemes
Plug 'tomasr/molokai'
Plug 'chriskempson/base16-vim'
Plug 'chriskempson/tomorrow-theme'
Plug 'nanotech/jellybeans.vim'

" Interface
Plug 'LeafCage/yankround.vim'
Plug 'thaerkh/vim-workspace'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'lucidstack/ctrlp-mpc.vim'
Plug 'lokikl/vim-ctrlp-ag'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'easymotion/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'breuckelen/vim-resize'

" Editing
Plug 'Chiel92/vim-autoformat'
Plug 'reedes/vim-pencil'
Plug 'tpope/vim-commentary'
Plug 'Raimondi/delimitMate'
Plug 'terryma/vim-expand-region'
Plug 'junegunn/vim-easy-align'
Plug 'terryma/vim-multiple-cursors'
Plug 'wellle/targets.vim'
Plug 'tweekmonster/braceless.vim'

" Lang
Plug 'majutsushi/tagbar'
Plug 'w0rp/ale'
Plug 'davidhalter/jedi-vim'
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/neocomplete.vim'
endif
" Plug 'Valloric/YouCompleteMe', {'do': './intall.py --all'}
Plug 'vim-python/python-syntax'
Plug 'vim-scripts/indentpython.vim'


call plug#end()
" ---- End VimPlug ---- }}}

" ---- Colors {{{1
filetype plugin on
colorscheme molokai
syntax on

" ---- Interface {{{1
set relativenumber
set number

" -- soft tabs --
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

set lazyredraw
set laststatus=2 " make airline appear when no split

set scrolloff=3
set sidescrolloff=5

set showmatch " highlight matching bracket
set incsearch " search while typing
set hlsearch " highlight search

set showcmd
set notimeout
set nottimeout

" ---- Functionality {{{1
" make vim save and load the folding of the document each time it loads
" also places the cursor in the last place that it was left.
au BufWinLeave * :silent! mkview
au BufWinEnter * :silent! loadview
set modeline
set history=1000
set encoding=utf-8
set foldmethod=syntax

" autoformatting in python
au FileType python setlocal formatprg=autopep8\ -
au FileType python setlocal fo=cqa

" }}}1

" ---- Keybinds ---- {{{1
" -- Misc -- {{{2
set mouse=a
let mapleader="\<space>"
" clear search highlight
noremap <Leader>sc :noh<CR>
" increment and decrement
noremap <Leader>+ <C-a>
noremap <Leader>= <C-a>
noremap <Leader>- <C-x>

" exit insert and visual mode instantly
inoremap <ESC> <ESC>jk
vnoremap <ESC> <ESC>jk

" yankround
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
noremap <Leader>ry :CtrlPYankRound<CR>

" -- Toggles -- {{{2
noremap <Leader>tr :call ToggleRelative()<CR>
noremap <Leader>tn :call ToggleNumber()<CR>
noremap <Leader>t- :call ToggleCenteredPoint()<CR>
noremap <Leader>tw :ToggleWorkspace<CR>
noremap <Leader>tt :TagbarToggle<CR>

function! ToggleCenteredPoint()
  if !exists('b:center_point') || !b:center_point
    let b:center_point = 1
    call feedkeys('zz', 'n')
    noremap <buffer> j jzz
    noremap <buffer> k kzz
    noremap <buffer> L Lzz
    noremap <buffer> H Hzz
    noremap <buffer> # #zz
    noremap <buffer> * *zz
    noremap <buffer> n nzz
    noremap <buffer> N Nzz
    echo 'Centered Point: on'
  else
    let b:center_point = 0
    noremap <buffer> j j
    noremap <buffer> k k
    noremap <buffer> L L
    noremap <buffer> H H
    noremap <buffer> # #
    noremap <buffer> * *
    noremap <buffer> n n
    noremap <buffer> N N
    echo 'Centered Point: off'
  endif
endfunction

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

" resize window
nnoremap <silent> <c-left> :CmdResizeLeft<cr>
nnoremap <silent> <c-down> :CmdResizeDown<cr>
nnoremap <silent> <c-up> :CmdResizeUp<cr>
nnoremap <silent> <c-right> :CmdResizeRight<cr>

" -- Buffers -- {{{2
" close buffer
noremap <Leader>bd :bd<CR>
noremap <Leader>bb :CtrlPBuffer<CR>
noremap <silent> <Leader><tab> <C-^>
" -- Tabs -- {{{2
" Go to last active tab
let g:lasttab = 1
au TabLeave * let g:lasttab = tabpagenr()
noremap <silent> <Leader>t<tab> :exe "tabn ".g:lasttab<cr>

" -- Files -- {{{2
noremap <Leader>fs :w<CR>
noremap <Leader>ff :CtrlP<CR>
noremap <Leader>fF :e<space>
noremap <Leader>fm :CtrlPMRUFiles<CR>

nnoremap <Leader>/ :CtrlPag<CR>
vnoremap <Leader>/ :CtrlPagVisual<CR>

" noremap <Leader>ff :FZF --reverse --height 11<CR>
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
au FileType python inoremap {<CR> {<CR>}<Esc>O

xmap <Leader>ea <Plug>(EasyAlign)
nmap <Leader>ea <Plug>(EasyAlign)

" format paragraph and format selection
nnoremap <silent> <leader>F gqap
xnoremap <silent> <leader>F gq

" multiple cursors
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
let g:multi_cursor_start_key='<C-n>'
let g:multi_cursor_start_word_key='g<C-n>'
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

" Vim-Workspace {{{2
let g:workspace_session_name = '.session.vim'
let g:workspace_persist_undo_history = 0
let g:workspace_autosave_untrailspaces = 1
let g:workspace_autosave_always = 1

" Vim Resize {{{2
let g:vim_resize_disable_auto_mappings = 1

" Easymotion {{{2
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0 " Disable default mappings


" Denite {{{2
" Change mappings.
" call denite#custom#map(
"       \ 'insert',
"       \ '<C-j>',
"       \ '<denite:move_to_next_line>',
"       \ 'noremap'
"       \)
" call denite#custom#map(
"       \ 'insert',
"       \ '<C-k>',
"       \ '<denite:move_to_previous_line>',
"       \ 'noremap'
" \)

" Change ignore_globs
" call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
"       \ [ '.git/', '__pycache__/', 'venv/', '*.min.*', '*.pyc'])

" CtrlP {{{2
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_brief_prompt = 1
let g:ctrlp_user_command = 'ag %s
    \ $((hg root || git rev-parse --show-toplevel || pwd) 2> /dev/null)
    \ -i --nocolor --nogroup --hidden
    \ --ignore .git
    \ --ignore .svn
    \ --ignore .hg
    \ --ignore .DS_Store
    \ --ignore "**/*.pyc"
    \ -g ""'
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
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>'
let g:ale_sign_warning = '-'
let g:ale_statusline_format = [' %d', ' %d', ' ok']

let g:ale_python_mypy_options = '--python-version 3.6'
let g:ale_python_flake8_executable = 'python3'
let g:ale_python_flake8_args = '-m flake8'
let g:ale_python_pylint_executable = 'python3'

set statusline+=%#warningmsg#
set statusline+=%{ALEGetStatusLine()}
set statusline+=%*

" Jedi-Vim{{{2
let g:jedi#use_splits_not_buffers = "top"

" using neocomplete, we disable the jedi bindings
let g:jedi#completions_enabled = 0
let g:jedi#goto_command = ""
let g:jedi#goto_assignments_command = ""
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = ""
let g:jedi#usages_command = ""
let g:jedi#completions_command = ""
let g:jedi#rename_command = ""

" let g:jedi#goto_command = "<leader>cd"
" let g:jedi#goto_assignments_command = "<leader>cg"
" let g:jedi#goto_definitions_command = ""
" let g:jedi#documentation_command = "K"
" let g:jedi#usages_command = "<leader>cn"
" let g:jedi#completions_command = "<C-Space>"
" let g:jedi#rename_command = "<leader>cr"

" Neocomplete/Deoplete{{{2
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
let g:deoplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
let g:deoplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

inoremap <expr><C-j> pumvisible()? "\<C-n>" : "\<C-j>"
inoremap <expr><C-k> pumvisible()?  "\<C-p>" : "\<C-k>"

if !has('nvim')
    " Plugin key-mappings.
     inoremap <expr><C-g>     neocomplete#undo_completion()
     inoremap <expr><C-l>     neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
      " For no inserting <CR> key.
      "return pumvisible() ? "\<C-y>" : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif
      "let g:neocomplete#sources#omni#input_patterns.php = '[^.  \t]->\h\w*\|\h\w*::'
      "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
      "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

    autocmd FileType python setlocal omnifunc=jedi#completions
    let g:jedi#completions_enabled = 0
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#smart_auto_mappings = 0
    if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
    endif
    let g:neocomplete#force_omni_input_patterns.python =
    \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
    " alternative pattern: '\h\w*\|[^. \t]\.\w*'
else
	" <C-h>, <BS>: close popup and delete backword char.
	inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
	inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

	" <CR>: close popup and save indent.
	inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
	function! s:my_cr_function() abort
	  return deoplete#close_popup() . "\<CR>"
	endfunction


	inoremap <silent><expr> <TAB>
                \ pumvisible() ? "\<C-n>" :
                \ <SID>check_back_space() ? "\<TAB>" :
                \ deoplete#mappings#manual_complete()
	function! s:check_back_space() abort "{{{
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~ '\s'
	endfunction "}}}
endif
" Y.C.M.{{{2
" let g:ycm_server_python_interpreter = 'python3'
" let g:ycm_python_binary_path = 'python3'

" let g:ycm_autoclose_preview_window_after_completion=1
" let g:ycm_filepath_completion_use_working_dir = 1
" let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<C-j>']
" let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>', '<C-k>']
" let g:ycm_semantic_triggers =  {
"   \   'c' : ['->', '.'],
"   \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
"   \             're!\[.*\]\s'],
"   \   'ocaml' : ['.', '#'],
"   \   'cpp,objcpp' : ['->', '.', '::'],
"   \   'perl' : ['->'],
"   \   'php' : ['->', '::'],
"   \   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
"   \   'ruby' : ['.', '::'],
"   \   'lua' : ['.', ':'],
"   \   'erlang' : [':'],
"   \ }

" vim-airline {{{2
let g:airline_theme='jellybeans'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 0

let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'c'  : 'C',
  \ 'v'  : 'V',
  \ 'V'  : 'V',
  \ '' : 'V',
  \ 's'  : 'S',
  \ 'S'  : 'S',
  \ '' : 'S',
  \ }

let g:airline_section_z='%{ALEGetStatusLine()}'

" Base16 {{{2
"     If base16-shell exists, vim will activate the
"     right theme to match the base16-shell theme
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
  hi Statement ctermfg=02
  hi Special   ctermfg=02
  hi String    ctermfg=06
endif

" Python-Syntax {{{2
let g:python_highlight_all = 1
" Pencil {{{2
let g:airline_section_x = '%{PencilMode()}'
" AutoFormat {{{2
let g:formatdef_autopep8 = '"autopep8 -".(g:DoesRangeEqualBuffer(a:firstline, a:lastline) ? " --range ".a:firstline." ".a:lastline : "")." ".(&textwidth ? "--max-line-length=".&textwidth : ""). " --ignore E225,E226,E24,W503"'
" Braceless {{{2
autocmd FileType python BracelessEnable +indent
" }}}
" }}}

" hi Statement ctermfg=1
" hi function ctermfg=6
" " idk...
" hi String ctermfg=223
" hi Special ctermfg=215

highlight Normal     ctermbg=None
highlight nonText    ctermbg=None
highlight SignColumn ctermbg=None
highlight LineNr     ctermbg=None

" vim:foldmethod=marker:filetype=vim
