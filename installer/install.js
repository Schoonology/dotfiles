// Link all the dotfiles, and install all the things.
// By the time this file is run, shelljs has been loaded into global scope and
// `resolve` is available for bash-style ~ handling.

// Bash
ln('-sf', 'bash/.bashrc', resolve('~/.bashrc'))

// Git
ln('-sf', 'git/.gitconfig', resolve('~/.gitconfig'))
ln('-sf', 'git/.gitignore_global', resolve('~/.gitignore_global'))

// SSH
ln('-sf', 'ssh/config', resolve('~/.ssh/config'))

// Vim
ln('-sf', 'vim/.vimrc', resolve('~/.vimrc'))
