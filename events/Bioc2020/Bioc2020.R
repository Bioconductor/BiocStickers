library(ggplot2)
library(png)
library(grid)
library(hexSticker)

## With the B
col_text <- "#2e3131"                   # outer space
col_border <- "#2e3131"
col_bg <- "#89c4f4"                     # Jordy Blue
img <- readPNG("./Bioc2020-drawing.png")
img <- rasterGrob(img, width = 0.9, x = 0.5, y = 0.5,
                  interpolate = TRUE)
gg <- ggplot() +
    annotation_custom(img) +
    theme_void()
stckr <- sticker(gg,
                 package = NA,
                 p_size = 7.3,
                 s_x = 1.02,
                 s_y = 0.9,
                 s_width = 1.86,
                 s_height = 1.86,
                 h_fill = col_bg,
                 h_color = col_border,
                 p_family = "Aller_Lt",
                 spotlight = FALSE,
                 l_x = 1.025, p_color = col_text,
                 url = NA,
                 u_color = col_border
                 )
stckr <- stckr +
    geom_url(url = "BioC 2020", x = 0.22, y = 1.39,
             family = "oldeng", size = 16, color = col_border) +
    geom_url(url = "www.bioconductor.org", size = 5, color = col_border,
             x = 1.125, y = 0.141)
save_sticker("BioC2020.png", stckr, dpi = 300)

