library(ggplot2)
library(png)
library(grid)
library(hexSticker)

## Summer Sky
col_text <- "#ffffff"
col_border <- "#ffffff"
col_bg <- "#1e8bc3" # Summer Sky
img <- readPNG("./images/CSAMA2020.png")
img <- rasterGrob(img, width = 1, x = 0.5, y = 0.5,
                  interpolate = TRUE)
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
    geom_url(url = "CSAMA2020", x = 0.21, y = 1.39,
             family = "Aller_Lt", size = 14, color = col_border) +
    geom_url(url = "www.bioconductor.org", size = 5.12, color = "#000000",
             x = 1.130, y = 0.144) +
    geom_url(url = "www.bioconductor.org", size = 5, color = "#ffffff",
             x = 1.125, y = 0.141)
save_sticker("CSAMA2020.png", stckr, dpi = 300)

