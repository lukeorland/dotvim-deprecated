" .vim/ftplugin/python.vim
" Luke Orland
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker nospell:

" Formatting and visual aspects: {
  " I need to set these indent values here - the indentpython script won't do
  " that automatically.
  " see: http://stackoverflow.com/questions/2011589/vim-python-indentation-not-working
  setlocal tabstop=4
  setlocal softtabstop=4
  setlocal shiftwidth=4
  setlocal textwidth=79
  setlocal smarttab
  setlocal expandtab
  setlocal smartindent

  " These keywords start an extra indent in the next line when
  " 'smartindent' or 'cindent' is set.  For 'cindent' this is only done at
  "setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class,with
  "setlocal complete+=k~/.vim/syntax/python.vim isk+=.,(

  " Insert comments marker at the first column.
  "map - :s/^/#/<CR>:nohlsearch<CR>

  " Delete a comments marker in the first column.
  "map _ :s/^#//<CR>:nohlsearch<CR>

  setlocal nowrap
  setlocal foldmethod=indent    " allow us to fold on indents

  " Show a line at column 79.
  if exists("&colorcolumn")
      set colorcolumn=79
  endif
" }

" Autocompletion: omni-, SuperTab, ropevim, pysmell {
  set omnifunc=pythoncomplete#Complete
  let g:SuperTabDefaultCompletionType = "context"

  let ropevim_vim_completion = 1
  let ropevim_extended_complete = 1
  "let g:ropevim_autoimport_modules = ["os.*","traceback","django.*", "xml.etree"]
" }

" key-mappings {

  " TODO: does this do anything?
  " don't outdent hashes
  inoremap # #

  " execute the file in the current buffer with the python interpreter.
  map <leader>, :!python %<CR>

  " The following requires the updated syntax highlighting script at
  " http://www.vim.org/scripts/script.php?script_id=790
  "set complete+=k$HOME/.vim/bundle/python.vim--Vasiliev/syntax/python.vim isk+=.,(

  "set complete+=k$HOME/.vim/bundle/pydiction-0.5/pydiction isk+=.,(

  " FIXME: This works, but the default mapping doesn't go away as published.
  map <buffer> <F8> :call Pep8()<CR>

  " Use the plugin vim-nosecompiler
  compiler nose
  " FIXME: vim-makegreen won't work quite right with vim-nosecompiler.

  " run py.test (AKA pytest) tests
  "nmap <silent><Leader>tf <Esc>:Pytest file<CR>
  "nmap <silent><Leader>tc <Esc>:Pytest class<CR>
  "nmap <silent><Leader>tm <Esc>:Pytest method<CR>
  "nmap <silent><Leader>tn <Esc>:Pytest next<CR>
  "nmap <silent><Leader>tp <Esc>:Pytest previous<CR>
  "nmap <silent><Leader>te <Esc>:Pytest error<CR>

  " FIXME: seems like pysmell won't install under python 3 or something.
  "setlocal omnifunc=pysmell#Complete
  "let g:pysmell_debug=1
  "e PYSMELL_DEBUG
  " Hint: update the PYSMELLTAGS file with the following commands:
  " TODO: make this automatic when any file gets saved, do it for the
  " root directory of the ropevim project.
  " cd /root/of/project
  " pysmell .
" }

" key-mappings - rope plugin {

  " Jump to the definition of whatever the cursor is on
  map <leader>j :RopeGotoDefinition<CR>

  " Rename whatever the cursor is on (including references to it)
  map <leader>r :RopeRename<CR>

  imap <c-space> <C-R>=RopeCodeAssistInsertMode()<CR>
" }

" Plugins - testing and error checking {
  " Don't let pyflakes use the quickfix window
  let g:pyflakes_use_quickfix = 0

  " TODO: what's this? Error formatting?
  "set errorformat=%f:%l:\ %m
  setlocal errorformat=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

  "set makeprg=pylint\ --reports=n\ --output-format=parseable\ %:p

  " Pydiction {
    "let g:pydiction_location = '$HOME/.vim/bundle/Pydiction/ftplugin/pydiction/complete-dict'
  " }
" }

" Add the virtualenv's site-packages to vim path {
py << EOF
import os.path
import sys
import vim
if 'VIRTUALENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

" Load up virtualenv's vimrc if it exists
if filereadable($VIRTUAL_ENV . '/.vimrc')
    source $VIRTUAL_ENV/.vimrc
endif
" }
