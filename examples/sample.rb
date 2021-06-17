# Start a new color set
title "One"

# Add any color (string or chroma)
add 'red'
add '#00ff00'

# Selected chroma methods work directly on strings
add '#00ff00'.spin 60
add '#00ff00'.lighten 30

# Start a new strip with a new title
title "Two"

# The variable `last` stores the last color
add 'red'
add last.spin 60
add last.spin 60

# Methods can be chained
add last.spin(60).darken(30).desaturate(10)

# Available methods (forwarded as is to chroma)
title "Available methods"
add 'lime'
add last.lighten 20
add last.darken 20
add last.desaturate 50
add last.saturate 50
add last.spin 30
# add last.palette ... for generating arrays, see below

# You can use arrays and other Ruby code
title "Arrays"
add ['red', 'blue']
3.times { add last.spin 30 }

# You can use chroma palettes
title "Chroma palettes"
add 'orange'.spin 10
add last.palette.triad
add 'red'.palette.split_complement

# Random color
title "Random"
add random
3.times { add last.spin 60 }
