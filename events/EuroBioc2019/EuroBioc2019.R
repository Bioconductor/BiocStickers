library(ggplot2)
library(png)
library(grid)
library(hexSticker)

col_text <- "#2e3131"                   # outer space
col_border <- "#2e3131"
col_bg <- "#e4f1fe"                     # Alice Blue
img <- readPNG("./EuroBioc2019_drawing.png")
img <- rasterGrob(img, width = 1, x = 0.5, y = 0.5,
                  interpolate = TRUE)
gg <- ggplot() +
    annotation_custom(img) +
    theme_void()
stckr <- sticker(gg,
                 package = NA,
                 p_size = 20,
                 s_x = 1.05,
                 s_y = 0.85,
                 s_width = 1.2,
                 s_height = 1.5,
                 h_fill = col_bg,
                 h_color = col_border,
                 p_family = "Aller_Lt",
                 spotlight = FALSE,
                 l_x = 1.025, p_color = col_text,
                 url = NA
                 )
stckr <- stckr +
    geom_url(url = "EuroBioc2019", x = 0.23, y = 1.38,
             family = "Aller_Rg", size = 12, color = col_border) +
    geom_url(url = "www.bioconductor.org", size = 5.2, color = col_bg,
             x = 1.125, y = 0.141) +
    geom_url(url = "www.bioconductor.org", size = 5, color = col_border,
             x = 1.125, y = 0.141)
save_sticker("EuroBioc2019.png", stckr, dpi = 300)
