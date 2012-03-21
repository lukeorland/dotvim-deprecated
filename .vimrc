" Modeline and Notes {
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker nospell:
"
" This is the personal .vimrc file of Luke Orland
" some influence from the .vimrc file from Steve Francia.
"
" TODO:
" * do not expandtab for java,c-like code.
" * get <c-n> autocompletion working again.
" * quick way to comment out and (uncomment out) python code with #
" * how to automatically add colon at end of python def and class line
" * make <C-t> open a new tab (not command-T or taglist)
" * Try out vim2evernote plugin:
"   http://www.rensecorten.dds.nl/files/Vim2Evernote.vim
"
" FIXME:
" * FIXED? Something is broken with Fugitive.
" * The 80th column is not being highlighted.
" * FIXED? . doesn't seem to be a word boundary now? w won't take me to method
"   beginning.
" * FIXED: an f key-mapping broke f to find the next matching char in the
"   current line.
" * FIXED? required to hit ENTER after opening new files.
" * omnicompletion doesn't work. (pattern not found)
" * FIXED? newly-opened python file doesn't have syntax highlighting until
"   after :e command.
" * FIXED? sometimes required to do :w! to save.
" * DISABLED: get Pydiction to work. see
"   http://www.vim.org/scripts/script.php?script_id=850
" }

" Environment {

  " Basics {

    set nocompatible        " We're running Vim, not Vi! Must be the first line.
    scriptencoding utf-8

    " set autowrite                  " automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxoOtT       " abbrev. of messages (avoids 'hit enter')
    "set virtualedit=onemore        " allow for cursor beyond last character
    set history=1000          " Store a ton of history (default is 20)
  " }

  " Windows Compatible {

    set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility

    " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
    " across (heterogeneous) systems easier. 
    if has('win32') || has('win64')
      set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
      "set term=$TERM       " Make arrow and other keys work
      "set iskeyword="@,48-57,_,128-167,224-235"
    else
      "set iskeyword="@,48-57,_,192-255"
      "set grepprg=ack-grep          " replace the default grep program with ack
    endif
  " }

  " Reading/Writing {

    set noautowrite             " Never write a file unless I request it.
    set noautowriteall          " NEVER.
    set noautoread              " Don't automatically re-read changed files.
    set modeline                " Allow vim options to be embedded in files;
    set modelines=5             " they must be within the first or last 5 lines.
    set ffs=unix,dos,mac        " Try recognizing dos, unix, and mac line endings.
    set confirm                 " Y-N-C prompt if closing with unsaved changes.

    " Folding {
      set foldtext=getline(v:foldstart)
    " }
  " }

  " Temp directories {

    set backup
    set backupdir=~/.vim/backup " where to put backup file
    set directory=~/.vim/temp   " directory is the directory for temp file
  " }

  " Buffers {

    au BufWinLeave * silent! mkview  "make vim save view (state) (folds, cursor, etc)
    au BufWinEnter * silent! loadview "make vim load view (state) (folds, cursor, etc)
  " }

  syntax on
  filetype off

  " Vundle Support {

    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()

    " let Vundle manage Vundle
    " required! 
    Bundle 'gmarik/vundle'

    " My Bundles here:

    " Vundle - colorschemes {

      " I experienced this problem:
      " 'Cannot find color scheme solarized'
      " The way to solve the problem is to create a hardlink (for Windows)
      " that links the location of solarized.vim in the bundle directory to
      " the location .vim\colors\solarized.vim
      Bundle 'altercation/vim-colors-solarized'

      Bundle 'desert.vim'
      Bundle 'pyte'
    " }

    " Vundle - autocompletion {

      Bundle 'increment.vim--Natter'
      "Bundle 'closetag.vim'
      Bundle 'ervandew/supertab'
      " SnipMate
        Bundle 'msanders/snipmate.vim'
        Bundle 'scrooloose/snipmate-snippets'
      Bundle 'Raimondi/delimitMate'
      Bundle 'matchit.zip'
      "Bundle 'html_autoclosetag.vim'
      Bundle 'tpope/vim-surround'
    " }

    " Vundle - Directory navigation, buffers, terminal, undo, tests {

      Bundle 'scrooloose/nerdtree'
      "Bundle 'FuzzyFinder'
      "Bundle 'git://git.wincent.com/command-t.git'
      Bundle 'bufexplorer.zip'
      "Bundle 'vim-bclose'
      Bundle 'BufClose.vim'
      "Bundle 'minibufexpl.vim'
      Bundle 'rson/vim-conque'
      "Bundle 'EvalSelection.vim'
      Bundle 'sjl/gundo.vim'
    " }

    " Vundle - project, source code management {

      "Bundle 'taglist.vim'
      Bundle 'TaskList.vim'
      Bundle 'tpope/vim-fugitive'
      "Bundle 'tpope/vim-git'

      " Generic test runner that works with nose
      " FIXME: I can't get this to work with nose/python -m unittest
      "Bundle 'reinh/vim-makegreen'
    " }

    " Vundle - Python {

      " Underlines and displays errors with Python on-the-fly
      " For pyflakes, make sure to go into .vim/bundle/pyflakes-vim/
      " and run the commands
      "     git submodule init
      "     git submodule update
      " to download the pyflakes python source.
        Bundle 'kevinw/pyflakes-vim'
        "Bundle 'mitechie/pyflakes-pathogen'

      " The following is enhanced syntax highlighting for python. seems buggy
      " to me.
      " Install it, then checkout the python3 branch to get highlighting for 
      " python3.0
      Bundle 'vim-scripts/python.vim--Vasiliev'

      Bundle 'vim-scripts/indentpython.vim'

      " a python IDE completion helper.
      "Bundle 'orestis/pysmell.vim'

      " This plugins maps f, and I don't like it. I couldn't get the following
      " command to fix the problem, either.
      "unmap <buffer> f
      "Bundle 'Efficient-python-folding'

      " A set of menus/shortcuts to work with Python files
      " PROBLEM: this plugin maps [c which is useful in vimdiff mode.
      " TODO: figure out how to have that only happen in python buffers.
      "Bundle 'python.vim'

      Bundle 'nvie/vim-pep8'
      " The following version wouldn't work for me. (problems re-mapping the
      " function key.
      "Bundle 'pep8'

      " Pytest - Runs your Python tests in Vim.
      "Bundle 'alfredodeza/pytest.vim'
 
      "Bundle 'run_python_tests'
      "Bundle 'olethanh/Vim-nosecompiler'
      " I modified the above to use python -m unittest instead of nosetests
      " because I was getting weird output from nosetests.
      " The former works better and simpler (in some ways)
      Bundle 'lukeorland/Vim-nosecompiler'

      " I can't get pydiction to do what it says it does. Maybe the problem is
      " due to setting the wrong pydiction_location below (in Windows).
      " see: http://www.rootninja.com/tab-completion-for-python-in-vim/
      " see: http://www.mohdshakir.net/2007/12/27/enable-vim-code-python-auto-complete
      " see: http://stackoverflow.com/questions/1687252/with-vim-use-both-snipmate-and-pydiction-together-share-the-tab-key
      "Bundle 'Pydiction'

      " To get pydoc working in Windows see the answer by Dave Webb at
      " http://stackoverflow.com/questions/3391998/pydoc-is-not-working-windows-xp
      Bundle 'fs111/pydoc.vim'

      "Bundle 'python_match.vim'
      "Bundle 'python_showpydoc.vim'
      "Bundle 'pythoncomplete'

      " This doesn't work in my Windows 7 environment.
      "Bundle 'sontek/rope-vim'

      " Instead, trying the simpler bundle + the system-install version of the
      " Python rope libraries.
      " Actually, there isn't support for python 3, so nevermind.
      "Bundle 'gordyt/rope-vim'

      Bundle 'AutoComplPop'
    " }

    " Vundle - Other filetype-specific plugins {

      Bundle 'vim-pandoc/vim-pandoc'
      "Bundle 'Arduino-syntax-file'
      "Bundle 'lukeorland/yaml-vim.git'
      "Bundle 'vim-ruby/vim-ruby.git'
      "Bundle 'groovy.vim'
      "Bundle 'lukeorland/groovyindent.git'
      "Bundle 'matlab.vim'
      Bundle 'tpope/vim-markdown.git'
      "Bundle 'rails.vim'
    " }

    " Vundle - vim settings management {

      " ViewOutput : scroll back and search [long] output of vim command
      " If you want to scroll backward (and forward) and search within long
      " output of the vim command (such as :au, :let), execute command with
      " prefix VO. 
      "
      " VO (viewoutput) will place output of vim command in new buffer where you
      " can search and view it using vim commands. Example: 
      "
      "       :VO au 
      "       :VO let
      " 
      Bundle 'ViewOutput'
    " }

    " Vundle - TODO: check out these plugins some day. {

      " PIV (PHP Integration for VIM)](http://github.com/spf13/PIV)
      " NerdCommenter (http://github.com/scrooloose/nerdcommenter)
      " CheckSyntax (http://www.vim.org/scripts/script.php?script_id=1431)
      " Surrounding (http://github.com/msanders/vim-files/blob/master/plugin/surrounding.vim)
      " AutoCloseTag (http://www.vim.org/scripts/script.php?script_id=2591)
      " GunDo - Visual Undo in vim with diff's to check the differences
      "
      "Bundle 'Shougo/neocomplcache'
      "Bundle 'Lokaltog/vim-easymotion'
      "Bundle 'mattn/zencoding-vim.git'
      "Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
      "Bundle 'mileszs/ack.vim'
    " }

    " Vundle brief help {
    "
    " :BundleInstall  - install bundles (won't update installed)
    " :BundleInstall! - update if installed
    "
    " :Bundles foo    - search for foo
    " :Bundles! foo   - refresh cached list and search for foo
    "
    " :BundleClean    - confirm removal of unused bundles
    " :BundleClean!   - remove without confirmation
    "
    " see :h vundle for more details
    " or wiki for FAQ
    " Note: comments after Bundle command are not allowed
    "
    " Example for vim-scripts repos 
    "   Bundle 'bufexplorer.zip'
    " Example for original repos on github
    "   Bundle 'ervandew/supertab'
    " Example for non-github repos
    "   Bundle 'git://git.wincent.com/command-t.git'
    " }
  " }


  filetype plugin indent on    " Enable filetype-specific indenting and plugins
                               "It is essential that the above lines are
                               "called before enabling filetype detection
  cd ~
" }

" Vim UI - Sound / Display / View / Visual aspects {

  " don't bell or blink
  set noerrorbells
  set visualbell t_vb=

  set winminheight=0        " windows can be 0 line high

  "set cursorline          " highlight current line
  "hi cursorline guibg=#333333   " highlight bg color of current line
  "hi CursorColumn guibg=#333333   " highlight cursor

  set showmatch        "show matching surround
  set linespace=5      " Extra space between rows

  set numberwidth=1    " using only 1 column (and 1 space) while possible

  " GVim GUI Settings (here instead of .gvimrc) {
    if has('gui_running')
      " disable beeping (aka "bell") and window flashing
      autocmd GUIEnter * set visualbell t_vb=

      set background=light
      set t_Co=256

      " Set the configurations before setting the colorscheme.
      let g:solarized_visibility="low"
      let g:solarized_contrast  ="high"
      let g:solarized_termcolors=256
      colorscheme solarized

      if has('win32') || has('win64')
        " GVim in Windows
        set guifont=DejaVu_Sans_Mono:h08:cDEFAULT
        au GUIEnter * simalt ~x      " Start maximized

      elseif has("gui_macvim")
        " MacVim in OS X
        set guifont=DejaVu\ Sans\ Mono:h14
        set guioptions-=T            " remove the toolbar
        set guioptions-=r            " remove the right scrollbar
        set guioptions-=L            " remove the left scrollbar
        "macmenu &Edit.Find.Find\.\.\. key=<nop> " free up Command-F
        map <D-F> :set invfu<CR>                " toggle fullscreen mode
        set fuopt+=maxhorz " grow to maximum horizontal width on entering
                           " fullscreen mode
      endif

      " GVim in any environment
      set columns=999    " create windows with maximum width by default
      set lines=999      " create windows with maximum height by default

      "set transparency=5          " Make the window slightly transparent
      " Enable conceal (display math characters instead of tex math, except
      " for the line being edited.
      set cole=2
      let g:tex_conceal= 'adgm'
      hi Conceal guibg=White guifg=DarkMagenta
      hi Conceal guifg=DarkMagenta
      " TODO: get conceal to work for latex math statements in pandoc/markdown
      " files.

    else    " In the terminal
      colorscheme desert

      " TODO: what is this?
      "set term=builtin_ansi       " Make arrow and other keys work
    endif
  " }

  " Command line {

    if has('cmdline_info')
      set ruler     " show the ruler
      set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
      set showcmd   " show partial commands in status line and
                    " selected characters/lines in visual mode
      set report=0  " : commands always print changed line count.
    endif
  " }

"""" Messages, Info, Status

  " Status line {

    if has('statusline')
      set laststatus=2       " Always show status line

      " Broken down into easily includeable segments
      set statusline=%{getcwd()}                 " current dir
      set statusline+=\ %{fugitive#statusline()}    " Git Hotness
      set statusline+=\ %{exists('g:loaded_rvm')?rvm#statusline():''}
      set statusline+=\ %{&ff}/%Y                   " filetype
      "set statusline+=\ [A=\%03.3b/H=\%02.2B]      " ASCII / Hexadecimal value of char
      "set statusline+=%=%-14.(%l,%c%V%)\ %p%%      " Right aligned file nav info
      set statusline+=%h%=\ %t                      " Filename
      "set statusline=%<%f\                         " Filename
      set statusline+=%w%h%m%r                      " Options
      set statusline+=%h%=\ %l,%v\ %p%%             " file nav info

      " abachman's:
      "set statusline=%t%m\ cwd:\ %{exists('g:loaded_rvm')?rvm#statusline():''}\ %r%{getcwd()}%h%=col:%3v\ line:%4l\ of\ %L\ %p%%
    endif

    "set statusline=%t\ %m\ %h%=col:%3v\ line:%4l\ of\ %L\ %p%%
  " }

  " Text highlighting {

  " Highlight problematic whitespace
    set listchars=tab:>-,eol:$,trail:-,precedes:<,extends:>,nbsp:.
    set list
  " }

  " Pairs matching {

    set matchpairs+=<:>         " show matching <> (html mainly) as well

    " plugin - matchit {
      " Load matchit (% to bounce from do to end, etc.)
      runtime! plugin/matchit.vim
    " }

    " plugin - Delimitmate {
      "au FileType * let b:delimitMate_autoclose = 1
      " If using html auto complete (complete closing tag)
      "au FileType xml,html,xhtml let b:delimitMate_matchpairs = "(:),[:],{:}"
    " }
  " }
" }

" Vim UI - Control: Mouse, Key mappings {

  " Intuitive backspacing in insert mode
  " Allow backspacing over autoindent, EOL, and BOL
  set backspace=indent,eol,start

  set scrolljump=5        " Number of lines to scroll when cursor leaves screen
  set scrolloff=3         " Keep 3 lines visible at top and bottom.

  set nostartofline       " Avoid moving cursor to BOL when jumping around.
  set virtualedit=block   " Let cursor move past the last char in <C-v> mode.
  "set virtualedit=onemore " Allow for cursor beyond last character.

  " Mouse {

    set mouse=a
    set ttymouse=xterm2
  " }

  " Formatting {

    set tabstop=2
    set shiftwidth=2        " An indentation every four columns.
    set softtabstop=2       " Let backspace delete indent.
    set autoindent
    set smartindent         " Use smart indent if there is no indent file.
    set expandtab
    set smarttab
    "set whichwrap=<,>,[,],h,l    " Wrap on movement keys.
    set whichwrap=b,s,h,l,<,>,[,]	" Backspace and cursor keys wrap to

    " FIXME: this doesn't seem to be working.
    " Don't automatically insert the current comment leader after hitting 'o'
    " or 'O' in Normal mode.
    set formatoptions-=o

    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks

    " Remove trailing whitespace and ^M chars
    " NOTE: This runs slowly and causes too much wait time after saving the
    " buffer.
    "autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

    " Remove trailing whitespace on <leader>S
    " FIXED: neither of the following commands work in every instance.
    "nnoremap <leader>S :%s/\s\+$//<CR>:let @/=''<CR>
    "nnoremap <leader>S :%s/\s\+$//<CR>
  " }

  " Key (re)mappings {

    " The key represented by <leader>
    let mapleader = ","             " change the leader to be a comma vs slash

    " TODO: move this setting to where it won't get picked up in Windows
    " sudo write this
    cmap W! w !sudo tee % >/dev/null
    cmap w!! w !sudo tee % >/dev/null

    " Fast editing of the .vimrc
    map <leader>rc :e! ~/src/newdotvim/.vimrc<CR>

    " Reload vimrc
    nmap <leader>s :source ~/src/newdotvim/.vimrc<CR>

    " When pressing <leader>cd switch to the directory of the open buffer
    map <leader>cd :cd %:p:h<CR>

    " Clean trailing spaces
    noremap <silent> <leader>v mv:%s/\s\+$//e<CR>:%s/\t/  /e<CR>`v

    " Select current definition
    nmap <leader>vm <esc>[mmd]MV'd

    " Fix problem default mappings {

      " FIXME: These cause problems when typing into the console.
      " Stupid shift key fixes
      "cmap W w
      "cmap WQ wq
      "cmap wQ wq
      "cmap Q q
      "cmap Tabe tabe

      " Yank from the cursor to the end of the line, to be consistent with C and D.
      nnoremap Y y$

      " Fix home and end key-bindings for screen, particularly on mac
      " - for some reason this fixes the arrow keys too. huh.
      "map [F $
      "imap [F $
      "map [H g0
      "imap [H g0

      " map shift-k to a safer function
      vmap K <up>
      nmap K <up>
    " }

    " Indenting {

      " Tab and Shift-Tab indent and unindent
      " NOTE: these interfere with SuperTab
      "inoremap <S-Tab> <esc>mp<<2h`pa
      "noremap <Tab> >>
      "noremap <S-Tab> <<
      "vnoremap <Tab> >gv
      "vnoremap <S-Tab> <gv
    " }

    " Code folding key-mappings {

      "nmap <leader>f0 :set foldlevel=0<CR>
      "nmap <leader>f1 :set foldlevel=1<CR>
      "nmap <leader>f2 :set foldlevel=2<CR>
      "nmap <leader>f3 :set foldlevel=3<CR>
      "nmap <leader>f4 :set foldlevel=4<CR>
      "nmap <leader>f5 :set foldlevel=5<CR>
      "nmap <leader>f6 :set foldlevel=6<CR>
      "nmap <leader>f7 :set foldlevel=7<CR>
      "nmap <leader>f8 :set foldlevel=8<CR>
      "nmap <leader>f9 :set foldlevel=9<CR>
    " }

    " Window navigation with ctrl key {

      inoremap <C-h> <esc><C-w><C-h>
      inoremap <C-j> <esc><C-w><C-j>
      inoremap <C-k> <esc><C-w><C-k>
      inoremap <C-l> <esc><C-w><C-l>
      noremap <C-h> <C-w><C-h>
      noremap <C-j> <C-w><C-j>
      noremap <C-k> <C-w><C-k>
      noremap <C-l> <C-w><C-l>
      " Make these all work in insert mode too ( <C-O> makes next cmd
      "  happen as if in command mode )
      imap <C-w> <C-o><C-w>
    " }

    " Copy / paste using system clipboard {

      " Paste from clipboard
      map <leader>p "+gP

      vmap <C-y> "+y
      vmap <C-u> "+p
      nmap <C-u> "+p
      "imap <C-u> <esc>"+p
      "imap <C-v> <esc>pa
      imap <C-u> <C-r>+
      imap <C-v> <C-r>+
    " }

    " Toggle numbers
    nmap <leader>n :set nonu!<CR>

    " Hashrocket!
    imap hh =>

    " TODO: how can I make this toggle wrap mode?
    "map <leader>q <esc>:call WrapMode()<CR>

    " Clear all comment markers (one rule for all languages)
    map <leader>_ :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>:nohlsearch<CR>

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " open/close the quickfix window
    nmap <leader>c :copen<CR>
    nmap <leader>cc :cclose<CR>
  " }
" }

" Vim UI - Tools: search, grep, completion {

  " Highlight searches, clear with spacebar
  set hlsearch                " Highlight searches by default.
  set highlight=l:Visual
  nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
  set incsearch               " find as you type search

  set ignorecase              " Default to using case insensitive searches,
  set smartcase               " unless uppercase letters are used in the regex.

  " Autocompletion / OmniComplete - settings {

    " Behaves like bash
    set wildmenu
    set wildmode=list:longest,full
    " Ignore these files when completing
    set wildignore+=*.o,*.obj,.git,*.pyc

    """ Insert completion
    " don't select first item, follow typing in autocomplete
    " Vim tip 1386 insert-mode auto-completion
    "set completeopt=longest,menuone
    set completeopt=menuone,longest,preview
    set pumheight=6             " Keep a small completion window

    " close preview window automatically when we move around
    autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif

    set omnifunc=syntaxcomplete#Complete

    "if has("autocmd") && exists("+omnifunc")
    "  autocmd Filetype *
    "    \if &omnifunc == "" |
    "    \setlocal omnifunc=syntaxcomplete#Complete |
    "    \endif
    "endif

    "autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    "autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    "autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    "autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
    "autocmd FileType php set omnifunc=phpcomplete#CompletePHP
    "autocmd FileType c set omnifunc=ccomplete#Complete

    " automatically open and close the popup menu / preview window
    "au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
    "set completeopt=menu,preview,longest

    " Use tab to scroll through autocomplete menus
    autocmd VimEnter * imap <expr> <Tab> pumvisible() ? "<C-N>" : "<Tab>"
    autocmd VimEnter * imap <expr> <S-Tab> pumvisible() ? "<C-P>" : "<S-Tab>"
  " }

  " Autocompletion / OmniComplete - key mappings {

"    inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
"    inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
"    inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
"    inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
"    inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
    " the following interferes with my choice for pasting from the system
    " clipboard in imode:
"    inoremap <expr> <C-n>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

    " http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
    " Change the behavior of the <Enter> key when the popup menu is visible. In
    " that case the Enter key will simply select the highlighted menu item,
    " just as <C-Y> does.
    "inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    " make <C-N> work the way it normally does; however, when the menu
    " appears, the <Down> key will be simulated. What this accomplishes is it
    " keeps a menu item always highlighted.
    "inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
    "  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
    " simulates <C-X><C-O> to bring up the omni completion menu, then it
    " simulates <C-N><C-P> to remove the longest common text, and finally it
    " simulates <Down> again to keep a match highlighted.
    "inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
    "  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

    " TODO: what is the following supposed to do?
    "noremap <expr> <C-n> pumvisible() ? '<C-n>'  : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
  " }

" }

" Vim UI - Folding - settings and key mappings {

  " TODO: what does this do?
  "set foldcolumn=0      " little space on the left.

  " Variable for ToggleFold()
  au FileType * let b:folded = 1
  map Z :call ToggleFold()<CR> 
" }

" Buffers {

  set hidden           "allow hiding buffers without save
" }

" Plugin highlighting {

  " OmniComplete {

    " Popup menu hightLight Group
    "highlight Pmenu  ctermbg=13  guibg=DarkBlue
    highlight Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
    "highlight PmenuSel  ctermbg=7  guibg=DarkBlue    guifg=LightBlue
    "highlight PmenuSbar ctermbg=7  guibg=DarkGray
    highlight PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
    "highlight PmenuThumb      guibg=Black
    highlight PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE
  " }
" }

" Plugin Settings {

  " ctags {
    :set tags=~/mytags
  " }

  " AutoComplPop {
    let g:acp_completeoptPreview=1
  " }

  " AutoCloseTag {
    " TODO: figure out where this plugin exists on the internet.
    " Make it so AutoCloseTag works for xml and xhtml files as well
    "au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
  " }

  " Plugin - eclim settings {
    " TODO: verify this works
    "let g:EclimShowCurrentError=0
  " }

  " SnipMate {
    " Setting the author var
    " If forking, please overwrite in your .vimrc.local file
    let g:snips_author = 'Luke Orland <orluke@gmail.com>'

    " Don't allow snipmate to take over tab
    autocmd VimEnter * ino <c-j> <c-r>=TriggerSnippet()<cr>
  " }

  " NERDTree {
    let NERDTreeShowBookmarks=1
    let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
    let NERDTreeChDirMode=0
    let NERDTreeQuitOnOpen=0
    " Press I if you want to see hidden files.
    let NERDTreeShowHidden=0
    let NERDTreeKeepTreeInNewTab=1 " Undocumented setting.
  " }

  " Supertab {
    "let g:SuperTabDefaultCompletionType = "context"
    "let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
    " and make sure that it doesn't break supertab
    "let g:SuperTabCrMapping = 0
  " }

  " TagList Variables {

"    " Display function name in status bar:
"    let g:ctags_statusline=1
"
"    " Automatically start script
"    let generate_tags=1
"
"    let Tlist_Auto_Highlight_Tag = 1
"    let Tlist_Auto_Update = 1
"    let Tlist_Compact_Format = 1
"    let Tlist_Exit_OnlyWindow = 1
"    let Tlist_File_Fold_Auto_Close = 1
"    let Tlist_GainFocus_On_ToggleOpen = 1
"    let Tlist_Highlight_Tag_On_BufEnter = 1
"    let Tlist_Use_Right_Window = 1
"    let Tlist_Use_SingleClick = 1
"    let Tlist_Use_Horiz_Window=0    " Displays taglist results in a vertical window:
"
"    let g:ctags_statusline=1
"    " Override how taglist does javascript
"    let g:tlist_javascript_settings = 'javascript;f:function;c:class;m:method;p:property;v:global'
   " }
" }

" Plugin key-mappings {

  " BufClose.vim key-mappings {
    nmap <leader>bd :BufClose<CR> " Close buffer without changing window layout.
  " }

  " NerdTree key-mappings {
    map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
  " }

  " Ctags key-mappings {

    " This will look in the current directory for 'tags', and work up the tree towards root until one is found. 
    set tags=./tags;/,$HOME/vimtags

    " Open the definition in a new tab
    map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

    " Open the definition in a vertical split
    map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
  " }

  " SnipMate key-mappings {
    " Shortcut for reloading snippets, useful when developing
    nnoremap <leader>smr <esc>:exec ReloadAllSnippets()<cr>

    " TODO: what's this?
    "snor <c-j> <esc>i<right><c-r>=TriggerSnippet()<cr>
  " }

  " TagList key-mappings {
    " Shorter commands to toggle Taglist display
    "nnoremap TT :TlistToggle<CR>
  " }

  " TaskList {
    map <leader>td <Plug>TaskList
  " }

  " command-t key-mappings {
    " Run command-t file search
    "map <leader>f :CommandT<CR>
  " }

  " Gundo key-mappings {
    " Load the Gundo window
    map <leader>g :GundoToggle<CR>
  " }

  " vim-pep8 {
    " FIXME: The default <F6> doesn't get released no matter where I put this.
    " (I also tried the bottom of the file.)
    " I put it in .vim/ftplugin/python.vim as well for good measure.
    autocmd FileType python map <buffer> <F8> :call Pep8()<CR>
  " }
" }

" Filetype-specific Settings {

augroup myfiletypes
  " Clear old autocmds in group
  autocmd!

  " lcd to current rails project root
  autocmd BufRead *.ecl set filetype=prolog
  autocmd BufRead *.pro set filetype=prolog
  autocmd BufRead *.plg set filetype=prolog
  autocmd BufRead *.as set filetype=actionscript
  autocmd BufRead *.mxml set filetype=mxml
  autocmd BufRead *.rtex set filetype=tex
  autocmd BufRead *.clj set filetype=clojure
  autocmd BufRead *.pde set filetype=arduino
  autocmd BufRead *.m set filetype=matlab
  autocmd BufRead *.pyx set filetype=python
  " json is javascript
  autocmd BufNewFile,BufReadPost,BufEnter *.json set filetype=javascript
  autocmd BufRead,BufNewFile *.md set filetype=pandoc
  autocmd BufRead,BufNewFile *.mdown set filetype=pandoc
  autocmd BufRead,BufNewFile *.markdown set filetype=pandoc
  autocmd BufRead,BufNewFile *.mkd set filetype=pandoc
  autocmd BufRead,BufNewFile *.txt set filetype=text
  autocmd BufRead,BufNewFile *.ru set filetype=ruby
  autocmd BufRead,BufNewFile *.gradle set filetype=groovy
  autocmd BufNewFile,BufRead *.mako,*.mak setlocal ft=html  " Mako is HTML
  autocmd FileType html,xhtml,xml,css call s:MyHtmlSettings()
  autocmd FileType groovy,java,c,cpp,c++ call s:MyCLikeSettings()
  autocmd FileType ruby,eruby call s:MyRubySettings()
  autocmd FileType vim call s:MyVimSettings()
  autocmd FileType javascript call s:MyJavascriptSettings()
  "autocmd FileType markdown call s:MyMarkdownSettings()
  autocmd FileType pandoc call s:MyTextFileSettings()
  autocmd FileType text call s:MyTextFileSettings()
  autocmd FileType clojure call s:MyClojureSettings()
  autocmd FileType actionscript,mxml call s:MyFlexSettings()
augroup END
" }

" Functions {

function! MyHtmlSettings()
  setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
endfunction

function! WrapMode()
  setlocal formatoptions=tcql
  setlocal wrap
  setlocal lbr
  set foldenable      " auto fold code
  setlocal foldmethod=manual
  " treat long wrapped lines (paragraphs) like short lines.
  " i.e., directional keys move directly up and down visually
  " and movement keys wrap to the next visual line, not the
  " next line break.
  map <buffer> <up> gk
  imap <buffer> <up> <C-o>gk
  map <buffer> <down> gj
  imap <buffer> <down> <C-o>gj
  map <buffer> <home> g<home>
  imap <buffer> <home> <C-o>g<home>
  map <buffer> <end> g<end>
  imap <buffer> <end> <C-o>g<end>
  map <buffer> j gj
  map <buffer> k gk
endfunction

function! s:MyCLikeSettings()
  " Insert comments markers
  map - :s/^/\/\//<CR>:nohlsearch<CR>
  set iskeyword=@,48-57,_,192-255

endfunction

"function! s:MyMarkdownSettings()
" the settings are in `.vim/ftplugin/markdown.vim`
"endfunction

function! s:MyTextFileSettings()
  "set ai formatoptions=tcroqn2 comments=n:>
  set autoindent
  :call WrapMode()
  set linebreak
endfunction

function! s:MyVimSettings()
  " Insert comments markers
  map - :s/^/\"/<CR>:nohlsearch<CR>
endfunction

function! s:MyRubySettings()
  set ai sw=2 sts=2 et
  "improve autocomplete menu color
  "let g:closetag_html_style=1
  " Insert comments markers
  map - :s/^/#/<CR>:nohlsearch<CR>
  " wrap selected text in ERB escape tag
  vnoremap <leader>m "zdi<%= <C-R>z %><ESC>
  " Get rid of rails format.html { } blocks
  map <silent> <leader>rf :%s/[a-z]*\.[a-z]* { \([^]*\) }/\1<CR>
endfunction

function! s:MyClojureSettings()
  " let g:clj_highlight_builtins=1      " Highlight Clojure's builtins
  " let g:clj_paren_rainbow=1           " Rainbow parentheses'!
  let g:vimclojure#HighlightBuiltins=1   " Highlight Clojure's builtins
  let g:vimclojure#ParenRainbow=1        " Rainbow parentheses'!
  let g:vimclojure#DynamicHighlighting=1 " Dynamically highlight functions
endfunction

function! s:MyFlexSettings()
  set smartindent sw=2 sts=2 et
endfunction

function! s:MyJavascriptSettings()
  setlocal makeprg=jslint\ %
endfunction

" TODO: figure out what the heck this does (copied from spf13-vim).
function! NERDTreeInitAsNeeded()
  redir => bufoutput
  buffers!
  redir END
  let idx = stridx(bufoutput, "NERD_tree")
  if idx > -1
    NERDTreeMirror
    NERDTreeFind
    wincmd l
  endif
endfunction

" Copied from http://www.vim.org/scripts/script.php?script_id=1494
function! ToggleFold() 
    if( b:folded == 0 ) 
        exec "normal! zM" 
        let b:folded = 1 
    else 
        exec "normal! zR" 
        let b:folded = 0 
    endif 
endfunction 

" http://blogs.gnome.org/lharris/2008/07/20/code-completion-with-vim-7/
"function! SuperCleverTab()
"  if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
"      return "\<Tab>"
"  else
"    if &omnifunc != ''
"      return "\<C-X>\<C-O>"
"    elseif &dictionary != ''
"      return "\<C-K>"
"    else
"      "return "\<C-N>"
"    endif
"  endif
"endfunction
"
"inoremap <Tab> <C-R>=SuperCleverTab()<cr>

" }

" Use local vimrc if available {

  if filereadable(expand("~/.vimrc.local"))
      source ~/.vimrc.local
  endif
" }

