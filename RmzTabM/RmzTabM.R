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
                         fill = NA, color = NA, linewidth = 1.2) {
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
                 fill = fill, color = color, linewidth = linewidth)
}


img <- readPNG("images/RmzTabM-logo.png")
img <- rasterGrob(img, width = 1.5, x = 0.5, y = 0.5,
                  interpolate = TRUE)

## Manually define...
col_mtd <- "#6b84a0" # blue
col_sml <- "#779f74" # green
col_smf <- "#c19d55" # orange
col_sme <- "#c07356" # red
col_r_grey <- "#94949b"
col_r_blue <- "#1d63b4"
col_bg <- "#ffffff"

## To use this font, copy the ttf to the font directory of the
## hexSticker package
## font_text <- "Aller_Lt"
font_text <- "Aller_Rg"
## font_text <- "SpaceMono-Regular"

hex <- ggplot() +
    geom_hexagon(size = 1.2, fill = col_bg, color = NA) +

    hex_segment2(linewidth = 0, fill = paste0(col_r_grey, 20), # right
                 from_radius = 0, to_radius = 0.9,
                 from_angle = 330, to_angle = 30) +
    hex_segment2(linewidth = 0, fill = paste0(col_bg, 10), # top right
                 from_radius = 0, to_radius = 0.9,
                 from_angle = 30, to_angle = 90) +
    hex_segment2(linewidth = 0, fill = paste0(col_bg, 30), # top left
                 from_radius = 0, to_radius = 0.9,
                 from_angle = 90, to_angle = 150) +
    hex_segment2(linewidth = 0, fill = paste0(col_bg, 10), # left
                 from_radius = 0, to_radius = 0.9,
                 from_angle = 150, to_angle = 210) +
    hex_segment2(linewidth = 0, fill = paste0(col_r_grey, 20), # bottom
                 from_radius = 0, to_radius = 0.9,
                 from_angle = 210, to_angle = 270) +
    hex_segment2(linewidth = 0, fill = paste0(col_r_grey, 20), # bottom
                 from_radius = 0, to_radius = 0.9,
                 from_angle = 270, to_angle = 330) +
    ## border
    hex_segment2(linewidth = 0, fill = paste0(col_sme, "ff"), # right
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 330, to_angle = 30) +
    hex_segment2(linewidth = 0, fill = paste0(col_smf, "ff"), # top right
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 30, to_angle = 90) +
    hex_segment2(linewidth = 0, fill = paste0(col_sml, "ff"), # top left
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 90, to_angle = 150) +
    hex_segment2(linewidth = 0, fill = paste0(col_mtd, "ff"), # left
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 150, to_angle = 210) +
    hex_segment2(linewidth = 0, fill = paste0(col_r_grey, "ff"), # bottom
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 210, to_angle = 270) +
    hex_segment2(linewidth = 0, fill = paste0(col_r_grey, "ff"), # bottom
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 270, to_angle = 330) +
    
    geom_subview(subview = img, x = 1.00, y = 1.00,
                 width = 1.0, height = 1.0) +
    ## font size for linux: 6.5, macOS
    ## geom_url("www.bioconductor.org", x = 0.98, y = 0.17,
    ##          color = paste0(col_r_blue, "ff"), size = 6.5,
    ##          family = font_text) + 
    geom_url("www.bioconductor.org", x = 0.27, y = 0.59,
             color = paste0(col_r_blue, "ff"), size = 6.5,
             family = font_text, angle = -30) + 
    theme_sticker()
save_sticker(filename = "RmzTabM.png", hex)

