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

## Original logo had thinner lines
# img <- readPNG("images/PSMatch-thin.png")
# img <- rasterGrob(img, width = 1.6, x = 0.5, y = 0.6,
#                   interpolate = TRUE)

## Logo with thicker lines
img <- readPNG("./ECR-logo.png")
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

col_text = "#2e3131"
bioc_blue = "#1892AA"

w <- 1.045
h <- 1.615

df <- c(w,h)*1.37

## colored beams.
hex <- ggplot() +
    geom_hexagon(size = 1.2, fill = col_white, color = NA) +
    geom_subview(subview = img, x = 1, y = 0.77,
                 width = df[1], height = df[2]) +
    geom_hexagon(size = 2.3, fill = NA, color = bioc_blue) +
    geom_url("www.bioconductor.org", x = 0.26, y = 1.52,
             color = bioc_blue, size = 6) + 
    theme_sticker()

hex
save_sticker(filename = "studentECR-logo.png", hex, dpi = 300)
