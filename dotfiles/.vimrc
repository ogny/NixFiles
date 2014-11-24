"_______________________________________________________________________
" => Vundle 								|
"_______________________________________________________________________|
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"Plugin 'Shougo/unite.vim'
"Plugin 'Shougo/neomru.vim'
"Plugin 'amix/vim-zenrsyntastic'
Plugin 'fatih/vim-nginx'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'vim-scripts/nginx.vim'
Plugin 'tpope/vim-surround'
Plugin 'L9'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'junegunn/goyo.vim'
Plugin 'rbgrouleff/bclose.vim'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'joom/turkish-deasciifier.vim'
Plugin 'junegunn/limelight.vim'
Plugin 'Shougo/neocomplete.vim'
call vundle#end()            " required
filetype plugin indent on

"_______________________________________________________________________
" => genel ayarlar 							|
"_______________________________________________________________________|
colorscheme default 
filetype off
syntax on
syntax enable
set background=light
set guitablabel=%t
set splitright
set autoread
set linebreak
set hidden	
set backspace=eol,start	 " allow backspacing over everything in insert mode
set ignorecase     " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set history=1000         " remember more commands and search history	
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
set nobackup
set noswapfile
set pastetoggle=<F2>
set nocindent  " Switch off all auto-indenting
set nosmartindent	
set noautoindent
set indentexpr=
set clipboard=unnamed
set go+=a

"_______________________________________________________________________
" => Gorunum 								|
"_______________________________________________________________________|
 highlight VertSplit cterm=none gui=none	
 hi StatusLine cterm=none gui=none
 hi StatusLineNC cterm=none gui=none
 autocmd BufEnter,BufRead,BufNewFile *.md syntax off

"_______________________________________________________________________
" => Ozel karakterler 							|
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
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

"_______________________________________________________________________
" => Kisayollar 							|
"_______________________________________________________________________|
"noremap j h
"noremap k j
"noremap l k
"noremap ; l
map t i <ESC>r
noremap gr gT
:nnoremap f }) \| zz
:nnoremap s {( \| zz
" :map f }) 
" :map s {(
nnoremap <S-q> :quit!<CR>
noremap <Leader>p "*p	
vnoremap <Leader>p "*p
noremap <Leader>y "*y	
vnoremap <Leader>y "*y
nnoremap <S-w> :w<bar>:Bclose!<cr>
nnoremap <Leader>e :enew<cr>
cnoreabbrev Wq wq
cnoreabbrev Q! q!
cnoreabbrev W w
cnoreabbrev Q q
nnoremap <C-n> :bNext<CR>
nnoremap <C-p> :bprevious<CR>
nnoremap / /\v
vnoremap / /\v
nmap <F5> :source ~/.vimrc<CR>
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

"_______________________________________________________________________
" => emrah .vimrc 							|
"_______________________________________________________________________|
 autocmd BufNewFile,BufRead *.txt,*.md,*.yaml,*.yml,*.rst call CodingSet1()
 autocmd BufNewFile,BufRead *.sql call CodingSet2()
 
 function CodingSet1()
         setlocal
         \ textwidth=79
         \ tabstop=8
         \ shiftwidth=4
         \ softtabstop=4
         \ expandtab
         \ autoindent
         \ list
         \ listchars=tab:··,trail:·
         \ filetype=txt
         \ syntax=conf
 endfunction
 
 function CodingSet2()
         setlocal
         \ textwidth=79
         \ tabstop=8
         \ shiftwidth=4
         \ softtabstop=4
         \ expandtab
         \ autoindent
         \ list
         \ listchars=tab:»·,trail:·
 endfunction
 
"_______________________________________________________________________
" => vim-tmux-navigator 						|
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
 
   nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'L')<cr>
   nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'D')<cr>
   nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'U')<cr>
   nnoremap <silent> <C-;> :call TmuxOrSplitSwitch(';', 'R')<cr>
 else
   map <C-j> <C-w>h
   map <C-k> <C-w>j
   map <C-l> <C-w>k
   map <C-;> <C-w>l
 endif

"_______________________________________________________________________
" => goyo.vim								|
"_______________________________________________________________________|
 nnoremap <silent> <leader>z :Goyo<cr>

"_______________________________________________________________________
" => neocomplete							|
"_______________________________________________________________________|
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }
" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

"_______________________________________________________________________
" => NERDTREE 								|
"_______________________________________________________________________|
" Yapilandirma Kaynak: https://github.com/scrooloose/nerdtree
" Bos vim buffer'i acildiginda baslatma
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Leader key ile acma
" map <Leader>n :NERDTreeMapToggleHidden<CR>
map <Leader>n :NERDTreeToggle<CR>
" Sadece NERDTREE penceresi aciksa Vim'i otomatik kapat;
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"_______________________________________________________________________
" => Vim Indent Color 							|
"_______________________________________________________________________|
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

"_______________________________________________________________________
" => Limelight!								|
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
" Goyo Integration
function! GoyoBefore()
  Limelight
endfunction
function! GoyoAfter()
  Limelight!
endfunction
let g:goyo_callbacks = [function('GoyoBefore'), function('GoyoAfter')]

"_______________________________________________________________________
" => turkish-deasciifier.						|
"_______________________________________________________________________|
vmap <Leader>tr :<c-u>call Turkish_Deasciify()<CR>
vmap <Leader>rt :<c-u>call Turkish_Asciify()<CR>
let g:turkish_deasciifier_path = '~/Git_Repolari/diger/turkish-deasciifier/turkish-deasciify'

"_______________________________________________________________________
" => translate-shell							|
"_______________________________________________________________________|

set keywordprg=trans\ :tr
