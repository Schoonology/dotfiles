// Link all the dotfiles, and install all the things.
// By the time this file is run, shelljs has been loaded into global scope and
// `resolve` is available for bash-style ~ handling.

// Bash
ln('-sf', compile('bash/.bashrc'), resolve('~/.bashrc'))

// Git
ln('-sf', compile('git/.gitconfig'), resolve('~/.gitconfig'))
ln('-sf', compile('git/.gitignore_global'), resolve('~/.gitignore_global'))

// SSH
ln('-sf', compile('ssh/config'), resolve('~/.ssh/config'))

// Vim
ln('-sf', compile('vim/.vimrc'), resolve('~/.vimrc'))
