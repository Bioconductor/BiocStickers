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


img <- readPNG("drawings/MassIVE-hero-bw.png")
img <- rasterGrob(img, width = 1.6, x = 0.5, y = 0.5,
                       interpolate = TRUE)

## Color definition from https://flatuicolors.com/palette/us
## #6c5ce7 exodus fruit; darker purple
## #a29bfe shy moment; light purple
## #b2bec3 soothing ... ; greyisch
## #dfe6e9 city ; light grey

## Color definition from https://flatuicolors.com/palette/ca
## #341f97 bluebell; darkish purple
## #5f27cd nasu purple; lighter purple
## #8395a7 storm petrel; greyisch

## Color definition from https://flatuicolors.com/palette/fr
## #0c2461 dark sapphire
## #1e3799 ... blue
##

## Manually define...
col_dark = "#0c2461"
col_middle = "#1e3799"
col_light = "#8395a7"
col_bg = "#ffffff"

## MsBackendMetaboLights
ml_col_dark = "#0b568b"
ml_col_middle = "#e29d3c"

## MassIVE header colors
col_dark = "#333399"
col_middle = "#4b5da5"

font_text <- "Aller_Rg"
## font_text <- "SpaceMono-Regular"

hex <- ggplot() +
    geom_hexagon(size = 1.2, fill = col_bg, color = NA) +

    hex_segment2(linewidth = 0, fill = paste0(col_middle, 10), # right
                 from_radius = 0, to_radius = 0.9,
                 from_angle = 330, to_angle = 30) +
    hex_segment2(linewidth = 0, fill = paste0(col_dark, 20), # top right
                 from_radius = 0, to_radius = 0.9,
                 from_angle = 30, to_angle = 90) +
    hex_segment2(linewidth = 0, fill = paste0(col_dark, 20), # top left
                 from_radius = 0, to_radius = 0.9,
                 from_angle = 90, to_angle = 150) +
    hex_segment2(linewidth = 0, fill = paste0(col_middle, 10), # left
                 from_radius = 0, to_radius = 0.9,
                 from_angle = 150, to_angle = 210) +
    hex_segment2(linewidth = 0, fill = paste0(col_middle, 10), # bottom
                 from_radius = 0, to_radius = 0.9,
                 from_angle = 210, to_angle = 270) +
    hex_segment2(linewidth = 0, fill = paste0(col_middle, 10), # bottom
                 from_radius = 0, to_radius = 0.9,
                 from_angle = 270, to_angle = 330) +
    ## border
    hex_segment2(linewidth = 0, fill = paste0(col_dark, "ce"), # right
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 330, to_angle = 30) +
    hex_segment2(linewidth = 0, fill = paste0(col_dark, "aa"), # top right
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 30, to_angle = 90) +
    hex_segment2(linewidth = 0, fill = paste0(col_dark, "aa"), # top left
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 90, to_angle = 150) +
    hex_segment2(linewidth = 0, fill = paste0(col_dark, "ce"), # left
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 150, to_angle = 210) +
    hex_segment2(linewidth = 0, fill = paste0(col_dark, "ec"), # bottom left
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 210, to_angle = 270) +
    hex_segment2(linewidth = 0, fill = paste0(col_dark, "ec"), # bottom right
                 from_radius = 0.9, to_radius = 1,
                 from_angle = 270, to_angle = 330) +
    
    geom_subview(subview = img, x = 1.0, y = 0.93,
                 width = 0.95, height = 0.95) +
    ## font size for linux: 6.5, macOS
    geom_url("www.bioconductor.org", x = 0.98, y = 0.17,
             color = col_dark, size = 6.5, family = font_text) + 
    theme_sticker()
save_sticker(filename = "MsBackendMassIVE.png", hex)

