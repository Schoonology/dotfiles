var path = require('path')
  , spawn = require('child_process').spawn

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

// Link all the dotfiles, and install all the things.
function install() {
  require('./install')
}

// Go!
bootstrap(install)
