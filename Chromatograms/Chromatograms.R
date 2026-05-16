library(ggplot2)
library(png)
library(grid)
library(hexSticker)

#' @param x x offset of the hexagon's center
#'
#' @param y y offset of the hexagon's center
#'
#' @param radius the radius (side length) of the hexagon.
#'
#' @param from_radius from where should the segment be drawn? defaults to the center
#'
#' @param to_radius to where should the segment be drawn? defaults to the radius
#'
#' @param from_angle from which angle should we draw?
#'
#' @param to_angle to which angle should we draw?
#'
#' @param fill fill color
#'
#' @param color line color
#'
#' @param size size of the line?
hex_segment2 <- function(x = 1, y = 1, radius = 1, from_radius = 0,
                         to_radius = radius, from_angle = 30, to_angle = 90,
                         fill = NA, color = NA, size = 1.2) {
    from_angle <- from_angle * pi / 180
    to_angle <- to_angle * pi / 180
    coords <- data.frame(x = x + c(from_radius * cos(from_angle),
                                   to_radius * cos(from_angle),
                                   to_radius * cos(to_angle),
                                   from_radius * cos(to_angle)),
                         y = y + c(from_radius * sin(from_angle),
                                   to_radius * sin(from_angle),
                                   to_radius * sin(to_angle),
                                   from_radius * sin(to_angle))
                         )
    geom_polygon(aes(x = coords$x, y = coords$y), data = coords,
                 fill = fill, color = color, size = size)
}

img <- readPNG("images/Chromatograms-hero.png")
img <- rasterGrob(img, width = 1.6, x = 0.5, y = 0.6,
                       interpolate = TRUE)

## Manually define...
col_blue = "#246abe"
col_grey = "#95959c"
col_grey2 = "#838289" # The color after Gimp converting the color scheme
col_purple = "#9200fc"
col_orange = "#f4810b"
col_yellow = "#fef14e"
col_white = "#ffffff"


## Rainbow sticker

## Rainbow color
red <- "#ff0000"
orange <- "#ffa52c"
yellow <- "#ead018"
green <- "#007e15"
blue <- "#0505f9"
purple <- "#86007d"

col_text = "#2e3131"

hex <- ggplot() +
    geom_hexagon(size = 1.2, fill = "#ffffff", color = NA) +
    ## Top right; first area then border.
    hex_segment2(size = 0, fill = paste0(red, 80),
                 from_radius = 0, to_radius = 0.17,
                 from_angle = 30, to_angle = 90) +
    hex_segment2(size = 0, fill = paste0(orange, 80),
                 from_radius = 0.17, to_radius = 0.33,
                 from_angle = 30, to_angle = 90) +
    hex_segment2(size = 0, fill = paste0(yellow, 80),
                 from_radius = 0.33, to_radius = 0.5,
                 from_angle = 30, to_angle = 90) +
    hex_segment2(size = 0, fill = paste0(green, 80),
                 from_radius = 0.5, to_radius = 0.66,
                 from_angle = 30, to_angle = 90) +
    hex_segment2(size = 0, fill = paste0(blue, 80),
                 from_radius = 0.66, to_radius = 0.83,
                 from_angle = 30, to_angle = 90) +
    hex_segment2(size = 0, fill = paste0(purple, 80),
                 from_radius = 0.83, to_radius = 1,
                 from_angle = 30, to_angle = 90) +
    ## Right
    hex_segment2(size = 0, fill = paste0(red, 40),
                 from_radius = 0, to_radius = 0.17,
                 from_angle = 330, to_angle = 30) +
    hex_segment2(size = 0, fill = paste0(orange, 40),
                 from_radius = 0.17, to_radius = 0.33,
                 from_angle = 330, to_angle = 30) +
    hex_segment2(size = 0, fill = paste0(yellow, 40),
                 from_radius = 0.33, to_radius = 0.5,
                 from_angle = 330, to_angle = 30) +
    hex_segment2(size = 0, fill = paste0(green, 40),
                 from_radius = 0.5, to_radius = 0.66,
                 from_angle = 330, to_angle = 30) +
    hex_segment2(size = 0, fill = paste0(blue, 40),
                 from_radius = 0.66, to_radius = 0.83,
                 from_angle = 330, to_angle = 30) +
    hex_segment2(size = 0, fill = paste0(purple, 40),
                 from_radius = 0.83, to_radius = 1,
                 from_angle = 330, to_angle = 30) +
    ## Bottom right 270 330
    hex_segment2(size = 0, fill = paste0(red, 40),
                 from_radius = 0, to_radius = 0.17,
                 from_angle = 270, to_angle = 330) +
    hex_segment2(size = 0, fill = paste0(orange, 40),
                 from_radius = 0.17, to_radius = 0.33,
                 from_angle = 270, to_angle = 330) +
    hex_segment2(size = 0, fill = paste0(yellow, 40),
                 from_radius = 0.33, to_radius = 0.5,
                 from_angle = 270, to_angle = 330) +
    hex_segment2(size = 0, fill = paste0(green, 40),
                 from_radius = 0.5, to_radius = 0.66,
                 from_angle = 270, to_angle = 330) +
    hex_segment2(size = 0, fill = paste0(blue, 40),
                 from_radius = 0.66, to_radius = 0.83,
                 from_angle = 270, to_angle = 330) +
    hex_segment2(size = 0, fill = paste0(purple, 40),
                 from_radius = 0.83, to_radius = 1,
                 from_angle = 270, to_angle = 330) +
    ## Bottom left 210 270
    hex_segment2(size = 0, fill = paste0(red, 40),
                 from_radius = 0, to_radius = 0.17,
                 from_angle = 210, to_angle = 270) +
    hex_segment2(size = 0, fill = paste0(orange, 40),
                 from_radius = 0.17, to_radius = 0.33,
                 from_angle = 210, to_angle = 270) +
    hex_segment2(size = 0, fill = paste0(yellow, 40),
                 from_radius = 0.33, to_radius = 0.5,
                 from_angle = 210, to_angle = 270) +
    hex_segment2(size = 0, fill = paste0(green, 40),
                 from_radius = 0.5, to_radius = 0.66,
                 from_angle = 210, to_angle = 270) +
    hex_segment2(size = 0, fill = paste0(blue, 40),
                 from_radius = 0.66, to_radius = 0.83,
                 from_angle = 210, to_angle = 270) +
    hex_segment2(size = 0, fill = paste0(purple, 40),
                 from_radius = 0.83, to_radius = 1,
                 from_angle = 210, to_angle = 270) +
    ## Left 150 210
    hex_segment2(size = 0, fill = paste0(red, 40),
                 from_radius = 0, to_radius = 0.17,
                 from_angle = 150, to_angle = 210) +
    hex_segment2(size = 0, fill = paste0(orange, 40),
                 from_radius = 0.17, to_radius = 0.33,
                 from_angle = 150, to_angle = 210) +
    hex_segment2(size = 0, fill = paste0(yellow, 40),
                 from_radius = 0.33, to_radius = 0.5,
                 from_angle = 150, to_angle = 210) +
    hex_segment2(size = 0, fill = paste0(green, 40),
                 from_radius = 0.5, to_radius = 0.66,
                 from_angle = 150, to_angle = 210) +
    hex_segment2(size = 0, fill = paste0(blue, 40),
                 from_radius = 0.66, to_radius = 0.83,
                 from_angle = 150, to_angle = 210) +
    hex_segment2(size = 0, fill = paste0(purple, 40),
                 from_radius = 0.83, to_radius = 1,
                 from_angle = 150, to_angle = 210) +
    ## Top left 90 150
    hex_segment2(size = 0, fill = paste0(red, 40),
                 from_radius = 0, to_radius = 0.17,
                 from_angle = 90, to_angle = 150) +
    hex_segment2(size = 0, fill = paste0(orange, 40),
                 from_radius = 0.17, to_radius = 0.33,
                 from_angle = 90, to_angle = 150) +
    hex_segment2(size = 0, fill = paste0(yellow, 40),
                 from_radius = 0.33, to_radius = 0.5,
                 from_angle = 90, to_angle = 150) +
    hex_segment2(size = 0, fill = paste0(green, 40),
                 from_radius = 0.5, to_radius = 0.66,
                 from_angle = 90, to_angle = 150) +
    hex_segment2(size = 0, fill = paste0(blue, 40),
                 from_radius = 0.66, to_radius = 0.83,
                 from_angle = 90, to_angle = 150) +
    hex_segment2(size = 0, fill = paste0(purple, 40),
                 from_radius = 0.83, to_radius = 1,
                 from_angle = 90, to_angle = 150) +
    ## Image
    geom_subview(subview = img, x = 0.98, y = 0.65,
                 width = 1.15, height = 1.25) +
    ## font size for linux: 6.5, macOS
    geom_url("www.bioconductor.org", x = 1.02, y = 0.15,
             color = col_text, size = 6) + 
    geom_pkgname("Chromatograms", y = 1.35, size = 18,
                 color = col_text, family = "Aller") + 
    theme_sticker()
save_sticker(filename = "Chromatograms.png", hex, dpi = 300)
