# code from /events/CSAMA/2017 as basis

library(ggplot2)
library(png)
library(grid)
library(hexSticker)

## Settings:
col_border <- "#656F73"  
col_bg <- "#1F2629"     
col_text <- "#0887CC"

# png from openclipart
# https://openclipart.org/unlimited-commercial-use-clipart
cab <- readPNG("./raseone-file-cabinet-300px.png")
cab <- rasterGrob(cab, width = .7, x = 0.55, y = 0.5,
                        interpolate = TRUE)

gg <- ggplot() +
    annotation_custom(cab) +
    theme_void()
sticker(gg, package="BiocFileCache", p_size = 18, s_x = 1,
        s_y = 0.8, s_width = 1.5, s_height = 1,
        h_fill = col_bg, h_color = col_border,
        p_family = "Aller_Lt",  
        p_color = col_text)
