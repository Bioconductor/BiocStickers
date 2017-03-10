library(ggplot2)
library(png)
library(grid)
source("../src/make_sticker.R")

## Settings:
col_bg <- "#f5ab35"
n_steps <- 60
y_min <- 0.9
y_max <- 1.1
x_min <- 0.2
x_max <- 1.2

## Read the drawing
img <- readPNG("./drawing.png")
## g_img <- rasterGrob(img, width = 0.55, y = 0.4, x = 0.48, interpolate = TRUE)
g_img <- rasterGrob(img, width = 0.55, x = 0.48, interpolate = TRUE)

## Rectangle with color shade to transparency
ys <- seq(y_min, y_max, length.out = n_steps + 1)
alpha_steps <- seq(from = 0, to = 0.5, length.out = n_steps)
trans_df <- data.frame(xmin = x_min, xmax = x_max, ymin = ys[-length(ys)],
                       ymax = ys[-1], alpha = alpha_steps)
trans_rect <- geom_rect(data = trans_df, fill = col_bg,
                        aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax,
                            alpha = alpha))
gg <- ggplot() +
    geom_rect(aes(xmin = 0, xmax = 1.5, ymin = 0, ymax = 1.5), fill = NA) +
    annotation_custom(g_img, xmin = -0.1) + coord_fixed() +
    trans_rect + theme_void() + guides(alpha = FALSE)
print(gg)


x <- make_sticker(ggplotGrob(gg), package = "mzR",
                  grob_xmin = -0.25,
                  grob_xmax = 2.4,
                  grob_ymax = 2.4,
                  grob_ymin = -0.8,
                  col_text = "#22313f",
                  text_size = 28,
                  col_border = "#f5d76e",
                  col_background = col_bg)
print(x)
