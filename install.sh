# symlink all dotfiles to home directory
hash rcup 2>/dev/null || { echo >&2 "Please install rcm.  Aborting."; exit 1; }
rcup -x README.md -x install.sh -x Sublime

# Install VIM plugins
hash vim 2>/dev/null || { echo >&2 "Please install vim. Aborting."; exit 1; }
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
   git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
vim +PluginInstall +qall

# Install TMUX plugins
hash tmux 2>/dev/null || { echo >&2 "Please install tmux. Aborting."; exit 1; }
if [ ! `echo "$(tmux -V | cut -d' ' -f2)"" < 2.1" | sed s/[a-zA-Z]//g | bc` ]; then
    echo >&2 "Please upgrade tmux to 2.1 or greater. Aborting."; exit 1;
fi
if [ ! -d ~/.tmux/plugins/tpm ]; then
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
~/.tmux/plugins/tpm/bin/install_plugins
