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
    geom_polygon(aes_(x = ~x, y = ~y), data = coords,
                 fill = fill, color = color, size = size)
}

img <- readPNG("images/MsCoreUtils-drawing.png")
img <- rasterGrob(img, width = 1.4, x = 0.5, y = 0.6,
                       interpolate = TRUE)

## Manually define...
col_blue = "#246abe"
col_grey = "#95959c"
col_grey = "#838289" # The color after Gimp converting the color scheme
col_purple = "#9200fc"
col_orange = "#f4810b"
col_yellow = "#fef14e"
col_white = "#ffffff"

## colored beams.
hex <- ggplot() +
    geom_hexagon(size = 1.2, fill = col_white, color = NA) +
    hex_segment2(size = 0, fill = paste0(col_blue, 60),
                 from_radius = 0, to_radius = 1,
                 from_angle = 150, to_angle = 210) +
    geom_polygon(data = data.frame(x = c(1, 1 + sqrt(3)/2, 1 + sqrt(3)/3),
                                   y = c(1, 1.5, 1.5 + 1/6)),
                 aes(x = x, y = y),
                 fill = paste0(col_yellow, 40)) +
    geom_polygon(data = data.frame(x = c(1, 1 + sqrt(3)/3, 1 + sqrt(3)/6),
                                   y = c(1, 1.5 + 1/6, 1.5 + 1/3)),
                 aes(x = x, y = y),
                 fill = paste0(col_orange, 40)) +
    geom_polygon(data = data.frame(x = c(1, 1 + sqrt(3)/6, 1),
                                   y = c(1, 1.5 + 1/3, 2)),
                 aes(x = x, y = y),
                 fill = paste0(col_purple, 40)) +
    geom_hexagon(size = 1.2, fill = NA, color = col_grey) +
    geom_subview(subview = img, x = 0.95, y = 0.64,
                 width = 1.0, height = 1.7) +
    geom_url("www.bioconductor.org", color = col_grey, size = 5.5) + 
    geom_pkgname("MsCoreUtils", y = 1.38, size = 23,
                 color = col_grey, family = "Aller") + 
    theme_sticker()
save_sticker(filename = "MsCoreUtils.png", hex)

