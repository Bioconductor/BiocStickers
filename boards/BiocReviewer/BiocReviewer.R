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

img <- readPNG("drawings/BiocReview.png")
img <- rasterGrob(img, width = 1.2, x = 0.5, y = 0.5,
                       interpolate = TRUE)

col_bg <- "#2978ad"
col_moon <- "#fefad4"
col_star <- "#fef58e"
col_witch <- "#ffffcc"
col_cream <- "#ffffcc"
col_jellybean <- "#2574a9"
col_summersky <- "#1e8bc3"
col_darkbrown <- "#a7670f"
col_lightbrown <- "#e29d3c"
col_bioc_blue <- "#3e90a8"

## colored beams.
hex <- ggplot() +
    geom_hexagon(size = 1.0, fill = col_moon, color = NA) +
    ## Darker blue
    hex_segment2(size = 0, fill = col_witch,
                 from_radius = 0, to_radius = 1,
                 from_angle = 330, to_angle = 30) +
    hex_segment2(size = 0, fill = col_witch,
                 from_radius = 0, to_radius = 1,
                 from_angle = 270, to_angle = 330) +

    hex_segment2(size = 0, fill = col_darkbrown,
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 330, to_angle = 30) + # right.
    hex_segment2(size = 0, fill = col_lightbrown,
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 30, to_angle = 90) + # right top
    hex_segment2(size = 0, fill = col_lightbrown,
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 90, to_angle = 150) + # left top
    hex_segment2(size = 0, fill = col_lightbrown,
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 150, to_angle = 210) + # left.
    hex_segment2(size = 0, fill = col_lightbrown,
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 210, to_angle = 270) + # left bottom
    hex_segment2(size = 0, fill = col_darkbrown,
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 270, to_angle = 330) + # right bottom.
    geom_subview(subview = img, x = 0.97, y = 1.07,
                 width = 1.2, height = 1.2) +
    ## font size for linux: 6.5, macOS
    geom_url("reviewer", x = 1.0, y = 0.21,
             color = col_bioc_blue, size = 17, angle = 30) + 
    ## geom_url("reviewer", x = 0.76, y = 0.47,
    ##          color = col_bioc_blue, size = 15, angle = 0) + 
    geom_url("www.bioconductor.org", x = 0.26, y = 1.41,
             color = col_bioc_blue, size = 6.5) + 
    theme_sticker()
save_sticker(filename = "BiocReviewer.png", hex)


## ## inclusive colors
## col_1 <- "#faf9f5"
## col_2 <- "#ffafc8"
## col_3 <- "#74d7ec"
## col_4 <- "#603814"
## col_5 <- "#000000"
## col_6 <- "#d40606"
## col_7 <- "#ef9c00"
## col_8 <- "#e4ff00"
## col_9 <- "#06bf01"
## col_10 <- "#011a98"
## col_11 <- "#76008a"
## col_inc <- c(col_1, col_2, col_3, col_4, col_5, col_6, col_7, col_8, col_9,
##              col_10, col_11)

## img <- readPNG("drawings3/EuroBioc-drawing.png")
## img <- rasterGrob(img, width = 1.6, x = 0.5, y = 0.5,
##                        interpolate = TRUE)

## col_bg <- "#2978ad"
## col_moon <- "#fefad4"
## col_star <- "#fef58e"
## col_witch <- "#fff68f"
## col_cream <- "#ffffcc"
## col_ripe_lemon <- "#f7ca18"
## col_iron <- "#dadfe1"
## col_white_smoke <- "#ececec"
## col_bg <- col_white_smoke

## hex <- ggplot() +
##     geom_hexagon(size = 1.2, fill = col_bg, color = NA) +
##     ## Darker blue
##     hex_segment2(size = 0, fill = col_iron,
##                  from_radius = 0, to_radius = 1,
##                  from_angle = 330, to_angle = 30) +
##     hex_segment2(size = 0, fill = col_iron,
##                  from_radius = 0, to_radius = 1,
##                  from_angle = 30, to_angle = 90) +
##     hex_segment2(size = 0, fill = col_iron,
##                  from_radius = 0, to_radius = 1,
##                  from_angle = 90, to_angle = 150) +

##     hex_segment2(size = 0, fill = col_ripe_lemon,
##                  from_radius = 0.9, to_radius = 1,
##                  from_angle = 330, to_angle = 30) +
##     hex_segment2(size = 0, fill = col_ripe_lemon,
##                  from_radius = 0.9, to_radius = 1,
##                  from_angle = 30, to_angle = 90) +
##     hex_segment2(size = 0, fill = col_ripe_lemon,
##                  from_radius = 0.9, to_radius = 1,
##                  from_angle = 90, to_angle = 150) +
##     hex_segment2(size = 0, fill = col_star,
##                  from_radius = 0.9, to_radius = 1,
##                  from_angle = 150, to_angle = 210) +
##     hex_segment2(size = 0, fill = col_star,
##                  from_radius = 0.9, to_radius = 1,
##                  from_angle = 210, to_angle = 270) +
##     hex_segment2(size = 0, fill = col_star,
##                  from_radius = 0.9, to_radius = 1,
##                  from_angle = 270, to_angle = 330) +
    
##     geom_subview(subview = img, x = 1.0, y = 1,
##                  width = 0.95, height = 0.95) +
##     ## font size for linux: 6.5, macOS
##     geom_url("www.bioconductor.eu", x = 1.05, y = 0.08,
##              color = col_jellybean, size = 2.1) + 
##     theme_sticker()
## save_sticker(filename = "EuroBioC-v4.png", hex)

