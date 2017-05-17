library(ggplot2)
library(png)
library(grid)
library(hexSticker)

## Settings:
col_border <- "#4B77BE"  ## Steel Blue
col_bg <- "#ABB7B7"      ## Edward
col_text <- "#FFFFFF"    ## white

## dom <- readPNG("./Dom_2.png")
peitler_2 <- readPNG("./PeitlerKofel_2.png")
dna <- readPNG("./DNA-bin.png")
peitler_2 <- rasterGrob(peitler_2, width = 1, x = 0.55, y = 0.5,
                        interpolate = TRUE)
## dom <- rasterGrob(dom, width = 0.4, x = 0.5, y = 0.28)
dna <- rasterGrob(dna, width = 0.9, x = 0.52, y = 0.25)

gg <- ggplot() +
    annotation_custom(peitler_2) +
    annotation_custom(dna) + 
    ## annotation_custom(dom) +
    theme_void()
sticker(gg, package="CSAMA2017", p_size = 7.3, s_x = 1,
        s_y = 0.8, s_width = 1.5, s_height = 1,
        h_fill = col_bg, h_color = col_border,
        p_family = "Aller_Lt", filename="CSAMA2017.png", spotlight = TRUE,
        l_x = 1.025, p_color = col_text)
