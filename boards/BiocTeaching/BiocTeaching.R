library(ggplot2)
library(png)
library(grid)
library(hexSticker)

img <- readPNG("drawing/BiocClassroom.png")
img <- rasterGrob(img, width = 1.6, x = 0.5, y = 0.5,
                       interpolate = TRUE)

col_bg <- "#2978ad"
col_moon <- "#fefad4"
col_star <- "#fef58e"
col_witch <- "#fff68f"
col_cream <- "#ffffcc"
col_jellybean <- "#2574a9"
col_summersky <- "#1e8bc3"
col_bg <- col_cream
col_border <- col_jellybean

## colored beams.
hex <- ggplot() +
    geom_hexagon(size = 1.2, fill = col_bg, color = col_border) +
    geom_subview(subview = img, x = 0.95, y = 0.86,
                 width = 0.98, height = 0.98) +
    geom_url(url = "BiocTeaching", x = 0.2, y = 1.36, angle = 0,
             family = "Aller", size = 6.5, color = col_border) +
    ## font size for linux: 6.5, macOS
    ## geom_url("www.bioconductor.org", x = 1.81, y = 0.6,
    ##          color = col_border, size = 1.8, angle= 90) + 
    geom_url("www.bioconductor.org", x = 1.08, y = 1.89,
             color = col_border, size = 1.8, angle= -30) + 
    theme_sticker()
save_sticker(filename = "BiocTeaching.png", hex)

