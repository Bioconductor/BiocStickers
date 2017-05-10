library(ggplot2)
library(png)
library(grid)
library(hexSticker)
##library(hexbin)

## Settings:
## col_border <- "#446CB3"  ## San Marino
col_border <- "#4B77BE"  ## Steel Blue
## col_bg <- "#6C7A89"  ## Lynch
col_bg <- "#ABB7B7"  ## Edward
## col_text <- "#000000"    ## black
col_text <- "#FFFFFF"    ## white

csama_logo <- readPNG("./csama-logo.png")
dom <- readPNG("./Dom.png")
peitler <- readPNG("./PeitlerKofel.png")
peitler_2 <- readPNG("./PeitlerKofel_2.png")
## ## add alpha channel.
## peitler <- matrix(rgb(peitler[, , 1], peitler[, , 2], peitler[, , 3],
##                   peitler[, , 4] * 0.9), nrow = dim(peitler)[1])
csama_logo <- rasterGrob(csama_logo, width =  0.55, x = 0.5, y = 0.45,
                         interpolate = TRUE)
peitler <- rasterGrob(peitler, width = 1, x = 0.55, y = 0.63,
                      interpolate = TRUE)
peitler_2 <- rasterGrob(peitler_2, width = 1, x = 0.55, y = 0.43,
                        interpolate = TRUE)
dom <- rasterGrob(dom, width = 0.4, x = 0.5, y = 0.3)

gg <- ggplot() +
    ## annotation_custom(dom) +
    annotation_custom(peitler) +
    annotation_custom(csama_logo) +
    theme_void()
sticker(gg, package="CSAMA2017", p_size = 7, s_x = 1,
        s_y = 0.8, s_width = 1.5, s_height = 1,
        h_fill = col_bg, h_color = col_border,
        p_family = "Aller_Lt", filename="CSAMA2017.png", spotlight = TRUE,
        l_x = 1.025, p_color = col_text)

## gg <- ggplot() +
##     ## annotation_custom(dom) +
##     annotation_custom(peitler_2) +
##     annotation_custom(csama_logo) +
##     theme_void()
## sticker(gg, package="CSAMA", p_size = 9, s_x = 1,
##         s_y = 0.8, s_width = 1.5, s_height = 1,
##         h_fill = col_bg, h_color = col_border,
##         p_family = "Aller_Lt", filename="CSAMA_2.png", spotlight = TRUE,
##         l_x = 1.025, p_color = col_text)
