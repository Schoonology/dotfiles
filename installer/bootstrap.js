var fs = require('fs')
  , path = require('path')
  , spawn = require('child_process').spawn

// Handle ~ as Bash does.
global.resolve = resolve
function resolve(file) {
  return path.normalize(file.replace(/~/g, process.env.HOME))
}

// Bootstrap shelljs into global scope, installing it first if necessary.
function bootstrap(callback) {
  try {
    require('shelljs/global')
    return callback()
  } catch (e) {}

  spawn('npm', ['install', '--no-bin-links'], {
    cwd: __dirname
  }).on('exit', function () {
    require('shelljs/global')
    return callback()
  })
}

// Compiles all platform-specific files down to a single file,
// ready for installation.
global.compile = compile
function compile(source) {
  var target

  target = path.resolve(process.cwd(), 'compiled', source)
  source = path.resolve(process.cwd(), source)

  mkdir('-p', path.dirname(target))
  cat(source).to(target)

  if (test('-f', source + '_' + process.platform)) {
    cat(source + '_' + process.platform).toEnd(target)
  }

  // Shelljs's `ln -sf` is relative to `process.cwd()`, and this guarantees
  // the links are valid if the world moves.
  return path.relative(process.cwd(), target)
}

// Link all the dotfiles, and install all the things.
function install() {
  require('./install')
}

// Go!
bootstrap(install)
