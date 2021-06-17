# This script demonstrates most functions of the Colorly DSL
# Run it with `colorly example.rb out.html`

# Start a new color set by calling title
title "Sample set"

# Add any color (stirng or a Chroma::Color)
add 'red'
add '#00ff00'
add 'rgb(0, 0, 255)'

# Selected Chroma methods work directly on strings
title "Chroma methods (lightness, saturation, hue)"
add '#00ff00'
add '#00ff00'.spin 60
add '#00ff00'.lighten 30
add '#00ff00'.darken 30
add '#00ff00'.saturate 30
add '#00ff00'.desaturate 30

# The variable `last` stores the last color
title "Make variations on the last used color"
add 'red'.lighten(10).spin(10)
add last.spin 60
add last.spin 60
add last.spin 60
add last.spin 60
add last.spin 60
add last.lighten 10
add last.lighten 10
add last.lighten 10

# Methods can be chained
title "Method chaining"
add 'aqua'
add last.spin(10).darken(5).desaturate(14)
add last.spin(10).darken(5).desaturate(14)
add last.spin(10).darken(5).desaturate(14)

# Available methods (forwarded as is to chroma)
title "Available color methods"
add 'lime'
add last.brighten 20
add last.lighten 20
add last.darken 20
add last.desaturate 50
add last.saturate 50
add last.spin 30
add last.greyscale
# add last.palette ... for generating arrays, see below

# You can add colors using arrays, and use other Ruby code.
title "Arrays"
add ['red', 'aqua']
3.times { add last.desaturate(10).darken(5) }

# You can use chroma palettes (see: https://github.com/jfairbank/chroma#generating-palettes)
title "Chroma palettes"
add 'orange'.spin 10
add last.palette.triad
add 'white'
add 'red'.palette.split_complement
add 'white'
add 'orange'.palette.analogous size: 3, slice_by: 10

# Random color
title "Random"
add random
3.times { add last.spin 60 }
