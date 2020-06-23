library(ggplot2)
library(png)
library(grid)
library(hexSticker)

## With the B
col_border <- "#2e3131"                   # Outer Space
col_text <- "#fefad4"                     # Moon Glow
col_bg <- "#ffffff"                       # 
img <- readPNG("./Bioc2020-drawing.png")
img <- rasterGrob(img, width = 0.94, x = 0.5, y = 0.5,
                  interpolate = TRUE)
gg <- ggplot() +
    annotation_custom(img) +
    theme_void()
stckr <- sticker(gg,
                 package = NA,
                 p_size = 7.3,
                 s_x = 0.99,
                 s_y = 1.01,
                 s_width = 1.85,
                 s_height = 2,
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
             family = "Aller", size = 16, color = col_text) +
    geom_url(url = "www.bioconductor.org", size = 5, color = col_border,
             x = 0.3, y = 0.48, angle = 330)
    ## geom_url(url = "www.bioconductor.org", size = 5, color = col_border,
    ##          x = 1.125, y = 0.141, angle = 30)
save_sticker("BioC2020.png", stckr, dpi = 300)

