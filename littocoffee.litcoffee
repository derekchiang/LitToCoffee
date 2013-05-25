# LitToCoffee

LitToCoffee is a simple source-to-source compiler from Literate CoffeeScript to CoffeeScript.

## Dependencies

    fs = require 'fs'
    Lazy = require 'lazy'
    argv = (require 'optimist').argv

## Helper Functions

A function that removes extension from a filename

    removeExtension = (filename) ->
      i = filename.lastIndexOf '.'
      return if i < 0 then '' else filename.substring(0, i)

## Body

The main loop:

    for filename in argv._

File IO:

      skipNewLine = true
      file = ''
      fs.writeFileSync "#{removeExtension filename}.coffee", file
      new Lazy(fs.createReadStream filename, encoding: 'utf8')
        .lines
        .forEach (line) ->
          line = String(line)

If a line starts with four white spaces or a tab, it's considered code.

          if line.indexOf('    ') == 0 or line.indexOf('\t') == 0
            fs.appendFileSync "#{removeExtension filename}.coffee", line.substring(4) + '\n'
            skipNewLine = false

Otherwise it's comments, in which case we output a newline.  We also have a switch `skipNewLine` so that we don't write consecutive newlines.

          else
            unless skipNewLine
              fs.appendFileSync "#{removeExtension filename}.coffee", '\n'
            skipNewLine = true
