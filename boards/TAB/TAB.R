library(ggplot2)
library(png)
library(grid)
library(hexSticker)

bioc_blue <- "#1892AA"
bioc_green <- "#99C53C"
col_bg <- "#ffffff"                       # 
col_shadow <- col_bg

img <- readPNG("./TAB_drawing_mod.png")
img <- rasterGrob(img, width = 1, x = 0.5, y = 0.5,
                  interpolate = TRUE)
gg <- ggplot() +
    annotation_custom(img) +
    theme_void()
stckr <- sticker(gg,
                 package = NA,
                 p_size = 7.3,
                 s_x = 0.945,
                 s_y = 0.81,
                 s_width = 1.5,
                 s_height = 1.6,
                 h_fill = col_bg,
                 h_color = bioc_blue,
                 p_family = "Aller_Lt",
                 spotlight = FALSE,
                 l_x = 1.025, p_color = col_bg,
                 url = NA,
                 u_color = col_bg
                 )
text_x <- 0.8
text_y <- 0.12
stckr <- stckr +
    geom_url(url = "T", x = text_x + 0.215, y = text_y + 1.39,
             family = "Aller", size = 20, color = bioc_green, angle = 0) +
    geom_url(url = " echnical", x = text_x + 0.31, y = text_y + 1.39,
             family = "Aller", size = 10, color = bioc_blue, angle = 0) +
    geom_url(url = "A", x = text_x + 0.2, y = text_y + 1.19,
             family = "Aller", size = 20, color = bioc_green, angle = 0) +
    geom_url(url = " dvisory", x = text_x + 0.316, y = text_y + 1.195,
             family = "Aller", size = 10.1, color = col_shadow, angle = 0) +
    geom_url(url = " dvisory", x = text_x + 0.31, y = text_y + 1.19,
             family = "Aller", size = 10, color = bioc_blue, angle = 0) +
    geom_url(url = "B", x = text_x + 0.225, y = text_y + 0.99,
             family = "Aller", size = 20, color = bioc_green, angle = 0) +
    geom_url(url = " oard", x = text_x + 0.337, y = text_y + 0.983,
             family = "Aller", size = 10, color = col_shadow, angle = 0) +
    geom_url(url = " oard", x = text_x + 0.33, y = text_y + 0.99,
             family = "Aller", size = 10, color = bioc_blue, angle = 0) +
    geom_url(url = "www.bioconductor.org", size = 5, color = bioc_blue,
              x = 0.3, y = 1.52, angle = 30)
    ## geom_url(url = "www.bioconductor.org", size = 5, color = bioc_blue,
    ##          x = 1.05, y = 1.9, angle = 330)
save_sticker("TAB.png", stckr, dpi = 300)

