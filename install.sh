#!/bin/bash

mkdir -p deps
git submodule update --init --recursive

INSTALLDIR=deps/vimified

create_symlinks () {
    if [ ! -f ~/.vim ]; then
        echo "Now, we will create ~/.vim and ~/.vimrc files to configure Vim."
        ln -sfn $INSTALLDIR ~/.vim
    fi

    if [ ! -f ~/.vimrc ]; then
        ln -sfn $INSTALLDIR/vimrc ~/.vimrc
    fi
  }

create_symlinks
echo -e "let g:vimified_packages = [\n\
\\  'general',\n\
\\  'fancy',\n\
\\  'js',\n\
\\  'os',\n\
\\  'html',\n\
\\  'python',\n\
\\  'coding',\n\
\\  'color',\n\
\\]" > ~/.vim/local.vimrc
pushd $PWD
cd deps
sh vimified/install.sh
popd

ln -sfn $PWD/vimrc.before ~/.vim/before.vimrc
ln -sfn $PWD/vimrc.extra ~/.vim/extra.vimrc
ln -sfn $PWD/vimrc.after ~/.vim/after.vimrc

ln -sfn $PWD/gvimrc ~/.gvimrc
