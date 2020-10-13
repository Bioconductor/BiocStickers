library(ggplot2)
library(png)
library(grid)
library(hexSticker)

col_text <- "#2e3131"                   # outer space
col_border <- "#2e3131"
col_bg <- "#e4f1fe"                     # Alice Blue
img <- readPNG("./drawing_02.png")
img <- rasterGrob(img, width = 0.8, x = 0.48, y = 0.45,
                  interpolate = TRUE)
gg <- ggplot() +
    annotation_custom(img) +
    theme_void()
stckr <- sticker(gg,
                 package = NA,
                 p_size = 7.3,
                 s_x = 1.03,
                 s_y = 1,
                 s_width = 2.1,
                 s_height = 1.9,
                 h_fill = col_bg,
                 h_color = col_border,
                 p_family = "Aller_Lt",
                 spotlight = FALSE,
                 l_x = 1.025, p_color = col_text,
                 url = "www.bioconductor.org",
                 u_color = col_border
                 )
stckr <- stckr +
    geom_pkgname("BioC 2019", size = 9, y = 0.7, family = "Aller_Rg",
                 color = col_bg) +
    geom_pkgname("BioC 2019", size = 8.8, y = 0.7, family = "Aller_Rg",
                 color = col_text)
save_sticker("BioC2019_lightblue.png", stckr)


## Blue variant 1
col_text <- "#ffffff"
col_border <- "#ffffff"
col_bg <- "#89c4f4"                     # Jordy Blue
img <- readPNG("./drawing_02.png")
img <- rasterGrob(img, width = 0.8, x = 0.48, y = 0.45,
                  interpolate = TRUE)
gg <- ggplot() +
    annotation_custom(img) +
    theme_void()
stckr <- sticker(gg,
                 package = NA,
                 p_size = 7.3,
                 s_x = 1.03,
                 s_y = 1,
                 s_width = 2.1,
                 s_height = 1.9,
                 h_fill = col_bg,
                 h_color = col_border,
                 p_family = "Aller_Lt",
                 spotlight = FALSE,
                 l_x = 1.025, p_color = col_text,
                 url = "www.bioconductor.org",
                 u_color = col_border
                 )
stckr <- stckr +
    geom_pkgname("BioC 2019", size = 9, y = 0.7, family = "Aller_Rg",
                 color = col_bg) +
    geom_pkgname("BioC 2019", size = 8.8, y = 0.7, family = "Aller_Rg",
                 color = col_text)
save_sticker("BioC2019_blue1.png", stckr)

## Blue variant 2
col_text <- "#2e3131"                   # outer space
col_border <- "#2e3131"
col_bg <- "#89c4f4"                     # Jordy Blue
img <- readPNG("./drawing_02.png")
img <- rasterGrob(img, width = 0.8, x = 0.48, y = 0.45,
                  interpolate = TRUE)
gg <- ggplot() +
    annotation_custom(img) +
    theme_void()
stckr <- sticker(gg,
                 package = NA,
                 p_size = 7.3,
                 s_x = 1.03,
                 s_y = 1,
                 s_width = 2.1,
                 s_height = 1.9,
                 h_fill = col_bg,
                 h_color = col_border,
                 p_family = "Aller_Lt",
                 spotlight = FALSE,
                 l_x = 1.025, p_color = col_text,
                 url = "www.bioconductor.org",
                 u_color = col_border
                 )
stckr <- stckr +
    geom_pkgname("BioC 2019", size = 9, y = 0.7, family = "Aller_Rg",
                 color = col_bg) +
    geom_pkgname("BioC 2019", size = 8.8, y = 0.7, family = "Aller_Rg",
                 color = col_text)
save_sticker("BioC2019_blue2.png", stckr)
