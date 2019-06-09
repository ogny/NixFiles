"colorscheme base16-onedark
"
" colorscheme ~/.vim/plugged/base16-vim/colors/base16-onedark.vim
"if filereadable(expand("~/.vimrc_background"))
"  let base16colorspace=256
"  source ~/.vimrc_background
"endif
""""" Plugins
call plug#begin('~/.vim/plugged')
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'skielbasa/vim-material-monokai'
Plug 'jdkanani/vim-material-theme'
Plug 'google/vim-jsonnet'
Plug 'tpope/vim-markdown'
Plug 'elzr/vim-json'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'flazz/vim-colorschemes'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'scrooloose/nerdtree'
Plug 'chriskempson/base16-vim'
Plug 'jonhiggs/MacDict.vim'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-apathy'
Plug 'chase/vim-ansible-yaml'
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-zoom'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'gcmt/taboo.vim'
Plug 'itkq/fluentd-vim'
Plug 'davidhalter/jedi'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'xolox/vim-misc'
Plug 'tpope/vim-fugitive'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-surround'
Plug 'rbgrouleff/bclose.vim'
Plug 'tmux-plugins/vim-tmux'
Plug 'vim-scripts/indentpython.vim'
Plug 'nvie/vim-flake8'
Plug 'myint/syntastic-extras'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
Plug 'Raimondi/delimitMate'
Plug 'joom/turkish-deasciifier.vim'
Plug 'blueyed/vim-diminactive'
Plug 'ekalinin/Dockerfile.vim'
Plug 'Asheq/close-buffers.vim'
Plug 'tpope/vim-unimpaired'
"Plug 'python-mode/python-mode'
"Plug 'airblade/vim-gitgutter'
"Plug 'vim-syntastic/syntastic'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-scripts/ZoomWin'
"Plug 'plasticboy/vim-markdown'
" Plug 'Lokaltog/vim-easymotion'
" Plug 'klen/python-mode'
" Plug 'kshenoy/vim-signature'
"Plug 'vim-airline/vim-airline-themes'
"Plug 'ConradIrwin/vim-bracketed-paste'
"Plug 'airblade/vim-rooter'
"Plug 'xolox/vim-session'
" Plug 'Valloric/YouCompleteMe'
" Plug 'drzel/vim-in-proportion'
" Plug 'francoiscabrol/ranger.vim' ## guzel fakat nerdtree varken gerek yok :)
" Plug 'idanarye/vim-vebugger'
" Plug 'maxbrunsfeld/vim-yankstack'
" Plug 'vim-scripts/YankRing.vim'
" Plug 'jiangmiao/auto-pairs'
" Plug 'davidhalter/jedi-vim'
" Plug 'w0rp/ale'
" Plug 'google/yapf'
" Plug 'ehamberg/vim-cute-python'
" Plug 'Yggdroot/indentLine'
call plug#end()

"" Colorscheme
"set background=light
"set termguicolors
"colorscheme material-monokai
set background=light
colorscheme DevC++
"colorscheme quantum
"colorscheme 0x7A69_dark
"colorscheme material-theme
"colorscheme darkburn
" let base16colorspace=256
"hi EndOfBuffer ctermfg=black ctermbg=black
"hi pythonSelf  ctermfg=68  guifg=#5f87d7 cterm=bold gui=bold
hi ColorColumn term=reverse ctermfg=0 ctermbg=0 ctermfg=none
hi ColorColumn ctermfg=none ctermbg=none
hi VertSplit cterm=none gui=none "DevC++'in icine yazdim
hi VertSplit ctermfg=00
hi LineNr ctermfg=none ctermbg=none  " background'da farkli renk olmasin
hi SignColumn ctermbg=none
hi TabLineFill cterm=none gui=none
hi TabLine ctermfg=none ctermbg=none
hi TabLineSel ctermfg=none ctermbg=none
hi StatusLineNC ctermfg=none ctermbg=none gui=none
"hi clear SignColumn
"hi Normal ctermfg=none ctermbg=none  " background'da farkli renk olmasin
"hi nonText ctermbg=none 
"hi Search ctermfg=25 ctermbg=16
"hi Folded ctermfg=25 ctermbg=16
"hi StatusLine ctermfg=none ctermbg=none gui=none
"hi StatusLineNC ctermfg=none ctermbg=none gui=none
"hi link markdownError Normal
"hi StatusLine ctermfg=none ctermbg=none gui=none

" yaml indentation
au FileType yml setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2
au FileType yaml setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2
autocmd FileType yaml setl indentkeys-=<:>
set fillchars+=vert:│
set mmp=5000
"set winfixwidth
set equalalways
set expandtab "indentation contains tabs"

""" General Configuration
" autocmd VimResized * wincmd =
set splitbelow
set t_Co=256
" disable the Background Color Erase that messes with some color schemes
set t_ut=
set is
set ic
set magic
set nojoinspaces
set encoding=utf-8
set textwidth=78
set modifiable
set hidden " vim will hide the buffer until you come back to it.
autocmd BufNewFile,BufRead fugitive://* set bufhidden=delete
set guifont=Monaco\ 12
set lazyredraw          " redraw only when we need to."
set showmatch           " highlight matching [{()}]}]"
set equalalways
filetype plugin on
filetype indent on
set nocompatible              	" be iMproved, required
filetype on
"filetype off 			" w0rp/ale
syntax enable
set term=ansi
"set term=xterm-256color
set splitright
set autoread
set foldmethod=indent
set foldlevel=99
set backspace=eol,start	 " allow backspacing over everything in insert mode
set nofixendofline
set ignorecase     " ignore case when searching
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class,*.pyc,*.zip,*.gz,*.bz,*.tar,*.jpg,*.png,*.gif,*.avi,*.wmv,*.ogg,*.mp3,*.mov
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
set nobackup
set noswapfile
set go+=a
set showmode
set ruler
set laststatus=0
set showcmd
set nofoldenable
set guioptions-=e
set sessionoptions+=tabpages,globals
set guitablabel=%t
set completeopt=menu " preview metodu iptal
set clipboard=unnamed
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise
set linebreak
set tabstop=4
set softtabstop=4
set nocindent  " Switch off all auto-indenting
set breakindent
set nosmartindent
set noautoindent
set shiftround
set indentexpr=

set clipboard+=unnamed
set shiftwidth=4
set wildmenu            " visual autocomplete for command menu"
filetype plugin indent on
syntax on
" Vim'de dosyalar alt satira gectiginde bos tab alanlari olusuyor, bunu
" engelleyebilmek icin asagidakileri comment'ledim
"set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop

if $TMUX == ''
    set clipboard+=unnamed
endif

""" Keybinds
cmap w!! w !sudo tee > /dev/null %
nnoremap <leader>da "=strftime("%d-%m-%Y %H:%M")<CR>P
nnoremap <C-w>q :tabclose!<CR>
nnoremap <C-w>e :TabooOpen
nnoremap <leader>re :set relativenumber!<CR>
nnoremap <Leader>on :only<CR>
nnoremap <Leader>en :enew<CR>
map t i <ESC>r
nmap ; o<Esc>
nmap <CR> o<Esc>
noremap gr gT
"nnoremap <C-a> }) \| zt
"nnoremap <C-s> {( \| zt
nnoremap <C-a> }) \| zz
" nnoremap <C-s> {( \| zz
nnoremap <Leader>w :w<bar>:Bclose!<cr>
nnoremap <C-s> :sign unplace *<CR>
nnoremap <Leader>q :Bclose!<cr>
noremap <Leader>s :wall!<CR>
noremap <S-w> :wqall!<CR>
noremap <S-q> :bdelete!<cr>
noremap <S-e> :qall!<cr>
ca <C-w>q :tabclose!<CR>
ca <C-w>e :tabnew!<CR>
vnoremap <Leader>p "*p
command! WQ wq!
command! Wq wq!
command! W w!
command! Q q!
" cnoreabbrev W w
" cnoreabbrev Wq wq
" cnoreabbrev Q! q!
" cnoreabbrev Q q
nnoremap / /\v
vnoremap / /\v
nnoremap <Leader>l :Limelight<CR>
nnoremap <Leader>k :Limelight!<CR>
nnoremap <Leader>h :nohl<CR>
nnoremap <silent> <Leader>z :ZoomWin<CR>
nnoremap gV `[v`]`
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

""" Keys for plugins
nnoremap <S-f> :set foldenable<CR>
nnoremap <Leader>u :GitGutterToggle<CR>
noremap <C-e> :FZF ~<CR>
nnoremap <C-n> :BuffergatorMruCycleNext<cr>
nnoremap <C-p> :BuffergatorMruCyclePrev<cr>
nnoremap <silent> <leader>x :Goyo<cr>
map <Leader>n :NERDTreeToggle<CR>
nnoremap <silent> <leader>c :CloseBuffers<CR>

"" Plugin Configurations
" vim-tmux-navigator
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

" goyo.vim
 function! GoyoBefore()
   if exists('$TMUX')
     silent !tmux set status off
   endif
   Limelight
 endfunction
 "
 function! GoyoAfter()
   if exists('$TMUX')
     silent !tmux set status off
   endif
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
 
 "" NERDTREE
 " Bos vim buffer'i acildiginda baslatma
 "autocmd StdinReadPre * let s:std_in=1
 "autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
 " Sadece NERDTREE penceresi aciksa Vim'i otomatik kapat;
 autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
 let g:NERDTreeMapJumpNextSibling = ''
 let g:NERDTreeMapJumpPrevSibling = ''
 let g:NERDTreeMapJumpLastChild = ''
 let g:NERDTreeMapJumpFirstChild = ''
 let g:NERDTreeWinSize=31
 let g:NERDTreeDirArrows=0
 let g:NERDTreeChDirMode=2
 if filereadable(".NERDTreeBookmarks")
     let g:NERDTreeBookmarksFile = ".NERDTreeBookmarks"
 endif
 
 "" Limelight
"let g:limelight_conceal_ctermfg = 'black'
let g:limelight_conceal_ctermfg=0
"let g:limelight_conceal_guifg = 'black'
 let g:limelight_conceal_guifg = '#111111'
"let g:limelight_conceal_guifg = '#263137'
 let g:limelight_default_coefficient = 0.7
 
 "" FZF                                                                |
 let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
 " let $FZF_DEFAULT_OPTS='--height 40% --reverse'
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
 
 "" gitgutter
 let g:gitgutter_enabled = 1
 
 "" Mutt integration
 autocmd BufNewFile,BufRead /tmp/mutt-* set filetype=mail
 au FileType mail set tw=64 autoindent expandtab formatoptions=tcqn
 au FileType mail set list listchars=tab:»·,trail:·
 au FileType mail set comments=nb:>
 au FileType mail vmap D dO[...]^[]
 nmap =j :%!python -m json.tool<CR>
 
 "" syntastic-extras
 "let g:syntastic_python_checkers = ['pyflakes_with_warnings']
 "let g:syntastic_javascript_checkers = ['json_tool']
 "nnoremap ZZ :call syntastic_extras#quit_hook()<cr>
 "let g:syntastic_yaml_checkers = ['pyyaml']
 
 "" syntastic
 " let g:syntastic_mode_map = { 'mode': 'passive' }
 " autocmd VimEnter * SyntasticToggleMode " disable syntastic by default"
 " set statusline+=%#warningmsg#
 " set statusline+=%{SyntasticStatuslineFlag()}
 " set statusline+=%*
 let g:syntastic_always_populate_loc_list = 1
 let g:syntastic_auto_loc_list = 1
 let g:syntastic_check_on_open = 1
 let g:syntastic_check_on_wq = 0
 let g:syntastic_python_checkers = ['pyflakes_with_warnings']
 let g:syntastic_javascript_checkers = ['json_tool']
 let g:syntastic_json_checkers = ['json_tool']
 "let g:syntastic_yaml_checkers = ['pyyaml']
 "let g:syntastic_quiet_messages = { "type": "style" }
 nnoremap ZZ :call syntastic_extras#quit_hook()<cr>
 
 "" Ack.vim
 if executable('ag')
     let g:ackprg = 'ag --vimgrep'
 endif
 set grepprg=ag\ --nogroup\ --column
 set grepformat=%f:%l:%c:%m
 "set grepprg=ack
 cnoreabbrev ag Ack
 cnoreabbrev aG Ack
 cnoreabbrev Ag Ack
 cnoreabbrev AG Ack
 
 " Automatically change the current directory
 "autocmd BufEnter * silent! lcd %:p:h
 
 "" vim-sessions
 let g:ag_working_path_mode="r"
 let g:session_autosave='yes'
 let g:session_autosave_periodic=1
 let g:session_default_name="Session"
 let g:session_directory="~/"
 let g:session_autoload = 'yes'
 
 """ Other Configurations 
 "" Persistent Undo 
 silent !mkdir ~/.vim/backups > /dev/null 2>&1
 "set backupdir=~/.vim/backup
 set undodir=~/.vim/backups
 set undofile
 "" Swap Directory 
 "silent !mkdir ~/.vim/temp > /dev/null 2>&1
 "set directory=~/.vim/temp
 
 " edit vimrc/zshrc and load vimrc bindings
 augroup reload_vimrc " {
     autocmd!
     autocmd BufWritePost /Users/orkungunay/.vimrc source /Users/orkungunay/.vimrc
 augroup END " }
 
 " Auto save files when focus is lost
 au FocusLost * silent! wa
 
 " w0rp/ale
 "let &runtimepath.=',~/.vim/plugged/ale'
 
 " google/yapf
 "autocmd FileType python nnoremap <LocalLeader>a :0,$!yapf<CR>
 
 " force pair
 let g:AutoPairsFlyMode = 1
 
 " alfabetik sort
 autocmd FileType python nnoremap <LocalLeader>i :!isort %<CR><CR>
 
 " ycm; ilk hangi python varsa, onu kullan
 let g:ycm_python_binary_path = 'python'
 
 " pymode
 " Override go-to.definition key shortcut to Ctrl-]
 "let g:pymode_rope_goto_definition_bind = "<C-]>"
 let g:pymode = 1
 let g:pymode_rope = 0
 let g:pymode_warnings = 1
 
 "let g:pymode_rope_show_doc_bind = '<C-c>d'
 
 " Quick run via <F5>
 "nnoremap <F5> :call <SID>compile_and_run()<CR>
 
 " yggdroot
 "let g:indentLine_setColors = 0
 "let g:indentLine_char = '│'
 
 
 let g:jedi#goto_command = "<leader>d"
 let g:jedi#goto_assignments_command = "<leader>g"
 let g:jedi#goto_definitions_command = ""
 let g:jedi#documentation_command = "K"
 let g:jedi#usages_command = "<leader>n"
 let g:jedi#completions_command = "<C-Space>"
 let g:jedi#rename_command = "<leader>r"
 
 " turkish-deasciifier.
 vmap <Leader>tr :<c-u>call Turkish_Deasciify()<CR>
 vmap <Leader>rt :<c-u>call Turkish_Asciify()<CR>
 let g:turkish_deasciifier_path = '~/orkun/repos/diger/turkish-deasciifier/turkish-deasciify'
 
 
 " emrah'tan alinti
 " autocmd BufNewFile,BufRead *.py,*.tmpl,*.yml,*.yaml call CodingSet0()
 " function! CodingSet0()
 "         setlocal
 "         \ textwidth=79
 "         \ tabstop=4
 "         \ shiftwidth=4
 "         \ softtabstop=4
 "         \ expandtab
 "         \ autoindent
 "         \ list
 "         \ listchars=tab:»·,trail:·
 " endfunction
 
 
 "  hi ColorColumn ctermbg=none 
 "" hi SignColumn ctermbg=none
 "  hi VertSplit ctermbg=none cterm=none gui=none "DevC++'in icine yazdim
 "" hi LineNr ctermfg=none ctermbg=none  " background'da farkli renk olmasin
 ""  hi Normal ctermfg=none ctermbg=none  " background'da farkli renk olmasin
 "" hi nonText ctermbg=none 
 """  hi SignColumn ctermbg=none
 "  hi Search ctermfg=25 ctermbg=16
 "" hi Folded ctermfg=25 ctermbg=16
 "  hi NonText ctermfg=237
 """  hi clear SignColumn
 "  hi link markdownError Normal
 "  hi TabLineFill cterm=none gui=none
 "  hi TabLine ctermfg=none ctermbg=none
 "  hi TabLineSel ctermfg=none ctermbg=none
 " Copy selected text to system clipboard (requires gvim installed):
 "map <C-v> "+P
 vnoremap <C-c> "*Y :let @+=@*<CR>
 "map <C-p> "+P
 "set mouse=a
 "let g:NERDTreeMouseMode=3
 let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
 "let g:airline#parts#ffenc#skip_expected_string='NORMAL|NSERT'
 let g:airline_section_a = ''
 "let g:airline_section_b = ''
 let g:airline_section_c = ''
 
 let g:airline_skip_empty_sections = 1
 "set statusline+=%F
 autocmd QuickFixCmdPost *grep* cwindow
 "au FilterWritePre * !silent if &diff | colorscheme zenburn | endiF
 let g:vimwiki_global_ext=0
 autocmd BufNewFile,BufReadPost *.md set filetype=markdown
 autocmd FileType vimwiki set syntax=markdown
 let g:vimwiki_list = [{'path': '~/orkun/iven/',
                        \ 'syntax': 'markdown', 'ext': '.md'}]
 "map <Leader>l "dyiw:call MacDict(@d)<CR>
 "nnoremap <Leader>l :Limelight<CR>
 
 autocmd InsertEnter * set cursorline cursorcolumn
 autocmd InsertLeave * set nocursorline nocursorcolumn
 highlight cursorline cterm=none ctermfg=7 ctermbg=4
 highlight cursorcolumn cterm=none ctermfg=7 ctermbg=4
 autocmd filetype crontab setlocal nobackup nowritebackup
