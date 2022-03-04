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


img <- readPNG("BiocH3Africa2021-drawing-b.png")
img <- rasterGrob(img, width = 1.4, x = 0.5, y = 0.5,
                       interpolate = TRUE)

col_border <- "#241714"                 # dark brown
col_border_2 <- "#241714"                 # dark brown
col_border_1 <- "#321d18"
col_border_0 <- "#40211a"
col_border_5 <- "#fb9622"                     # orange
col_border_4 <- "#f28a12"
col_border_3 <- "#e87f06"
col_bg <- "#EBAE04"
col_bg <- "#EAB44A"
col_bg_light <- "#f5c66b"
col_bg <- "#efbd5d"
## col_bg <- "#f0bb52"

hex <- ggplot() +
    geom_hexagon(size = 1.2, fill = col_bg_light, color = NA) +
    hex_segment2(size = 0, fill = col_bg,
                 from_radius = 0, to_radius = 1,
                 from_angle = 330, to_angle = 30) +
    hex_segment2(size = 0, fill = col_bg,
                 from_radius = 0, to_radius = 1,
                 from_angle = 30, to_angle = 90) +
    hex_segment2(size = 0, fill = col_bg,
                 from_radius = 0, to_radius = 1,
                 from_angle = 90, to_angle = 150) +

    hex_segment2(size = 0, fill = col_border_0,
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 330, to_angle = 30) +
    hex_segment2(size = 0, fill = col_border_1,
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 30, to_angle = 90) +
    hex_segment2(size = 0, fill = col_border_2,
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 90, to_angle = 150) +
    hex_segment2(size = 0, fill = col_border_3,
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 150, to_angle = 210) +
    hex_segment2(size = 0, fill = col_border_4,
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 210, to_angle = 270) +
    hex_segment2(size = 0, fill = col_border_5,
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 270, to_angle = 330) +
    
    geom_subview(subview = img, x = 1.05, y = 0.9,
                 width = 1, height = 1) +
    ## font size for linux: 6.5, macOS
    geom_url("www.bioconductor.org", x = 1.06, y = 0.09,
             color = col_border, size = 2) + 
    geom_url("https://h3africa.org", x = 0.29, y = 1.55,
             color = col_bg, size = 2) + 
    geom_url(url = "2021", x = 0.4, y = 1.43,
             family = "Aller", size = 7, color = col_border, angle = 30) + 
    theme_sticker()
save_sticker(filename = "BiocH3Africa2021b.png", hex)

