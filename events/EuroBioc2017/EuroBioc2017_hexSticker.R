library(ggplot2)
library(png)
library(grid)
library(hexSticker)

## mat_bridge <- readPNG("./mathbridge.png")
mat_bridge <- readPNG("./mathbridge_color_50.png")
mat_bridge <- rasterGrob(mat_bridge, width = 1, x = 0.5, y = 0.61,
                        interpolate = TRUE)

gg <- ggplot() +
    annotation_custom(mat_bridge) +
    theme_void()

## Settings:
set.seed(123)
col_border <- "#A3C1AD"                 # Cambridge Blue
col_bg <- "#464646"
col_text <- col_border
url_color <- col_text
sticker(gg,
        package="EuroBioc2017",
        p_size = 6.3,
        s_x = 1,
        s_y = 0.8,
        s_width = 1.6,
        s_height = 1.6,
        h_fill = col_bg,
        h_color = col_border,
        p_family = "Aller_Lt",
        filename="EuroBioc2017.png",
        spotlight = TRUE,
        l_x = 1.0,
        l_y = 0.45,
        l_alpha = 0.3,
        p_color = col_text,
        url = "www.bioconductor.org",
        u_color = url_color)

set.seed(123)
col_border <- "#A3C1AD"                 # Cambridge Blue
col_bg <- "#FFFFFF"
col_text <- "#252525"
url_color <- col_border
sticker(gg,
        package="EuroBioc2017",
        p_size = 6.3,
        s_x = 1,
        s_y = 0.8,
        s_width = 1.6,
        s_height = 1.6,
        h_fill = col_bg,
        h_color = col_border,
        p_family = "Aller_Lt",
        filename="EuroBioc2017_light.png",
        spotlight = TRUE,
        l_x = 1.0,
        l_y = 0.45,
        p_color = col_text,
        url = "www.bioconductor.org",
        u_color = url_color)

## col_border <- "#252525"
## col_bg <- "#A3C1AD"
## col_text <- "#000000"
## url_color <- col_border
## sticker(gg,
##         package="EuroBioc2017",
##         p_size = 6.3,
##         s_x = 1,
##         s_y = 0.8,
##         s_width = 1.6,
##         s_height = 1.6,
##         h_fill = col_bg,
##         h_color = col_border,
##         p_family = "Aller_Lt",
##         filename="EuroBioc2017_blue.png",
##         spotlight = TRUE,
##         l_x = 1.0,
##         l_y = 0.45,
##         p_color = col_text,
##         url = "www.bioconductor.org",
##         u_color = url_color)

## Make a larger one
## ggsave(plot = stckr, filename = "Test.png", scale = 1)
