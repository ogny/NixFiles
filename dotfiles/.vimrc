"_______________________________________________________________________________
" => Vundle 									|
"_______________________________________________________________________________|
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"Plugin 'Shougo/unite.vim'
Plugin 'Shougo/neocomplete.vim'
"Plugin 'Shougo/neomru.vim'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'vim-scripts/nginx.vim'
Plugin 'tpope/vim-surround'
Plugin 'L9'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'amix/vim-zenroom2'
Plugin 'junegunn/goyo.vim'
Plugin 'rbgrouleff/bclose.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jeetsukumaran/vim-buffergator'
call vundle#end()            " required
filetype plugin indent on
"_______________________________________________________________________________
" => genel ayarlar 								|
"_______________________________________________________________________________|
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
"_______________________________________________________________________________
" => Gorunum 									|
"_______________________________________________________________________________|
 highlight VertSplit cterm=none gui=none	
 hi StatusLine cterm=none gui=none
 hi StatusLineNC cterm=none gui=none
 autocmd BufEnter,BufRead,BufNewFile *.md syntax off

"_______________________________________________________________________________
" => Ozel karakterler 								|
"_______________________________________________________________________________|
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

"_______________________________________________________________________________
" => Kisayollar 								|
"_______________________________________________________________________________|
 map t i <ESC>r
 noremap gr gT
 noremap s <C-b>
 noremap f <C-f>
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

"_______________________________________________________________________________
" => emrah .vimrc 								|
"_______________________________________________________________________________|
 autocmd BufNewFile,BufRead *.txt,*.md call CodingSet1()
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
 
"_______________________________________________________________________________
" => neobundle 									|
"_______________________________________________________________________________|
"if has('vim_starting')
"  set nocompatible               " Be iMproved
"
"  " Required:
"  set runtimepath+=~/.vim/bundle/neobundle.vim/
"endif
"
"" Required:
"call neobundle#begin(expand('~/.vim/bundle/'))
"
"" Let NeoBundle manage NeoBundle
"" Required:
"NeoBundleFetch 'Shougo/neobundle.vim'
"
"" My Bundles here:
"" Refer to |:NeoBundle-examples|.
"" Note: You don't set neobundle setting in .gvimrc!
"NeoBundleFetch 'Shougo/vimproc.vim'
"NeoBundleFetch 'Shougo/unite.vim'
"NeoBundleFetch 'Shougo/neocomplete.vim'
"NeoBundleFetch 'Shougo/neomru.vim'
"NeoBundleFetch 'Shougo/neosnippet-snippets'
"NeoBundleFetch 'Lokaltog/vim-easymotion'
"NeoBundleFetch 'vim-scripts/nginx.vim'
"NeoBundleFetch 'tpope/vim-surround'
"NeoBundleFetch 'L9'
"NeoBundleFetch 'christoomey/vim-tmux-navigator'
"NeoBundleFetch 'nathanaelkane/vim-indent-guides'
"NeoBundleFetch 'amix/vim-zenroom2'
"NeoBundleFetch 'junegunn/goyo.vim'
"NeoBundleFetch 'rbgrouleff/bclose.vim'
" 
"call neobundle#end()
"
"" Required:
"filetype plugin indent on
"
"" If there are uninstalled bundles found on startup,
"" this will conveniently prompt you to install them.
"NeoBundleCheck

"_______________________________________________________________________________
" => vim-tmux-navigator 							|
"_______________________________________________________________________________|
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

"_______________________________________________________________________________
" => goyo.vim									|
"_______________________________________________________________________________|
 nnoremap <silent> <leader>z :Goyo<cr>

"_______________________________________________________________________________
" => neocomplete								|
"_______________________________________________________________________________|
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
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

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
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

"_______________________________________________________________________________
" => NERDTREE 									|
"_______________________________________________________________________________|
" Yapilandirma Kaynak: https://github.com/scrooloose/nerdtree
" Bos vim buffer'i acildiginda baslatma
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Leader key ile acma
map <Leader>n :NERDTreeToggle<CR>
" Sadece NERDTREE penceresi aciksa Vim'i otomatik kapat;
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
