# dotfiles

Completely cross-platform dotfiles, including Windows!

## Why would I want my dotfiles on GitHub?

Please see [GitHub ❤ ~/](http://dotfiles.github.io/), as they have answered
this question as well as anyone.

## Why support Windows?

This is a much better question, and the answer goes beyond being cross-platform
to being cross-industry. The fact of the matter is that influential, top-class
game development is largely done on Windows even though influential, top-class
web development is largely done on OS X.

Though not the norm, I use the majority of these tools to develop games in the
same way I use them to develop web applications. I don't feel like
context-switching between these two industries should require me to
context-switch between two sets of tools (or configurations thereof), hence
the effort to make these dotfiles cross-platform.

## Usage & Installation

 1. [Fork the dotfiles.](https://github.com/Schoonology/dotfiles/fork)
 1. Clone your fork somewhere on the same virtual drive as your home folder. I
    recommend `~/.dotfiles`.
 1. Run the `install` script.
 1. Edit your dotfiles, especially `.gitconfig`, to match your name, email,
    machine-specific settings, etc.
 1. Commit your changes to your fork.
 1. Congratulations, your dotfiles are now safe on GitHub!

One note on changes made to your fork. _Please don't include sensitive
information like passwords and keys!_ If you notice, the `ssh` folder includes
a very useful `.ssh/config` file. Notice that the actual keys and usernames are
_not_ present. That's one thing you _don't_ want to share with the world.

### Notes for Windows users

 1. Ensure that `git` is available to the `install` script for `npm` to work
    correctly (required).
 1. You may have to run the `install` script as Administrator due to symlink
    permissions being unusual by default. A caveat of running `node` in the
    Administrator shell is that you'll need to manually set an additional
    environment variable. From the shell, `cd` into your home directory, then
    run `set HOME = %CD%`. At this point, the `install` script should work
    normally.
