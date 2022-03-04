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

img <- readPNG("drawings/EuroBioc-drawing.png")
img <- rasterGrob(img, width = 1.6, x = 0.5, y = 0.5,
                       interpolate = TRUE)

col_bg <- "#2978ad"
col_moon <- "#fefad4"
col_star <- "#fef58e"
col_witch <- "#fff68f"
col_cream <- "#ffffcc"
col_ripe_lemon <- "#f7ca18"
col_iron <- "#dadfe1"
col_white_smoke <- "#ececec"
col_bg <- col_white_smoke
col_jellybean <- "#2574a9"

hex <- ggplot() +
    geom_hexagon(size = 1.2, fill = col_bg, color = NA) +
    hex_segment2(size = 0, fill = col_iron,
                 from_radius = 0, to_radius = 1,
                 from_angle = 330, to_angle = 30) +
    hex_segment2(size = 0, fill = col_iron,
                 from_radius = 0, to_radius = 1,
                 from_angle = 30, to_angle = 90) +
    hex_segment2(size = 0, fill = col_iron,
                 from_radius = 0, to_radius = 1,
                 from_angle = 90, to_angle = 150) +

    hex_segment2(size = 0, fill = col_ripe_lemon,
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 330, to_angle = 30) +
    hex_segment2(size = 0, fill = col_ripe_lemon,
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 30, to_angle = 90) +
    hex_segment2(size = 0, fill = col_ripe_lemon,
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 90, to_angle = 150) +
    hex_segment2(size = 0, fill = col_star,
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 150, to_angle = 210) +
    hex_segment2(size = 0, fill = col_star,
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 210, to_angle = 270) +
    hex_segment2(size = 0, fill = col_star,
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 270, to_angle = 330) +
    
    geom_subview(subview = img, x = 1.0, y = 1,
                 width = 0.95, height = 0.95) +
    ## font size for linux: 6.5, macOS
    geom_url("www.bioconductor.eu", x = 1.05, y = 0.08,
             color = col_jellybean, size = 2.1) + 
    theme_sticker()
save_sticker(filename = "EuroBioC.png", hex)

