"_______________________________________________________________________
"                                                                       |
" => Vundle 								                            |
"_______________________________________________________________________|
"set rtp+=~/.vim/bundle/vundle/
"call vundle#begin()
call plug#begin('~/.vim/plugged')
"Plug 'liuchengxu/space-vim-dark'
"Plug 'kana/vim-textobj-line'
"Plug 'jmcantrell/vim-virtualenv'
"Plug 'wkentaro/conque.vim'
Plug 'gregsexton/gitv'
Plug 'laurentgoudet/vim-howdoi'
Plug 'gcmt/taboo.vim'
"Plug 'terryma/vim-multiple-cursors'
Plug 't9md/vim-quickhl'
Plug 'maxbrunsfeld/vim-yankstack'
"Plug 'vim-scripts/YankRing.vim'
Plug 'yegappan/mru'
Plug 'mileszs/ack.vim'
"Plug 'rking/ag.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'junegunn/limelight.vim'
Plug 'lepture/vim-jinja'
Plug 'dhruvasagar/vim-table-mode'
Plug 'christoomey/vim-tmux-navigator'
Plug 'flazz/vim-colorschemes'
Plug 'junegunn/goyo.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-surround'
Plug 'rbgrouleff/bclose.vim'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'joom/turkish-deasciifier.vim'
Plug 'mattn/gist-vim'
Plug 'elzr/vim-json'
Plug 'tmux-plugins/vim-tmux'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'amiorin/ctrlp-z'
Plug 'amiorin/vim-fasd'
Plug 'amiorin/vim-fenced-code-blocks'
Plug 'Shougo/vimproc.vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'tomtom/tlib_vim'
Plug 't9md/vim-chef'
Plug 'justinmk/vim-sneak'
Plug 'orlandov/vimfluence'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-obsession'
Plug 'Raimondi/delimitMate'
Plug 'hron84/vim-librarian'
Plug 'SirVer/ultisnips'
Plug 'vim-ruby/vim-ruby'
Plug 'honza/vim-snippets'
Plug 'beloglazov/vim-online-thesaurus'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'idanarye/vim-merginal'
Plug 'tpope/vim-git'
Plug 'airblade/vim-gitgutter'
Plug 'kien/ctrlp.vim'
"Plug 'jistr/vim-nerdtree-tabs'
Plug 'Shougo/neocomplete.vim'
Plug 'klen/python-mode'
Plug 'vim-scripts/indentpython.vim'
Plug 'ehamberg/vim-cute-python'
Plug 'vim-scripts/Align'
Plug 'vim-syntastic/syntastic'
Plug 'myint/syntastic-extras'
Plug 'tmhedberg/SimpylFold'
Plug 'Valloric/YouCompleteMe'
Plug 'nvie/vim-flake8'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-eunuch'
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
"Plug 'ntpeters/vim-better-whitespace'
"Plug 'chrisbra/csv.vim'
""Plug 'MattesGroeger/vim-bookmarks'
""Plug 'tmux-plugins/vim-tmux-focus-events'
""Plug 'saevarb/chronos'
""Plug 'vim-scripts/FormatToWidth'
""Plug 'L9'
""Plug 'nathanaelkane/vim-indent-guides'
""Plug 'mattn/webapi-vim'
""Plug 'vim-scripts/nginx.vim'
""Plug 'davidhalter/jedi-vim'
""Plug 'neilagabriel/vim-geeknote'
""Plug 'Wolfy87/vim-expand'
""Plug 'vivien/vim-addon-linux-coding-style'
""Plug 'reedes/vim-pencil'
""Plug 'chrisbra/csv.vim'
""Plug 'jez/vim-superman'
""Plug 'tpope/vim-repeat'
""Plug 'tpope/vim-speeddating'
""Plug 'richsoni/vim-ecliptic'
""Plug 'plasticboy/vim-markdown'
""Plug 'tpope/vim-markdown'
""Plug 'vim-scripts/ZoomWin'
""Plug 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
""Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
call plug#end()

"_______________________________________________________________________
" => genel ayarlar 							                                        |
"_______________________________________________________________________|
"colorscheme flattened_dark
" signcolumn gizleme
" :sign unplace *

"colorscheme molokai
"let s:color_override_dark = '
"    \ if &background == "dark"
"    \ | hi StatusLine    guifg=#000000 guibg=#ffffff gui=NONE  ctermfg=16 ctermbg=15     cterm=NONE
"    \ | hi CursorLine    guibg=#293739 ctermbg=236
"    \ | hi PmenuSel      guibg=#0a9dff guifg=white   gui=NONE  ctermbg=39 ctermfg=white  cterm=NONE
"    \ | hi PmenuSbar     guibg=#857f78
"    \ | hi PmenuThumb    guifg=#242321
"    \ | hi WildMenu      gui=NONE cterm=NONE guifg=#f8f6f2 guibg=#0a9dff ctermfg=255 ctermbg=39
"    \ | hi DiffAdd       guifg=#ffffff guibg=#006600 gui=NONE  ctermfg=231  ctermbg=22   cterm=NONE
"    \ | hi DiffChange    guifg=#ffffff guibg=#007878 gui=NONE  ctermfg=231  ctermbg=30   cterm=NONE
"    \ | hi DiffDelete    guifg=#ff0101 guibg=#9a0000 gui=NONE  ctermfg=196  ctermbg=88   cterm=NONE
"    \ | hi DiffText      guifg=#000000 guibg=#ffb733 gui=NONE  ctermfg=000  ctermbg=214  cterm=NONE
"    \ | hi MatchParen    guifg=NONE   guibg=NONE gui=underline ctermfg=NONE ctermbg=NONE cterm=underline
"    \ | endif
"    \'
"if has('vim_starting') "only on startup
"  exe 'autocmd ColorScheme * '.s:color_override_dark
"  " expects &runtimepath/colors/{name}.vim.
"  silent! colorscheme molokai
"endif

colorscheme DevC++
let s:color_override_dark = '
    \ if &background == "dark"
    \ | hi StatusLine    guifg=#000000 guibg=#ffffff gui=NONE  ctermfg=16 ctermbg=15     cterm=NONE
    \ | hi CursorLine    guibg=#293739 ctermbg=236
    \ | hi PmenuSel      guibg=#0a9dff guifg=white   gui=NONE  ctermbg=39 ctermfg=white  cterm=NONE
    \ | hi PmenuSbar     guibg=#857f78
    \ | hi PmenuThumb    guifg=#242321
    \ | hi WildMenu      gui=NONE cterm=NONE guifg=#f8f6f2 guibg=#0a9dff ctermfg=255 ctermbg=39
    \ | hi DiffAdd       guifg=#ffffff guibg=#006600 gui=NONE  ctermfg=231  ctermbg=22   cterm=NONE
    \ | hi DiffChange    guifg=#ffffff guibg=#007878 gui=NONE  ctermfg=231  ctermbg=30   cterm=NONE
    \ | hi DiffDelete    guifg=#ff0101 guibg=#9a0000 gui=NONE  ctermfg=196  ctermbg=88   cterm=NONE
    \ | hi DiffText      guifg=#000000 guibg=#ffb733 gui=NONE  ctermfg=000  ctermbg=214  cterm=NONE
    \ | hi ExtraWhitespace ctermbg=blue
    \ | hi MatchParent   guifg=none   guibg=none gui=underline ctermfg=none ctermbg=none cterm=underline
    \ | endif
    \'
if has('vim_starting') "only on startup
  exe 'autocmd ColorScheme * '.s:color_override_dark
  " expects &runtimepath/colors/{name}.vim.
  silent! colorscheme DevC++
endif

"   \ | hi BadWhitespace guifg=none   guibg=none gui=underline ctermfg=none ctermbg=none cterm=underline
set nojoinspaces
set guioptions-=L
"set scrollbind
set encoding=utf-8
set textwidth=79
"set mouse=nv
set modifiable
autocmd VimResized * wincmd =
set hidden
"set wildmenu            " visual autocomplete for command menu"
set lazyredraw          " redraw only when we need to."
set showmatch           " highlight matching [{()}]}]"
nnoremap gV `[v`]`
set equalalways
"set noea
set background=light
filetype plugin on
filetype plugin indent on
filetype indent on
set nocompatible              " be iMproved, required
filetype on
syntax enable
"let python_highlight_all=1
syntax on
set splitright
set autoread
set linebreak
set foldmethod=indent
set foldlevel=99
"set foldcolumn=4
set breakindent
"set showbreak=\ \
set backspace=eol,start	 " allow backspacing over everything in insert mode
set ignorecase     " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop
"set incsearch      " highlight search terms
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
set nobackup
"set noswapfile
set swapfile
set pastetoggle=<F2>
set nocindent  " Switch off all auto-indenting
set nosmartindent
set noautoindent
set shiftround
set indentexpr=
set clipboard=unnamed
"set clipboard=unnamedplus
set go+=a
set showmode
set ruler
set laststatus=0
set showcmd
set nofoldenable
"set dictionary+=k~/turkish_dic.add
"set complete+=k~/turkish_dic
"set spellfile=~/.vim/plugged/ctrlp.vim/spell/en.utf-8.add
"set nu!
"runtime! ftplugin/man.vim
"autocmd FileType man setlocal foldmethod=indent
:au FocusLost * silent! wa
"
"autocmd TextChanged,TextChangedI <buffer> silent write
" Kaynak: http://stackoverflow.com/questions/6991638/how-to-auto-save-a-file-every-1-second-in-vim

"_______________________________________________________________________
" => Gorunum 								                                            |
"_______________________________________________________________________|
hi VertSplit cterm=none gui=none
hi VertSplit ctermfg=00
"hi LineNr guibg=none
hi SignColumn ctermbg=none
hi Search ctermfg=25 ctermbg=16
hi Folded ctermfg=25 ctermbg=16
hi StatusLine cterm=none gui=none
hi StatusLineNC cterm=none gui=none
hi NonText ctermfg=00
hi clear SignColumn
hi link markdownError Normal
hi TabLineFill cterm=none gui=none
hi TabLine ctermfg=none ctermbg=none
hi TabLineSel ctermfg=none ctermbg=none
"hi BadWhitespace ctermfg=none cterm=none ctermbg=blue
set fillchars+=vert:│
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
hi link CSVColumnOdd StatusLine
hi link CSVColumnEven StatusLine
hi link CSVColumnHeaderEven StatusLine
hi link CSVColumnHeaderOdd StatusLine
let g:csv_no_column_highlight = 1


"This line affects the window counter per tab:
"hi Title ctermfg=LightBlue ctermbg=Magenta
"hi TabLineFill ctermfg=LightGreen ctermbg=DarkGreen
"hi TabLine cterm=none gui=none
"hi TabLineSel cterm=none gui=none

 "autocmd BufEnter,BufRead,BufNewFile *.md syntax off
" autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" autocmd BufEnter,BufRead,BufNewFile * set nu!
"_______________________________________________________________________
" => Ozel karakterler 							                                    |
"_______________________________________________________________________|
let g:AutoCloseProtectedRegions = ["Character"]"
" modify selected text using combining diacritics
command! -range -nargs=0 Overline        call s:CombineSelection(<line1>, <line2>, '0305')
command! -range -nargs=0 Underline       call s:CombineSelection(<line1>, <line2>, '0332')
command! -range -nargs=0 DoubleUnderline call s:CombineSelection(<line1>, <line2>, '0333')
command! -range -nargs=0 Strikethrough   call s:CombineSelection(<line1>, <line2>, '0336')
function! s:CombineSelection(line1, line2, cp)
  execute 'let char = "\u'.a:cp.'"'
  execute a:line1.','.a:line2.'s/\%V[^[:cntrl:]]/&'.char.'/ge'
endfunction
"_______________________________________________________________________
" => Kisayollar 							                                          |
"_______________________________________________________________________|
"let mapleader=" "
"noremap j h
"noremap k j
"noremap l k
"noremap ; l
map t i <ESC>r
"nnoremap ; o <ESC>
nmap ; o<Esc>
nmap <CR> o<Esc>

noremap gr gT
":nnoremap f }) \| zt
":nnoremap s {( \| zt
nnoremap <C-a> }) \| zz
nnoremap <C-s> {( \| zz
"noremap <C-a> }) \| zt
"noremap <C-s> {( \| zt
" :map f })
" :map s {(
"noremap <Leader>P "*p

"""" Window'u acik tut, buffer yonet
" buffer'i kaydet
nnoremap <Leader>w :w<bar>:Bclose!<cr>
" buffer'i kaydetme
nnoremap <Leader>q :Bclose!<cr>

" buffer'lari kaydet
noremap <Leader>s :wall<CR>
"noremap <Leader>e :wall<CR>

"""" Window'u kapatip buffer yonet
" buffer'i kaydet
noremap <S-w> :wqall!<CR>
" buffer'lari kaydetme
noremap <S-q> :bdelete!<cr>
noremap <S-e> :qall!<cr>
ca <C-w>q :tabclose!<CR>
ca <C-w>e :tabnew!<CR>

"ca <C-w tabnew
"ca th tabp
"ca tl tabn
nnoremap <Leader>y :set nu!<CR>
nnoremap <S-f> :set foldenable<CR>
"nnoremap <Leader>o :r!cat<CR> " kullanimda
nnoremap <Leader>g :Gstatus<CR>
"nnoremap <Leader>p :Gpush<CR>
"nnoremap <Leader>g :GitGutterToggle<CR>
nnoremap <Leader>u :GitGutterToggle<CR>
nnoremap <Leader>m :MerginalToggle<CR>
"nnoremap <C-w>e :enew<cr>
"map <C-e> <Nop>
"vnoremap <Leader>p "*p
cnoreabbrev Wq wq
cnoreabbrev Q! q!
cnoreabbrev W w
cnoreabbrev Q q
" FZF'yi baslat
noremap <C-e> :FZF ~<CR>
"noremap <C-w> :FZF ~<CR>
"noremap <S-f> :FZF ~<CR>
"nnoremap <leader>n :w<bar>:bNext<CR>
"nnoremap <leader>p :w<bar>:bprevious<CR>
nnoremap <C-n> :BuffergatorMruCycleNext<cr>
nnoremap <C-p> :BuffergatorMruCyclePrev<CR>
"nnoremap  <C-n> :bn<cr>
"nnoremap  <C-p> :bp<cr>
nnoremap / /\v
vnoremap / /\v
nnoremap <Leader>l :Limelight<CR>
nnoremap <Leader>k :Limelight!<CR>
nnoremap <Leader>h :nohl<CR>

" Python'a ozel ayarlar
"au BufNewFile,BufRead *.py
"au BufNewFile,BufRead *.py,*.pyw,*.c,*.h
"    \ set textwidth=79 |
"    \ set tabstop=4 |
"    \ set shiftwidth=4 |
"    \ set softtabstop=4 |
"    \ set expandtab |
"    \ set autoindent |
"    \ set fileformat=unix |
"    \ set number! |
"    \ set shiftround |


"   \ match BadWhitespace /\s\+$/ |
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/



"_______________________________________________________________________
" => emrah .vimrc 							                                        |
"_______________________________________________________________________|

"" autocmd BufNewFile,BufRead *.txt,*.md,*.yaml,*.yml,*.sh,*.rst,*.markdown call CodingSet1()
"" function CodingSet1()
""         setlocal
""         \ textwidth=79
""         \ tabstop=8
""         \ shiftwidth=4
""         \ softtabstop=4
""         \ expandtab
""         \ autoindent
""         \ list
""         \ listchars=tab:··,trail:·
""         \ filetype=txt
""         \ syntax=conf
"" endfunction

"_______________________________________________________________________
" => vim-tmux-navigator 						                                    |
"_______________________________________________________________________|
 if exists('$TMUX')
   function! TmuxOrSplitSwitch(wincmd, tmuxdir)
     let previous_winnr = winnr()
     silent! execute "wincmd " . a:wincmd
     if previous_winnr == winnr()
       call system("tmux select-pane -" . a:tmuxdir)
       redraw!
     endif
   endfunction

   let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
   let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
   let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

   nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
   nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
   nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
   nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
 else
   map <C-h> <C-w>h
   map <C-j> <C-w>j
   map <C-k> <C-w>k
   map <C-l> <C-w>l
 endif

"_______________________________________________________________________
" => goyo.vim								                                            |
"_______________________________________________________________________|
 nnoremap <silent> <leader>x :Goyo<cr>

function! GoyoBefore()
"  if exists('$TMUX')
"    silent !tmux set status off
"  endif
  Limelight
endfunction

function! GoyoAfter()
"  if exists('$TMUX')
"    silent !tmux set status off
"  endif
 set background=light
 hi clear SignColumn
 hi VertSplit cterm=none gui=none
 hi NonText ctermfg=00
 hi TabLineFill cterm=none gui=none
 hi TabLine ctermfg=none ctermbg=none
 hi TabLineSel ctermfg=none ctermbg=none
 Limelight!
endfunction
let g:goyo_callbacks = [function('GoyoBefore'), function('GoyoAfter')]
function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

autocmd User GoyoEnter call <SID>goyo_enter()
autocmd User GoyoLeave call <SID>goyo_leave()

"set winheight=7
"set winminheight=7
"set winheight=999
"Kaynak: https://github.com/junegunn/goyo.vim/issues/13

"_______________________________________________________________________
" => neocomplete							                                          |
"_______________________________________________________________________|
"set runtimepath+=~/.vim/plugged/neocomplete.vim/
"set fo+=aw
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
"let g:acp_enableAtStartup = 0
" Use neocomplete.
"let g:neocomplete#enable_at_startup = 0
"let g:neocomplete#enable_auto_select = 0
"" Use smartcase.
"let g:neocomplete#enable_smart_case = 1
"" Set minimum syntax keyword length.
"let g:neocomplete#sources#syntax#min_keyword_length = 3
"let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
""let g:neocomplete#sources#dictionary#dictionaries = {
""     \ '_' : '~/.vim/plugged/ctrlp.vim/spell/en.utf-8.add',
""     \ 'english' : '/usr/share/dict/american-english'
""     \ }
""let g:neocomplete#sources#dictionary#dictionaries = {
""    \ '_' : '~/turkish.dic_calisma',
""    \ 'vimshell' : $HOME.'/.vimshell_hist',
""    \ 'scheme' : $HOME.'/.gosh_completions'
""    \ }
"" Define keyword.
"if !exists('g:neocomplete#keyword_patterns')
"    let g:neocomplete#keyword_patterns = {}
"endif
"let g:neocomplete#keyword_patterns['default'] = '\h\w*'
"" Plugin key-mappings.
"inoremap <expr><C-g>     neocomplete#undo_completion()
"inoremap <expr><C-l>     neocomplete#complete_common_string()
"" Recommended key-mappings.
"" <CR>: close popup and save indent.
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"function! s:my_cr_function()
"  return neocomplete#close_popup() . "\<CR>"
"  " For no inserting <CR> key.
"  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
"endfunction
"" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplete#close_popup()
"inoremap <expr><C-e>  neocomplete#cancel_popup()
"" Enable omni completion.
"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"" Enable heavy omni completion.
"if !exists('g:neocomplete#sources#omni#input_patterns')
"  let g:neocomplete#sources#omni#input_patterns = {}
"endif
"" For perlomni.vim setting.
"" https://github.com/c9s/perlomni.vim
"let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

"_______________________________________________________________________
" => NERDTREE 								                                          |
"_______________________________________________________________________|
" Yapilandirma Kaynak: https://github.com/scrooloose/nerdtree
" Bos vim buffer'i acildiginda baslatma
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Leader key ile acma
"" map <Leader>n :NERDTreeMapToggleHidden<CR>
map <Leader>n :NERDTreeToggle<CR>
" Sadece NERDTREE penceresi aciksa Vim'i otomatik kapat;
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeMapJumpNextSibling = ''
let g:NERDTreeMapJumpPrevSibling = ''
let g:NERDTreeMapJumpLastChild = ''
let g:NERDTreeMapJumpFirstChild = ''
let g:NERDTreeWinSize=31
let g:NERDTreeDirArrows=0
"_______________________________________________________________________
" => Vim Indent Color 							                                    |
"_______________________________________________________________________|
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=blue ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

"_______________________________________________________________________
" => Limelight!								                                          |
"_______________________________________________________________________|
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'Black'
let g:limelight_conceal_ctermfg = 0

"hi Conceal        ctermfg=7 ctermbg=242 guifg=#e5e5e5 guibg=#080808
" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'
" Default: 0.5
let g:limelight_default_coefficient = 1

"_______________________________________________________________________
" => turkish-deasciifier.						                                    |
"_______________________________________________________________________|
vmap <Leader>tr :<c-u>call Turkish_Deasciify()<CR>
vmap <Leader>rt :<c-u>call Turkish_Asciify()<CR>
let g:turkish_deasciifier_path = '~/Git_Repolari/diger/turkish-deasciifier/turkish-deasciify'

"_______________________________________________________________________
" => translate-shell							                                      |
"_______________________________________________________________________|

"set keywordprg=trans\ :tr

"_______________________________________________________________________
" => gist-vim								                                            |
"_______________________________________________________________________|

let g:gist_clip_command = 'xclip -selection clipboard'
let g:gist_detect_filetype = 1
"let g:gist_show_privates = 1
" Only :w! updates a gist.
let g:gist_update_on_write = 2


"_______________________________________________________________________
" => Geeknote-vim							                                          |
"_______________________________________________________________________|
noremap <F8> :Geeknote<cr>
autocmd FileType geeknote setlocal nonumber
let g:GeeknoteFormat="markdown"

"_______________________________________________________________________
" => Arama sonuclari yeni pencerede					                            |
"_______________________________________________________________________|
command! -nargs=? Filter let @a='' | execute 'g/<args>/y A' | new | setlocal bt=nofile | put! a

"_______________________________________________________________________
" => clickable								                                          |
"_______________________________________________________________________|
"g:clickable_google-chrome

"_______________________________________________________________________
" => son kaydedilen halinden baslat					                            |
"_______________________________________________________________________|
"au BufWinLeave * mkview
"au BufWinEnter * silent loadview


"_______________________________________________________________________
" => ZoomWin								                                            |
"_______________________________________________________________________|
nnoremap <silent> <Leader>z :ZoomWin<CR>
" kaynak:
" http://stackoverflow.com/questions/15583346/how-can-i-temporarily-make-the-window-im-working-on-to-be-fullscreen-in-vim


"_______________________________________________________________________
" => ctrlP								                                              |
"_______________________________________________________________________|
set runtimepath^=~/.vim/plugged/ctrlp.vim
let g:ctrlp_regexp = 1
let g:ctrlp_map = '<leader>;'
let g:ctrlp_cmd = 'CtrlP'
" kaynak:
" http://kien.github.io/ctrlp.vim

"_______________________________________________________________________
" => ctrlP-z								                                            |
"_______________________________________________________________________|
let g:ctrlp_z_nerdtree = 1
let g:ctrlp_extensions = ['Z', 'F']
"nnoremap sz :CtrlPZ<Cr>
"nnoremap sf :CtrlPF<Cr>
nnoremap <leader>d :CtrlPZ<Cr>
nnoremap <leader>f :CtrlPF<Cr>
" kaynak:
" https://github.com/amiorin/ctrlp-z

"_______________________________________________________________________
" => Python-mode							                                          |
"_______________________________________________________________________|
"
let g:pymode_rope = 0
let g:pymode_syntax = 1

"_______________________________________________________________________
" => Ultisnips								                                          |
"_______________________________________________________________________|

set runtimepath+=~/.vim/ultisnips_rep
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsUsePythonVersion = 2

""_______________________________________________________________________
"" => Neosnippet								                                         |
""_______________________________________________________________________|
"
"\" Plugin key-mappings.
"imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"smap <C-k>     <Plug>(neosnippet_expand_or_jump)
"xmap <C-k>     <Plug>(neosnippet_expand_target)
"
"" SuperTab like snippets behavior.
"imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"\ "\<Plug>(neosnippet_expand_or_jump)"
"\: pumvisible() ? "\<C-n>" : "\<TAB>"
"smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"\ "\<Plug>(neosnippet_expand_or_jump)"
"\: "\<TAB>"
"
"" For snippet_complete marker.
"if has('conceal')
"  set conceallevel=2 concealcursor=i
"endif
"let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

"_______________________________________________________________________
" => Jedi.vim 								                                          |
"_______________________________________________________________________|

"let g:jedi#popup_on_dot = 0

"_______________________________________________________________________
" => ruby-vim 								                                          |
"_______________________________________________________________________|

imap <S-CR>    <CR><CR>end<Esc>-cc
set expandtab
set tabstop=2 shiftwidth=2 softtabstop=2

if !exists( "*EndToken" )
  function EndToken()
    let current_line = getline( '.' )
    let braces_at_end = '{\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'
    if match( current_line, braces_at_end ) >= 0
      return '}'
    else
      return 'end'
    endif
  endfunction
endif

imap <S-CR> <ESC>:execute 'normal o' . EndToken()<CR>O

" Kaynak: https://github.com/vim-ruby/vim-ruby/wiki/VimRubySupport

"_______________________________________________________________________
" => Sneak                                                              |
"_______________________________________________________________________|

let g:sneak#streak = 1

"_______________________________________________________________________
" => Vim-markdown                                                       |
"_______________________________________________________________________|
"
"let g:vim_markdown_folding_disabled=1

"_______________________________________________________________________
" => Vim-bookmarks                                                      |
"_______________________________________________________________________|
"
"nmap <Leader>m <Plug>BookmarkToggle
"nmap <Leader>i <Plug>BookmarkAnnotate
"nmap <Leader>a <Plug>BookmarkShowAll
"nmap <Leader>n <Plug>BookmarkNext
"nmap <Leader>c <Plug>BookmarkClear
"nmap <Leader>x <Plug>BookmarkClearAll
"highlight BookmarkSign ctermbg=NONE ctermfg=160
"highlight BookmarkLine ctermbg=194 ctermfg=NONE
"let g:bookmark_highlight_lines = 1
"let g:bookmark_save_per_working_dir = 1
"let g:bookmark_auto_save = 1
"let g:bookmark_center = 1
"let g:bookmark_manage_per_buffer = 1
"let g:bookmark_sign = '>>'
"let g:bookmark_annotation_sign = '!!'


"_______________________________________________________________________
" => FZF                                                                |
"_______________________________________________________________________|
"
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
" For Commits and BCommits to customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" Advanced customization using autoload functions
autocmd VimEnter * command! Colors
  \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'})

"#TODO Extend For CtrP With Word
 function! FZFExecute()
  " Remove trailing new line to make it work with tmux splits
  let directory = substitute(system('git rev-parse --show-toplevel'), '\n$', '', '')
  if !v:shell_error
   call fzf#run({'sink': 'e', 'dir': directory, 'source': 'git ls-files'})
  else
   FZF
  endif
 endfunction
 command! FZFExecute call FZFExecute()

"Grepping Using FZF #TODO File With :File: Name
 function! s:escape(path)
  return substitute(a:path, ' ', '\\ ', 'g')
 endfunction
 "TODO Extend To Other Handlers
 function! AgHandler(line)
  let parts = split(a:line, ':')
  let [fn, lno] = parts[0 : 1]
  execute 'e '. s:escape(fn)
  execute lno
  normal! zz
 endfunction
function! FZFGrep(pattern, ...)
let filter = a:0 > 0 ? a:1 : '*'
let command = 'ag -i "'.a:pattern.'" '.filter
call fzf#run({
  \ 'source': command,
  \ 'sink': function('AgHandler'),
  \ 'options': '+m'
  \ })
endfunction
command! -nargs=* FZFGrep call FZFGrep(<f-args>)

"Find A Directory
function! FZFDirectory(directory)
  let directory = expand(a:directory)
  let command = 'tree -i -f -d "'.directory.'"'
  call fzf#run({
  \ 'source': command,
  \ 'sink': 'Ex',
  \ 'options': '+e'
  \ })
endfunction
command! -nargs=+ -complete=dir FZFDirectory call FZFDirectory('<args>')

"_______________________________________________________________________
" => vim-multiple-cursors                                               |
"_______________________________________________________________________|
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-m>'
let g:multi_cursor_prev_key='<C-M>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

"_______________________________________________________________________
" => vim-table-mode                                                     |
"_______________________________________________________________________|
"For Markdown-compatible tables use
let g:table_mode_corner="|"

"_______________________________________________________________________
" => ttmaster vimrc'den alinti                                          |
"_______________________________________________________________________|
"
"if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
"   set fileencodings=ucs-bom,utf-8,latin1
"endif
"
"set nocompatible        " Use Vim defaults (much better!)
"set bs=indent,eol,start         " allow backspacing over everything in insert
"mode
""set ai                 " always set autoindenting on
"set backup             " keep a backup file
"set viminfo='20,\"50    " read/write a .viminfo file, don't store more
"                        " than 50 lines of registers
"set history=50          " keep 50 lines of command line history
"set ruler               " show the cursor position all the time
"
"" Only do this part when compiled with support for autocommands
"if has("autocmd")
"  augroup redhat
"  autocmd!
"  " In text files, always limit the width of text to 78 characters
"  autocmd BufRead *.txt set tw=78
"  " When editing a file, always jump to the last cursor position
"  autocmd BufReadPost *
"  \ if line("'\") > 0 && line ("'\") <= line("$") |
"  \   exe "normal! g'\" |
"  \ endif
"  " don't write swapfile on most commonly used directories for NFS mounts or
"  " USB sticks
"  autocmd BufNewFile,BufReadPre /media/*,/mnt/* set
"directory=~/tmp,/var/tmp,/tmp
"  " start with spec file template
"  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
"  augroup END
"endif
"
"if has("cscope") && filereadable("/usr/bin/cscope")
"   set csprg=/usr/bin/cscope
"   set csto=0
"   set cst
"   set nocsverb
"   " add any database in current directory
"   if filereadable("cscope.out")
"      cs add cscope.out
"   " else add database pointed to by environment
"   elseif $CSCOPE_DB != "
"      cs add $CSCOPE_DB
"   endif
"   set csverb
"endif
"
"" Switch syntax highlighting on, when the terminal has colors
"" Also switch on highlighting the last used search pattern.

"if &t_Co > 2 || has("gui_running")
"  syntax on
"  set hlsearch
"endif
"
"filetype plugin on
"
"if &term=="xterm"
"     set t_Co=8
"     set t_Sb=^[[4%dm
"     set t_Sf=^[[3%dm
"endif
"vnoremap yy "*y
"nnoremap yy "*y
"vnoremap y "*y
"nnoremap y "*y
"vnoremap p "*p
"nnoremap p "*p
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }
set t_Co=256
set is
set ic

set pastetoggle=<F2>
"nnoremap <C-c> @='5k'<CR>
"let g:airline#extensions#tabline#enabled = 1
"python from powerline.vim import setup as powerline_setup
"python powerline_setup()
"python del powerline_setup

let g:gitgutter_enabled = 1

" buffer'i kaydetme
"nnoremap <Leader>q :bdelete!<CR>
" buffer'i kaydetme
"nnoremap <Leader>q <bar>:Bclose!<cr> <== usttekiyle ayni

"_______________________________________________________________________
" => vim-fugitive                                                       |
"_______________________________________________________________________|
autocmd QuickFixCmdPost *grep* cwindow

" In text files, always limit the width of text to 78 characters
autocmd  BufEnter,BufRead,BufNewFile,BufReadPost *.tw set textwidth=78
"hi diffAdded   ctermbg=NONE ctermfg=46  cterm=NONE guibg=NONE guifg=#00FF00 gui=NONE
"hi diffRemoved ctermbg=NONE ctermfg=196 cterm=NONE guibg=NONE guifg=#FF0000 gui=NONE
"hi link diffLine String
"hi link diffSubname Normal
if &diff
    colorscheme molokai
endif

"_______________________________________________________________________
" => taboo.vim                                                          |
"_______________________________________________________________________|
"set guioptions-=e
set sessionoptions+=tabpages,globals
set guitablabel=%t
nnoremap <C-w>q :tabclose!<CR>
nnoremap <C-w>e :TabooOpen
"nnoremap <C-w>e :tabnew!<CR>
if $TMUX == ''
    set clipboard+=unnamed
endif

autocmd BufNewFile,BufRead /tmp/mutt-* set filetype=mail
au FileType mail set tw=78 autoindent expandtab formatoptions=tcqn syntax=json
au FileType mail set list listchars=tab:»·,trail:·
au FileType mail set comments=nb:>
au FileType mail vmap D dO[...]^[]
au FileType mail nmap =j :%!python -m json.tool<CR>



"_______________________________________________________________________
" => syntastic-extras                                                   |
"_______________________________________________________________________|
let g:syntastic_python_checkers = ['pyflakes_with_warnings']
let g:syntastic_javascript_checkers = ['json_tool']
nnoremap ZZ :call syntastic_extras#quit_hook()<cr>
let g:syntastic_yaml_checkers = ['pyyaml']


"_______________________________________________________________________
" => syntastic                                                          |
"_______________________________________________________________________|
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.

silent !mkdir ~/.vim/backups > /dev/null 2>&1
"set backupdir=~/.vim/backup
set undodir=~/.vim/backups
set undofile

" "================= Swap Directory ==============
silent !mkdir ~/.vim/temp > /dev/null 2>&1
set directory=~/.vim/temp

" "================= Session sharing ==================
" shares cursor position and more between vim sessions
"set viewdir=~/.vim/vimview
"au BufWinLeave ?* mkview
"au VimEnter ?* loadview

"_______________________________________________________________________
" SimplyFold
"_______________________________________________________________________
let g:SimpylFold_docstring_preview=1

"_______________________________________________________________________
" Gundo
"_______________________________________________________________________
nnoremap <F5> :GundoToggle<CR>
let g:gundo_width = 60
let g:gundo_preview_height = 40
let g:gundo_right = 1
let g:mc = "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>"
"vnoremap <expr> cn g:mc . "``cgn"
"nnoremap cn *``cgn

if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
" g:loaded_youcompleteme = 1

" edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
"nnoremap <silent> <C-d> :lclose<CR>:bdelete!<CR>
cabbrev <silent> bd <C-r>=(getcmdtype()==#':' && getcmdpos()==1 ? 'lclose\|bdelete!' : 'bd')<CR>
"if !empty($NERDTREE_BOOKMARKS)
"    if filereadable($NERDTREE_BOOKMARKS)
"        let g:NERDTreeBookmarksFile = $NERDTREE_BOOKMARKS
"    endif
"endif
if filereadable(".NERDTreeBookmarks")
    let g:NERDTreeBookmarksFile = ".NERDTreeBookmarks"
endif
" quickhl
nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)

nmap <Space>j <Plug>(quickhl-cword-toggle)
nmap <Space>] <Plug>(quickhl-tag-toggle)
map H <Plug>(operator-quickhl-manual-this-motion)
"let g:ackprg = 'ag --vimgrep --smart-case'
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack
let g:ag_working_path_mode="r"
set runtimepath^=~/.vim/plugged/vim-howdoi
map <leader>ho <Plug>Howdoi

"let g:yankstack_map_keys = 1
let g:yankstack_yank_keys = ['y', 'd']
noremap <leader>p <Plug>yankstack_substitute_newer_paste
call yankstack#setup()
nmap Y y$
" other mappings involving y, d, c, etc

nmap =j :%!python -m json.tool<CR>
let g:session_autosave='yes'
let g:session_autosave_periodic=1
let g:session_default_name="Session"
let g:session_directory="~/"
let g:session_autosave_silent='yes'
