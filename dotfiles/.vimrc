"_______________________________________________________________________
"
" => Vundle 								                                            |
"_______________________________________________________________________|
"set rtp+=~/.vim/bundle/vundle/
"call vundle#begin()
call plug#begin('~/.vim/plugged')
Plug 'L9'
Plug 'honza/vim-snippets'
Plug 'junegunn/limelight.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'flazz/vim-colorschemes'
Plug 'junegunn/goyo.vim'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/neocomplete.vim'
Plug 'davidhalter/jedi-vim'
Plug 'Shougo/vimproc.vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'vim-scripts/nginx.vim'
Plug 'tpope/vim-surround'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'rbgrouleff/bclose.vim'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'joom/turkish-deasciifier.vim'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'elzr/vim-json'
Plug 'neilagabriel/vim-geeknote'
Plug 'vim-scripts/ZoomWin'
Plug 'Wolfy87/vim-expand'
Plug 'tmux-plugins/vim-tmux'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'vivien/vim-addon-linux-coding-style'
Plug 'airblade/vim-gitgutter'
Plug 'reedes/vim-pencil'
Plug 'amiorin/ctrlp-z'
Plug 'amiorin/vim-fasd'
Plug 'kien/ctrlp.vim'
Plug 'tomtom/tlib_vim'
Plug 'chrisbra/csv.vim'
Plug 'Z1MM32M4N/vim-superman'
Plug 't9md/vim-chef'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-eunuch'
Plug 'vim-ruby/vim-ruby'
Plug 'justinmk/vim-sneak'
Plug 'richsoni/vim-ecliptic'
Plug 'orlandov/vimfluence'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-obsession'
"Plug 'plasticboy/vim-markdown'
"Plug 'tpope/vim-markdown'
call plug#end()

"_______________________________________________________________________
" => genel ayarlar 							                                        |
"_______________________________________________________________________|
colorscheme SlateDark
set modifiable
set hidden
set background=light
filetype plugin on
"filetype plugin indent on
filetype indent on
set nocompatible              " be iMproved, required
filetype on
syntax on
syntax enable
set guitablabel=%t
set splitright
set autoread
set linebreak
"set hidden	
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
set noswapfile
set pastetoggle=<F2>
set nocindent  " Switch off all auto-indenting
set nosmartindent	
set indentexpr=
set clipboard=unnamed
set go+=a
set showmode
set ruler
set laststatus=0
set showcmd
set nofoldenable
"set dictionary+=k~/turkish_dic.add
"set complete+=k~/turkish_dic
set spellfile=~/.vim/plugged/ctrlp.vim/spell/en.utf-8.add
"set number!
"runtime! ftplugin/man.vim
"autocmd FileType man setlocal foldmethod=indent
:au FocusLost * silent! wa
" 
"autocmd TextChanged,TextChangedI <buffer> silent write
" Kaynak: http://stackoverflow.com/questions/6991638/how-to-auto-save-a-file-every-1-second-in-vim
"_______________________________________________________________________
" => Gorunum 								                                            |
"_______________________________________________________________________|
 highlight VertSplit cterm=none gui=none	
 highlight Search ctermfg=25 ctermbg=16
 highlight Folded ctermfg=25 ctermbg=16
 hi StatusLine cterm=none gui=none
 hi StatusLineNC cterm=none gui=none
 highlight clear SignColumn
 "autocmd BufEnter,BufRead,BufNewFile *.md syntax off
" autocmd BufNewFile,BufReadPost *.md set filetype=markdown

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
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

"_______________________________________________________________________
" => Kisayollar 							                                          |
"_______________________________________________________________________|
"noremap j h
"noremap k j
"noremap l k
"noremap ; l
map t i <ESC>r
noremap gr gT
:nnoremap f }) \| zt
":nnoremap f }) \| zz
":nnoremap s {( \| zz
:nnoremap s {( \| zt
" :map f }) 
" :map s {(
nnoremap <S-q> :qall!<CR>
nnoremap <Leader>o :r!cat<CR>
nnoremap <Leader>s :GitGutterToggle<CR>
"noremap <Leader>P "*p	
"window acik buffer'i sil/kapat
noremap <Leader>q :bdelete!<CR> 
"window acik buffer'i kaydet
nnoremap <S-w> :w<bar>:Bclose!<cr>  
"window acik buffer'i kaydetme
nnoremap <S-e> :Bclose!<cr>
"window kapat buffer'i kaydet
noremap <Leader>w :wq!<CR>
nnoremap <Leader>e :enew<cr>
vnoremap <Leader>p "*p
noremap <Leader>y "*y	
vnoremap <Leader>y "*y
cnoreabbrev Wq wq
cnoreabbrev Q! q!
cnoreabbrev W w
cnoreabbrev Q q
"nnoremap <C-n> :w<bar>:bNext<CR>
"nnoremap <C-p> :w<bar>:bprevious<CR>
nnoremap <C-n> :BuffergatorMruCycleNext<CR>
nnoremap <C-p> :BuffergatorMruCyclePrev<CR>
nnoremap / /\v
vnoremap / /\v
nnoremap <Leader>l :Limelight<CR>
nnoremap <Leader>k :Limelight!<CR>
nnoremap <Leader>h :nohl<CR>

"_______________________________________________________________________
" => emrah .vimrc 							                                        |
"_______________________________________________________________________|
 autocmd BufNewFile,BufRead *.txt,*.md,*.yaml,*.yml,*.sh,*.rst,*.markdown call CodingSet1()
 
 function CodingSet1()
         setlocal
         \ textwidth=79
         \ tabstop=8
         \ shiftwidth=4
         \ softtabstop=4
         \ expandtab
         \ autoindent
"         \ list
"         \ listchars=tab:··,trail:·
         \ filetype=txt
         \ syntax=conf
 endfunction
 
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
 nnoremap <silent> <leader>z :Goyo<cr>

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
 colorscheme SlateDark
 set background=light
 highlight clear SignColumn
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
set runtimepath+=~/.vim/plugged/neocomplete.vim/
"set fo+=aw
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
"let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_auto_select = 0
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
"let g:neocomplete#sources#dictionary#dictionaries = {
"     \ '_' : '~/.vim/plugged/ctrlp.vim/spell/en.utf-8.add'
"     \ }
"let g:neocomplete#sources#dictionary#dictionaries = {
"    \ '_' : '~/turkish.dic_calisma',
"    \ 'vimshell' : $HOME.'/.vimshell_hist',
"    \ 'scheme' : $HOME.'/.gosh_completions'
"    \ }
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
" => NERDTREE 								                                          |
"_______________________________________________________________________|
" Yapilandirma Kaynak: https://github.com/scrooloose/nerdtree
" Bos vim buffer'i acildiginda baslatma
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Leader key ile acma
" map <Leader>n :NERDTreeMapToggleHidden<CR>
map <Leader>n :NERDTreeToggle<CR>
"map <C-n> :NERDTreeToggle<CR>
" Sadece NERDTREE penceresi aciksa Vim'i otomatik kapat;
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"_______________________________________________________________________
" => Vim Indent Color 							                                    |
"_______________________________________________________________________|
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
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

set keywordprg=trans\ :tr

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
nnoremap <silent> <C-w>w :ZoomWin<CR>
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
nnoremap sz :CtrlPZ<Cr>
"nnoremap sf :CtrlPF<Cr>
"nnoremap <leader>z :CtrlPZ<Cr>
nnoremap <leader>p :CtrlPF<Cr>
" kaynak:
" https://github.com/amiorin/ctrlp-z

"_______________________________________________________________________
" => Python-mode							                                          |
"_______________________________________________________________________|
"
let g:pymode_rope = 0

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
 
let g:jedi#popup_on_dot = 0

"_______________________________________________________________________
" => ruby-vim 								                                          |
"_______________________________________________________________________|
 
imap <S-CR>    <CR><CR>end<Esc>-cc
set autoindent
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
