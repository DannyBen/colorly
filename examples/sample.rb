# Set a note caption for this color strip
note "One"

# Add any color (string or chroma)
add 'red'
add '#00ff00'

# Key chroma methods work directly on strings
add '#00ff00'.spin 60
add '#00ff00'.lighten 30

# Start a new strip with a new note
note "Two"

# The variable `last` stores the last color
add 'red'
add last.spin 60
add last.spin 60

# Methods can be chained
add last.spin(60).darken(30).desaturate(10)

# Available methods are
note "Available methods"
add 'lime'
add last.lighten 20
add last.darken 20
add last.desaturate 50
add last.saturate 50
add last.spin 30
