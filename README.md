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


## How to cherry pick Counsyl ./manage.py bash completeion

Django has bash completion, but if you're `./manage.py` script takes a long time to run `help`, then
the built-in bash completion is too slow to be useful. My bash completion simply saves the output of
`./manage.py help <subcommand>` and parses the saved output of `help` instead of needed to generate
it on each autocomplete attempt.

Here's how to cherry pick my ./manage.py bash completion.
```
git clone https://github.com/AlejandroFrias/dotfiles.git
mv dotfiles/django ~/.django
mv dotfiles/bash/django_bash_completion.sh ~/.django_bash_completion.sh
echo "source ~/.django_bash_completeion.sh" >> ~/.bashrc
```

To update the autocompletion options for a subcommand:
```
./manage.py help <subcommand> > ~/.django/help_output/<subcommand>.txt
```

To update the list of subcommands:
```
./manage.py help > ~/.django/help_output/help.txt
```

The scenario lists cannot be automated since they are not rendered in a consistent way across our apps.
So I've been manually updating those as needed. If someone makes the help output of the various scenario
lists more parser friendly, please let me know, I'll update the autocomplete script.
