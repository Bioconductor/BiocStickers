library(ggplot2)
library(png)
library(grid)
library(hexSticker)

## With the B
col_border <- "#2e3131"                   # Outer Space
col_text <- "#fefad4"                     # Moon Glow
col_bg <- "#f0f0d6"                       #
col_bg <- "#f3f1ef"                       # Pampas
img <- readPNG("./BioC2021-sticker-MtRainier.png")
img <- rasterGrob(img, width = 1, x = 0.5, y = 0.5,
                  interpolate = TRUE)

gg <- ggplot() +
    annotation_custom(img) +
    theme_void()
stckr <- sticker(gg,
                 package = NA,
                 p_size = 7.3,
                 s_x = 1,
                 s_y = 0.82,
                 s_width = 1.7,
                 s_height = 1.7,
                 h_fill = col_bg,
                 h_color = col_border,
                 p_family = "Aller_Lt",
                 spotlight = FALSE,
                 l_x = 1.025, p_color = col_text,
                 url = NA,
                 u_color = col_border
                 )
stckr <- stckr +
    geom_url(url = "BioC 2021", x = 0.2, y = 1.39,
             family = "Aller", size = 5.4, color = col_border) + # R Unix: size = 16
    geom_url(url = "www.bioconductor.org", size = 1.6, color = col_text, # R Unix: size = 5
             x = 1.14, y = 0.13, angle = 30)
save_sticker("BioC2021.png", stckr, dpi = 300)

img <- readPNG("./BioC2021-sticker-MtRainier-Spaceneedle.png")
img <- rasterGrob(img, width = 1, x = 0.5, y = 0.5,
                  interpolate = TRUE)

gg <- ggplot() +
    annotation_custom(img) +
    theme_void()
stckr <- sticker(gg,
                 package = NA,
                 p_size = 7.3,
                 s_x = 1,
                 s_y = 0.82,
                 s_width = 1.7,
                 s_height = 1.7,
                 h_fill = col_bg,
                 h_color = col_border,
                 p_family = "Aller_Lt",
                 spotlight = FALSE,
                 l_x = 1.025, p_color = col_text,
                 url = NA,
                 u_color = col_border
                 )
stckr <- stckr +
    geom_url(url = "BioC 2021", x = 0.2, y = 1.39,
             family = "Aller", size = 5.4, color = col_border) + # R Unix: size = 16
    geom_url(url = "www.bioconductor.org", size = 1.6, color = col_text, # R Unix: size = 5
             x = 1.14, y = 0.13, angle = 30)
save_sticker("BioC2021-v2.png", stckr, dpi = 300)

img <- readPNG("./BioC2021-sticker-Spaceneedle.png")
img <- rasterGrob(img, width = 1, x = 0.5, y = 0.5,
                  interpolate = TRUE)

gg <- ggplot() +
    annotation_custom(img) +
    theme_void()
stckr <- sticker(gg,
                 package = NA,
                 p_size = 7.3,
                 s_x = 1,
                 s_y = 0.82,
                 s_width = 1.7,
                 s_height = 1.7,
                 h_fill = col_bg,
                 h_color = col_border,
                 p_family = "Aller_Lt",
                 spotlight = FALSE,
                 l_x = 1.025, p_color = col_text,
                 url = NA,
                 u_color = col_border
                 )
stckr <- stckr +
    geom_url(url = "BioC 2021", x = 0.2, y = 1.39,
             family = "Aller", size = 5.4, color = col_border) + # R Unix: size = 16
    geom_url(url = "www.bioconductor.org", size = 1.6, color = col_text, # R Unix: size = 5
             x = 1.14, y = 0.13, angle = 30)
save_sticker("BioC2021-v3.png", stckr, dpi = 300)

