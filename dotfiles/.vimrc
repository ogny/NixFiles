set background=light
if has("unix")
command -nargs=? Swrite :w !sudo tee %
endif
syntax enable
map <leader>jt <Esc>:%!json_xs -f json -t json-pretty
filetype plugin on
filetype off
filetype plugin indent on
syntax on
execute pathogen#infect()
"filetype indent off
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
"Bundle 'gmarik/Vundle.vim'
"Bundle 'rbgrouleff/bclose.vim'
""Bundle 'kevinw/pyflakes-vim'
"Bundle 'Lokaltog/vim-easymotion'
"Bundle 'tpope/vim-fugitive'
""Bundle 'tpope/vim-rails.git'
""Bundle 'vim-scripts/pythoncomplete'
""Bundle 'klen/python-mode'
"Bundle 'L9'
"Bundle 'vim-scripts/YankRing.vim'
"Bundle 'vim-scripts/FuzzyFinder'
"Bundle 'christoomey/vim-tmux-navigator'
"Bundle 'elzr/vim-json'
""Bundle 'bilalq/lite-dfm'
""Bundle 'mikewest/vimroom'
""Bundle 'salsifis/vim-transpose'
""Bundle 'amix/vim-zenroom2'
""Bundle 'junegunn/goyo.vim'
"Bundle 'vim-scripts/nginx.vim'
"Bundle 'tpope/vim-surround'
map <space> <C-d>
map t i <ESC>r
map <leader>tn :tabnew <cr>
map <leader>tm :tabmove<cr>
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
"noremap j h
"noremap k j
"noremap l k
"noremap ; l
noremap gr gT
noremap s <C-b>
noremap f <C-f>
nnoremap <C-n> :bNext<CR>
nnoremap <C-p> :bprevious<CR>
"nnoremap <C-l> :ls<CR>
"nmap <Leader>bn :bw<CR>
nnoremap <S-q> :quit!<CR>
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
cnoreabbrev <expr> x getcmdtype() == ":" && getcmdline() == 'x' ? 'bd' : 'x'
:nmap <F2> :wa<Bar>exe "mksession! " . v:this_session<CR>:so ~/sessions/
set guitablabel=%t
set splitright
set autoread
set linebreak
set nocompatible
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
highlight VertSplit cterm=none gui=none	
hi StatusLine cterm=none gui=none
hi StatusLineNC cterm=none gui=none
let g:ConqueTerm_Color = 1
let bclose_multiple = 0
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
set clipboard=unnamed
set go+=a
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
"nnoremap <leader>z :LiteDFMToggle<cr>
"nnoremap <silent> <leader>z <Plug>VimroomToggle<cr>
nnoremap <silent> <leader>z :Goyo<cr>
" .vimrc
let g:auto_save = 1  " enable AutoSave on Vim startup
set tw=79
syntax on
"call plug#begin('~/.vim/plugged')
"
"Plug 'junegunn/seoul256.vim'
"Plug 'junegunn/vim-easy-align'
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
"" Plug 'user/repo1', 'branch_or_tag'
"" Plug 'user/repo2', { 'rtp': 'vim/plugin/dir', 'branch': 'devel' }
"" Plug 'git@github.com:junegunn/vim-github-dashboard.git'
"Plus desteği 'junegunn/goyo.vim'
" Buffers
"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'
" Buffers
nmap <Leader>ls :ls<CR>
"nmap <Leader>bp :bp<CR>
"nmap <Leader>bn :bn<CR>
nmap <Leader>bw :bw<CR>
"map <leader>f :FufFileWithCurrentBufferDir **/<C-M> 
"map <leader>b :FufBuffer<C-M>
"autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufEnter,BufRead,BufNewFile *.md syntax off
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
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
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
if has('vim_starting')
   set nocompatible               " Be iMproved

   " Required:
   set runtimepath+=~/.vim/bundle/neobundle.vim/
 endif

 " Required:
 call neobundle#begin(expand('~/.vim/bundle/'))

 " Let NeoBundle manage NeoBundle
 " Required:
 NeoBundleFetch 'Shougo/neobundle.vim'

 " My Bundles here:
 " Refer to |:NeoBundle-examples|.
 " Note: You don't set neobundle setting in .gvimrc!

 call neobundle#end()

 " Required:
 filetype plugin indent on

 " If there are uninstalled bundles found on startup,
 " this will conveniently prompt you to install them.
 NeoBundleCheck

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Unite
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:unite_enable_start_insert = 1
"let g:unite_split_rule = "botright"
"let g:unite_force_overwrite_statusline = 0
"let g:unite_winheight = 10
"
"call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
"      \ 'ignore_pattern', join([
"      \ '\.git/',
"      \ ], '\|'))
"
"call unite#filters#matcher_default#use(['matcher_fuzzy'])
"call unite#filters#sorter_default#use(['sorter_rank'])
"
"nnoremap <C-P> :<C-u>Unite  -buffer-name=files   -start-insert buffer file_rec/async:!<cr>
"
"autocmd FileType unite call s:unite_settings()
"
"function! s:unite_settings()
"  let b:SuperTabDisabled=1
""  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
""  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
"  imap <silent><buffer><expr> <C-x> unite#do_action('split')
"  imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
"  imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')
"
"  nmap <buffer> <ESC> <Plug>(unite_exit)
"endfunction
