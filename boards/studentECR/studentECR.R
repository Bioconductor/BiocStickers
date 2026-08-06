library(ggplot2)
library(png)
library(grid)
library(hexSticker)

img <- readPNG("./ECR-logo.png")
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
bioc_blue = "#1892AA"

## colored beams.

w <- 0.98
h <- 0.98

df <- c(w,h)*1.45

hex <- ggplot() +
    geom_hexagon(size = 1.2, fill = "white", color = bioc_blue) +
    geom_url("www.bioconductor.org", x = 0.27, y = 1.50,
             color = bioc_blue, size = 6) + 
    geom_subview(subview = img, x = 1, y = 0.99,
                 width = df[1], height = df[2]) +
    theme_sticker() +
    theme(plot.margin = margin(t = -3.4,  # Top margin
                             r = -3.4,  # Right margin
                             b = -3.4,  # Bottom margin
                             l = -3.4)) # Left margin
hex
save_sticker(filename = "./studentECR-logo.png", hex)

