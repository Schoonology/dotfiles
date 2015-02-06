// Link all the dotfiles, and install all the things.
var path = require('path')
  , sh = require('shelljs')

// Handle ~ as Bash does.
function aTarget(file) {
  return path.normalize(file.replace(/~/g, process.env.HOME))
}

// Absolute source file paths.
function aSource(file) {
  return path.resolve(__dirname, '..', file)
}

// HOME-relative source file paths
function rSource(file) {
  return path.relative(process.env.HOME, aSource(file))
}

// CWD-relative source file paths
function lSource(file) {
  return path.relative(process.cwd(), aSource(file))
}

// Detects the complete list of file paths that should be included or linked.
function detectSources(file) {
  var sources = []

  if (sh.test('-f', aSource(file))) {
    sources.push(file)
  }

  if (sh.test('-f', aSource(file + '_' + process.platform))) {
    sources.push(file + '_' + process.platform)
  }

  return sources
}

// Bash
sh.rm('-f', aTarget('~/.bashrc'))
detectSources('bash/.bashrc')
  .reduce(function (str, file) {
    return str + 'source ~/' + rSource(file) + '\n'
  }, '')
  .to(aTarget('~/.bashrc'))

// Git
sh.rm('-f', aTarget('~/.gitconfig'))
detectSources('git/.gitconfig')
  .reduce(function (str, file) {
    return str + '[include]\n  path = ' + rSource(file) + '\n'
  }, '')
  .to(aTarget('~/.gitconfig'))
sh.ln('-sf', lSource('git/.gitignore_global'), aTarget('~/.gitignore_global'))

// SSH
sh.mkdir('-p', aTarget('~/.ssh'))
sh.ln('-sf', lSource('ssh/config'), aTarget('~/.ssh/config'))

// Vim
sh.rm('-f', aTarget('~/.vimrc'))
detectSources('vim/.vimrc')
  .reduce(function (str, file) {
    return str + 'source ~/' + rSource(file) + '\n'
  }, '')
  .to(aTarget('~/.vimrc'))
