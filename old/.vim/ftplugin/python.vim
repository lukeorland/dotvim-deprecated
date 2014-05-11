setlocal textwidth=79
setlocal shiftwidth=4
"setlocal tabstop=4
setlocal tabstop=8
setlocal softtabstop=4
setlocal smarttab
setlocal expandtab
setlocal shiftround
"setlocal autoindent
"setlocal backspace=indent,eol,start
setlocal colorcolumn=80
au FileType python setlocal omnifunc=pythoncomplete#Complete
compiler nose
map <Leader>] <Plug>MakeGreen " change from <Leader>t to <Leader>]

" Python-mode-klen settings {{{
  let g:pymode_lint_checker = "pyflakes"
  " copied from https://github.com/garbas/vim-config-garbas/blob/master/autoload/vim_config_garbas.vim
  "let g:pymode_doc = 0
  "let g:pymode_run = 0
  "let g:pymode_lint = 0
  "let g:pymode_breakpoint = 0
  "let g:pymode_syntax = 1
  "let g:pymode_utils_whitespaces = 0
  "let g:pymode_virtualenv = 0
  "let g:pymode_options_indent = 0
  "let g:pymode_options_fold = 0
  "let g:pymode_options_other = 0
  "let g:pymode_rope = 1
  "let g:pymode_rope_global_prefix = "<localleader>R"
  "let g:pymode_rope_local_prefix = "<localleader>r"
  "let g:pymode_rope_sorted_completions = 1
  "let g:pymode_rope_extended_complete = 1
  "let g:pymode_rope_vim_completion = 1

  ""let g:pymode_rope_auto_project = 1
  ""let g:pymode_rope_enable_autoimport = 0
  ""let g:pymode_rope_autoimport_generate = 1
  ""let g:pymode_rope_autoimport_underlineds = 0
  ""let g:pymode_rope_codeassist_maxfixes = 10
  ""let g:pymode_rope_autoimport_modules = ["os", "shutil", "datetime"]
  ""let g:pymode_rope_confirm_saving = 1
  ""let g:pymode_rope_guess_project = 1
  ""let g:pymode_rope_goto_def_newwin = 0
  ""let g:pymode_rope_always_show_complete_menu = 0
" }}}
