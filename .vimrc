" Modeline and Notes {
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker nospell:
"
" This is the personal .vimrc file of Luke Orland
" some influence from the .vimrc file from Steve Francia.
" }

" Environment {

  " Basics {

    set nocompatible        " We're running Vim, not Vi! Must be the first line.
    scriptencoding utf-8

    " set autowrite                  " automatically write a file when leaving a modified buffer
    "set shortmess+=filmnrxoOtT       " abbrev. of messages (avoids 'hit enter')
    "set virtualedit=onemore        " allow for cursor beyond last character
    set history=1000          " Store a ton of history (default is 20)
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
      " The text displayed on the fold line
      set foldtext=getline(v:foldstart)
    " }
  " }

  " Temp directories {

    set backup
    set backupdir=~/.vim/backup " where to put backup file
    set directory=~/.vim/temp   " directory is the directory for temp file
  " }

  " Buffers {

    "au BufWinLeave * silent! mkview  "make vim save view (state) (folds, cursor, etc)  TODO ?
    "au BufWinEnter * silent! loadview "make vim load view (state) (folds, cursor, etc)  TODO ?
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
      "Bundle 'ervandew/supertab'
      " SnipMate
        "Bundle 'msanders/snipmate.vim'
        "Bundle 'scrooloose/snipmate-snippets'
      "Bundle 'Raimondi/delimitMate'
      "Bundle 'matchit.zip'
      "Bundle 'html_autoclosetag.vim'
      "Bundle 'tpope/vim-surround'
    " }

    " Vundle - Directory navigation, buffers, terminal, undo, tests {

      Bundle 'scrooloose/nerdtree'
      "Bundle 'FuzzyFinder'
      "Bundle 'git://git.wincent.com/command-t.git'
      Bundle 'bufexplorer.zip'
      "Bundle 'vim-bclose'
      Bundle 'BufClose.vim'
      "Bundle 'minibufexpl.vim'
      "Bundle 'rson/vim-conque'
      "Bundle 'EvalSelection.vim'
      "Bundle 'sjl/gundo.vim'
      Bundle 'YankRing.vim'
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
        "Bundle 'kevinw/pyflakes-vim'
        Bundle 'mitechie/pyflakes-pathogen'

      " The following is enhanced syntax highlighting for python. seems buggy
      " to me.
      " Install it, then checkout the python3 branch to get highlighting for 
      " python3.0
      "Bundle 'vim-scripts/python.vim--Vasiliev'
      Bundle 'indentpython.vim'

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

      "Bundle 'nvie/vim-pep8'
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
      "Bundle 'lukeorland/Vim-nosecompiler'

      " I can't get pydiction to do what it says it does. Maybe the problem is
      " due to setting the wrong pydiction_location below (in Windows).
      " see: http://www.rootninja.com/tab-completion-for-python-in-vim/
      " see: http://www.mohdshakir.net/2007/12/27/enable-vim-code-python-auto-complete
      " see: http://stackoverflow.com/questions/1687252/with-vim-use-both-snipmate-and-pydiction-together-share-the-tab-key
      "Bundle 'Pydiction'

      " To get pydoc working in Windows see the answer by Dave Webb at
      " http://stackoverflow.com/questions/3391998/pydoc-is-not-working-windows-xp
      "Bundle 'fs111/pydoc.vim'

      "Bundle 'python_match.vim'
      "Bundle 'python_showpydoc.vim'
      "Bundle 'pythoncomplete'

      " This doesn't work in my Windows 7 environment.
      "Bundle 'sontek/rope-vim'

      " Instead, trying the simpler bundle + the system-install version of the
      " Python rope libraries.
      " Actually, there isn't support for python 3, so nevermind.
      "Bundle 'gordyt/rope-vim'

      "Bundle 'AutoComplPop'
    " }

    " Vundle - Other filetype-specific plugins {

      Bundle 'tiddlywiki'
      "Bundle 'LaTeX-Suite-aka-Vim-LaTeX'
      Bundle 'vim-pandoc/vim-pandoc'
      "Bundle 'Arduino-syntax-file'
      "Bundle 'lukeorland/yaml-vim.git'
      "Bundle 'vim-ruby/vim-ruby.git'
      "Bundle 'groovy.vim'
      "Bundle 'lukeorland/groovyindent.git'
      "Bundle 'matlab.vim'
      "Bundle 'tpope/vim-markdown.git'
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
  "cd ~
" }

" Vim UI - Sound / Display / View / Visual aspects {

  " don't bell or blink
  set noerrorbells
  set visualbell t_vb=

  "set winminheight=0        " windows can be 0 line high

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
      "colorscheme pyte

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

" Key (re)mappings {

  " The key represented by <leader>
  let mapleader = ","             " change the leader to be a comma vs slash

  " Fast editing of the .vimrc
  map <leader>rc :e! ~/.vimrc<CR>

  " Reload vimrc
  nmap <leader>s :source ~/.vimrc<CR>

  " Fix problem default mappings {

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

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

  " Toggle numbers
  nmap <leader>n :set nonu!<CR>

  " Folding {

    " Variable for ToggleFold()
    au FileType * let b:folded = 1
    map Z :call ToggleFold()<CR> 
  " }

" }

" Plugin key-mappings {

  " BufClose.vim key-mappings {
    nmap <leader>bd :BufClose<CR> " Close buffer without changing window layout.
  " }

  " NerdTree key-mappings {
    map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
  " }

" Plugin Settings {

  " NERDTree {
    let NERDTreeShowBookmarks=1
    let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
    let NERDTreeChDirMode=0
    let NERDTreeQuitOnOpen=0
    " Press I if you want to see hidden files.
    let NERDTreeShowHidden=0
    let NERDTreeKeepTreeInNewTab=1 " Undocumented setting.
  " }
" }

" Functions {

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

" }

au FileType crontab set nobackup nowritebackup
