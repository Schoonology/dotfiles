var fs = require('fs')
  , path = require('path')
  , exec = require('child_process').exec

// Normalize HOME environment variable.
process.env.HOME = process.env.HOME || process.env.HOMEDRIVE + process.env.HOMEPATH

if (!process.env.HOME) {
  console.error(
    'No HOME environment variables available. Dotfiles cannot be installed.'
  )
  process.exit(1)
}

// Install our dependencies if necessary, calling `callback` upon successful
// completion.
function bootstrap(callback) {
  try {
    require('shelljs')
    return callback()
  } catch (e) {}

  exec('npm install --no-bin-links', {
    cwd: __dirname
  }, function (err) {
    if (err) {
      console.error('Failed to install shelljs.')
      console.error('Error:', err.message)
      process.exit(1)
    }

    require('shelljs')
    return callback()
  })
}

// Go!
bootstrap(function () { require ('./install') })
