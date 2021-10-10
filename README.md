# Colorly - Command Line Color Palette Generator

[![Gem Version](https://badge.fury.io/rb/colorly.svg)](https://badge.fury.io/rb/colorly)
[![Build Status](https://github.com/DannyBen/colorly/workflows/Test/badge.svg)](https://github.com/DannyBen/colorly/actions?query=workflow%3ATest)
[![Maintainability](https://api.codeclimate.com/v1/badges/a708b1651a6caf451d53/maintainability)](https://codeclimate.com/github/DannyBen/colorly/maintainability)

---

Colorly is a command line utility and a Ruby library for generating color
palettes using a simple DSL.

It is a thin wrapper around the [chroma] gem.

The colorly command line outputs the palette as JSON, YAML or HTML.

---

## Install

```
$ gem install colorly
```

## Example

Colorly provides you with a simple ruby-based DSL for generating a color palette.

Start by creating this file:

```ruby
# sample.rb
title "Set 1"
add 'red'.lighten 20
add last.spin 60
add last.spin 60
```

then run it by calling:

```
$ colorly sample.rb output.html
```

output:

![](assets/readme-sample-1.png)

For more detailed examples, view the [examples folder](examples).


## Usage 

Colorly scripts are built with a minimalist set of Ruby commands (DSL):

```ruby
# Start a new color set
title "Any unique name for this set"

# Add colors to this set
add 'yellow'.darken(10).desaturate(10)
add last.spin 20

# Start another set
title "New set"
add '#ff3344'
# ...
```

The colors provided to the `add` command can be
[anything that is supported by `Chroma`](https://github.com/jfairbank/chroma#creating-colors),
or an array of the same.

In addition, you can call the below `Chroma` methods directly on any color.
They will be forwarded to `Chroma`:

```ruby
'red'.spin        # same as 'red'.paint.spin
'red'.brighten    # same as 'red'.paint.brighten
'red'.darken      # same as 'red'.paint.darken 
'red'.lighten     # same as 'red'.paint.lighten 
'red'.saturate    # same as 'red'.paint.saturate 
'red'.desaturate  # same as 'red'.paint.desaturate 
'red'.greyscale   # same as 'red'.paint.greyscale (also grayscale)
'red'.palette     # same as 'red'.paint.palette
```

You can use the last added color with the variable `last`, and generate a
random color by calling `random`:

```ruby
title "Example"
add 'red'.spin 10
add last.spin 30
add last.spin 30
add random.desaturate 10
```

## Using from Ruby code

If you wish to use Colorly from your own Ruby code, simply load a script to 
the Script class:

```ruby
require 'colorly'

# Load from a file
script = Colorly::Script.load 'script_file.rb'

# ... or from a string
script_string = "title 'Hello'; add params[:base_color] ; add last.spin 90"
script = Colorly::Script.new script_string

# Optionally, pass parameters to the script, which you can use in the script
# by accessing the `params` hash.
script.params = { base_color: '#cdc' }
# or
script.params[:base_color] = '#cdc'

# Run it
script.run

# Get its output - each color is a Chroma::Color object
p script.output
p script.output["Hello"].first.class
#=> {"Hello"=>[#ff2b00, #ff5500]}
#=> Chroma::Color

# Get a simplified output where each color is just its hex string
p script.simple_output
#=> {"Hello"=>["#ff2b00", "#ff5500"]}

# Get a simplified output, including color names (slower)
# Get a simplified output, including color names (slower)
pp script.simple_output names: true
#=> {"Hello"=>
#=>   [{:hex=>"#ff2b00", :name=>["Scarlet", "Red"]},
#=>    {:hex=>"#ff5500", :name=>["International Orange", "Orange"]}]}
```

## Contributing / Support

If you experience any issue, have a question or a suggestion, or if you wish
to contribute, feel free to [open an issue][issues].

## Credits

- [Jeremy Fairbank](https://github.com/jfairbank) for the [chroma] gem.
- [Chirag Mehta](https://chir.ag/) for the original Javascript [color naming functions](https://chir.ag/projects/name-that-color).
- [Colblindor](https://www.color-blindness.com/color-name-hue/) for the additional base color (shade) work.



---

[chroma]: https://github.com/jfairbank/chroma
[issues]: https://github.com/DannyBen/colorly/issues