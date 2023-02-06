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

col_border <- "#303030"
## col_border_low <- col_grey2
img <- readPNG("./drawings/graslei.png")
img <- rasterGrob(img, width = 1.5, x = 0.5, y = 0.5,
                  interpolate = TRUE)
hex <- ggplot() +
    geom_hexagon(size = 1.2, fill = "#ffffff", color = NA) +  # full
    hex_segment2(size = 0, fill = col_border, # right upper
                 from_radius = 0.94, to_radius = 1,
                 from_angle = 330, to_angle = 30) +
    hex_segment2(size = 0, fill = col_border,
                 from_radius = 0.94, to_radius = 1,
                 from_angle = 30, to_angle = 90) +
    hex_segment2(size = 0, fill = col_border,
                 from_radius = 0.94, to_radius = 1,
                 from_angle = 90, to_angle = 150) +
    hex_segment2(size = 0, fill = col_border,
                 from_radius = 0.94, to_radius = 1,
                 from_angle = 150, to_angle = 210) +
    hex_segment2(size = 0, fill = col_border,
                 from_radius = 0.94, to_radius = 1,
                 from_angle = 210, to_angle = 270) +
    hex_segment2(size = 0, fill = col_border,
                 from_radius = 0.94, to_radius = 1,
                 from_angle = 270, to_angle = 330) +
    geom_subview(subview = img, x = 1, y = 1.0,
                 width = 1.09, height = 1.09) +
    geom_url(url = "www.bioconductor.org", size = 6, color = col_border,
             x = 1, y = 1.9, angle = -30) +
    theme_sticker()
save_sticker("EuroBioC2023.png", hex, dpi = 300)

## Rainbow sticker
red <- "#ff0000"
orange <- "#ffa52c"
yellow <- "#ead018"
green <- "#007e15"
blue <- "#0505f9"
purple <- "#86007d"

hex <- ggplot() +
    geom_hexagon(size = 1.2, fill = "#ffffff", color = NA) +  # full
    hex_segment2(size = 0, fill = purple, # right upper
                 from_radius = 0.94, to_radius = 1,
                 from_angle = 330, to_angle = 30) +
    hex_segment2(size = 0, fill = blue,
                 from_radius = 0.94, to_radius = 1,
                 from_angle = 30, to_angle = 90) +
    hex_segment2(size = 0, fill = green,
                 from_radius = 0.94, to_radius = 1,
                 from_angle = 90, to_angle = 150) +
    hex_segment2(size = 0, fill = yellow,
                 from_radius = 0.94, to_radius = 1,
                 from_angle = 150, to_angle = 210) +
    hex_segment2(size = 0, fill = orange,
                 from_radius = 0.94, to_radius = 1,
                 from_angle = 210, to_angle = 270) +
    hex_segment2(size = 0, fill = red,
                 from_radius = 0.94, to_radius = 1,
                 from_angle = 270, to_angle = 330) +
    geom_subview(subview = img, x = 1, y = 1.0,
                 width = 1.09, height = 1.09) +
    geom_url(url = "www.bioconductor.org", size = 6, color = col_border,
             x = 1, y = 1.9, angle = -30) +
    theme_sticker()
save_sticker("EuroBioC2023-a.png", hex, dpi = 300)


lb <- "#5bcefa"
lr <- "#f5a9b8"
lg <- "#d9d9d9"

hex <- ggplot() +
    geom_hexagon(size = 1.2, fill = "#ffffff", color = NA) +  # full
    hex_segment2(size = 0, fill = lb, # right upper
                 from_radius = 0.94, to_radius = 1,
                 from_angle = 330, to_angle = 30) +
    hex_segment2(size = 0, fill = lr,
                 from_radius = 0.94, to_radius = 1,
                 from_angle = 30, to_angle = 90) +
    hex_segment2(size = 0, fill = lg,
                 from_radius = 0.94, to_radius = 1,
                 from_angle = 90, to_angle = 150) +
    hex_segment2(size = 0, fill = lb,
                 from_radius = 0.94, to_radius = 1,
                 from_angle = 150, to_angle = 210) +
    hex_segment2(size = 0, fill = lr,
                 from_radius = 0.94, to_radius = 1,
                 from_angle = 210, to_angle = 270) +
    hex_segment2(size = 0, fill = lg,
                 from_radius = 0.94, to_radius = 1,
                 from_angle = 270, to_angle = 330) +
    geom_subview(subview = img, x = 1, y = 1.0,
                 width = 1.09, height = 1.09) +
    geom_url(url = "www.bioconductor.org", size = 6, color = col_border,
             x = 1, y = 1.9, angle = -30) +
    theme_sticker()
save_sticker("EuroBioC2023-b.png", hex, dpi = 300)
