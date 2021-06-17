# Colorly - Command Line Color Palette Generator

[![Gem Version](https://badge.fury.io/rb/colorly.svg)](https://badge.fury.io/rb/colorly)
[![Build Status](https://github.com/DannyBen/colorly/workflows/Test/badge.svg)](https://github.com/DannyBen/colorly/actions?query=workflow%3ATest)

---

Colorly is a command line urility and a Ruby library for generating color
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




## Usage 

SOON

## Credits

- [Jeremy Fairbank](https://github.com/jfairbank) for the [chroma] gem.
- [Chirag Mehta](https://chir.ag/) for the original Javascript [color naming functions](https://chir.ag/projects/name-that-color).
- [Colblindor](https://www.color-blindness.com/color-name-hue/) for the additional base color (shade) work.

---

[chroma]: https://github.com/jfairbank/chroma
