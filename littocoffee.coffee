fs = require 'fs'
Lazy = require 'lazy'
argv = (require 'optimist').argv

baseName = (str) ->
  base = new String(str).substring(str.lastIndexOf("/") + 1)
  base = base.substring(0, base.lastIndexOf(".")) unless base.lastIndexOf(".") is -1
  return base

removeExtension = (filename) ->
  i = filename.lastIndexOf '.'
  return if i < 0 then '' else filename.substring(0, i)

for filename in argv._

  skipNewLine = true
  file = ''
  fs.writeFileSync "#{removeExtension filename}.coffee", file
  new Lazy(fs.createReadStream filename, encoding: 'utf8')
    .lines
    .forEach (line) ->
      line = String(line)

      if line.indexOf('    ') == 0 or line.indexOf('\t') == 0
        fs.appendFileSync "#{removeExtension filename}.coffee", line.substring(4) + '\n'
        skipNewLine = false

      else
        unless skipNewLine
          fs.appendFileSync "#{removeExtension filename}.coffee", '\n'
        skipNewLine = true
