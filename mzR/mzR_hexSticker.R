library(ggplot2)
library(png)
library(grid)
library(hexSticker)

## Settings:
col_bg <- "#f5ab35"      ## Lighning yellow
col_border <- "#f5d76e"  ## Cream can
col_text <- "#22313f"    ## Ebony clay
n_steps <- 60
y_min <- 0.9
y_max <- 1.1
x_min <- 0.2
x_max <- 1.2


## sticker("./drawing.png", package = "mzR", p_size = 8, s_x = 1, s_y = .75,
##         s_width = .6, s_height = .4, p_color = col_text, h_fill = col_bg,
##         h_color = col_border, filename="test.png")

## Read the drawing
img <- readPNG("./drawing.png")
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

sticker(gg, package="mzR", p_size = 9, s_x = 1.06, s_y = .8, s_width = 1.5,
        s_height = 1.5, p_color = col_text, h_fill = col_bg,
        h_color = col_border, filename="mzR.png", p_family = "Aller_Lt")

