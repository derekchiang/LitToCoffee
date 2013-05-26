# LitToCoffee

A simple source-to-source compiler from Literate CoffeeScript to CoffeeScript.

The code itself is written in Literate CoffeeScript, and the compiled source can also be found in the base directory.

## Usage

	coffee littocoffee.litcoffee [Your Files]

For example:

	coffee littocoffee.litcoffee littocoffee.litcoffee

This will output the file `littocoffee.coffee` in the current directory.
