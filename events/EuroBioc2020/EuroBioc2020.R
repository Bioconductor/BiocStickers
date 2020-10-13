library(ggplot2)
library(png)
library(grid)
library(hexSticker)

bioc_blue <- "#1892AA"
bioc_green <- "#99C53C"
col_bg <- "#2c3e50" # midnight blue
## col_bg <- "#34495e" # wet asphalt
## col_bg <- "#3498db" # peter river
col_text <- "#f1c40f" # sunflower

img <- readPNG("./EuroBioc2020-drawing_mod.png")
img <- rasterGrob(img, width = 1, x = 0.5, y = 0.5,
                  interpolate = TRUE)
gg <- ggplot() +
    annotation_custom(img) +
    theme_void()
stckr <- sticker(gg,
                 package = NA,
                 p_size = 7.3,
                 s_x = 1,
                 s_y = 0.81,
                 s_width = 1.73,
                 s_height = 1.73,
                 h_fill = col_bg,
                 h_color = col_text,
                 p_family = "Aller_Lt",
                 spotlight = FALSE,
                 l_x = 1.025, p_color = col_bg,
                 url = NA,
                 u_color = col_bg
                 )
stckr <- stckr +
    geom_url(url = "EuroBioc", x = 0.23, y = 1.39,
             family = "Aller", size = 19, color = col_text, angle = 30) +
    geom_url(url = "2020", x = 0.4, y = 1.2,
             family = "Aller", size = 19, color = col_text, angle = 30) +
    geom_url(url = "www.bioconductor.org", size = 5, color = col_text,
             x = 0.32, y = 0.48, angle = 330)
save_sticker("EuroBioc2020.png", stckr, dpi = 300)

