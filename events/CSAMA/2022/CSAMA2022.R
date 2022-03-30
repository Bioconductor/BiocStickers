library(ggplot2)
library(png)
library(grid)
library(hexSticker)

## Summer Sky
col_text <- "#ffffff"
col_border <- "#e8e8e8" # Mercury
col_bg <- "#1e8bc3" # Summer Sky
img <- readPNG("./images/CSAMA2022.png")
img <- rasterGrob(img, width = 1, x = 0.5, y = 0.5,
                  interpolate = FALSE)
gg <- ggplot() +
    annotation_custom(img) +
    theme_void()
stckr <- sticker(gg,
                 package = NA,
                 p_size = 7.3,
                 s_x = 0.98,
                 s_y = 0.99,
                 s_width = 1.78,
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
    geom_url(url = "CSAMA2022", x = 0.19, y = 1.35,
             family = "Aller", size = 15.1, color = col_border) +
    geom_url(url = "www.bioconductor.org", size = 7.17, color = "#000000",
             x = 0.976, y = 0.064) +
    geom_url(url = "www.bioconductor.org", size = 7, color = "#ffffff",
             x = 0.97, y = 0.07)
save_sticker("CSAMA2022.png", stckr, dpi = 300)

