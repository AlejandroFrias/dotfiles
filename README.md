# Alejandro's Dotfiles

A collection of my dotfiles.

## Usage

```
git clone https://github.com/AlejandroFrias/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
sh install.sh
```

## Requirements

  * `rcm` - The install script relies on `rcm`, https://github.com/thoughtbot/rcm. Using
    that rc file manager, all the dotfiles will be symlinked to your home directory.
  * `git` - git is used to install vim/tmux plugins
  * `vim` - Using version 8.0
  * `tmux` - Using version 2.1
  * `ctags` - Exuberant Ctags 5.9~svn20110310
  * `iterm2` (optional) - If you have iterm2 installed, you'll get my custom profiles and key mappings!

## Sublime

You need to manually copy the contents of `Sublime/` into your Sublime user package folder.
No automatic installation has been setup for this.
