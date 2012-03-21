"set ai formatoptions=tcroqn2 comments=n:>
" BTW: I'm using http://github.com/hallison/vim-markdown for markdown syntax
" highlighting.
setlocal shiftwidth=4
set autoindent

" Wrapping
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
setlocal linebreak
