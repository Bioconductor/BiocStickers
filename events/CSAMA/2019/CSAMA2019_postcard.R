library(ggplot2)
library(png)
library(grid)
library(hexSticker)

## Settings:
## Bioconductor blue: #3792AD
## Bioconductor green: #8ACA25
## Grey: #696E76

img <- readPNG("./images/postcard.png")
img <- rasterGrob(img, width = 1.0, x = 0.5, y = 0.6,
                  interpolate = TRUE)
gg <- ggplot() +
    annotation_custom(img) +
    theme_void()

col_text <- "#000000"    ## white
col_border <- "#3792AD"  ## BioC blue
col_bg <- "#dfdfe2"
sticker(gg,
        package="CSAMA2019",
        p_size = 7.3,
        s_x = 1,
        s_y = 0.67,
        s_width = 1.7,
        s_height = 1.5,
        h_fill = col_bg,
        h_color = col_border,
        p_family = "Aller_Lt",
        filename="CSAMA2019.png",
        spotlight = FALSE,
        l_x = 1.02, p_color = col_text,
        url = "www.bioconductor.org",
        u_color = col_border
        )

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
col_grey <- "#5a5b5d"
hex <- ggplot() +
    geom_hexagon(size = 1.2, fill = col_bg, color = NA) +
    hex_segment2(size = 0, fill = paste0(col_grey, 80),
                 from_radius = 0, to_radius = 1,
                 from_angle = 210, to_angle = 270) +
    hex_segment2(size = 0, fill = paste0(col_grey, 80),
                 from_radius = 0, to_radius = 1,
                 from_angle = 270, to_angle = 330) +
    hex_segment2(size = 0, fill = paste0(col_grey, 40),
                 from_radius = 0, to_radius = 1,
                 from_angle = 330, to_angle = 30) +
    hex_segment2(size = 0, fill = paste0(col_grey, 10),
                 from_radius = 0, to_radius = 1,
                 from_angle = 30, to_angle = 90) +
    hex_segment2(size = 0, fill = paste0(col_grey, 10),
                 from_radius = 0, to_radius = 1,
                 from_angle = 90, to_angle = 150) +
    hex_segment2(size = 0, fill = paste0(col_grey, 40),
                 from_radius = 0, to_radius = 1,
                 from_angle = 150, to_angle = 210) +
    geom_hexagon(size = 1.2, fill = NA, color = col_border) +
    geom_subview(subview = img, x = 1, y = 0.65,
                 width = 1.7, height = 1.7) +
    geom_url("www.bioconductor.org", color = col_border) +
    geom_pkgname("CSAMA2019", size = 7.3,
                 color = col_text, family = "Aller_Lt") + 
    theme_sticker()
save_sticker(filename = "CSAMA2019-bg.png", hex)
