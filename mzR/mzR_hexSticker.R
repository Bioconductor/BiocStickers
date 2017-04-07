library(ggplot2)
library(png)
library(grid)
library(hexSticker)

## Settings:
col_bg <- "#f5ab35"      ## Lighning yellow
col_border <- "#f5d76e"  ## Cream can
col_text <- "#22313f"    ## Ebony clay
n_steps <- 60
y_min <- 0.95
y_max <- 1.35
x_min <- -0.07
x_max <- 1.5

## Read the drawing
img <- readPNG("./drawing.png")
g_img <- rasterGrob(img, width = 1, x = 0.48, interpolate = TRUE)

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

sticker(gg, package="mzR", p_size = 9, s_x = 1.01, s_y = .81, s_width = 1.55,
        s_height = 1.55, p_color = col_text, h_fill = col_bg,
        h_color = col_border, filename="mzR.png", p_family = "Aller_Lt")

set.seed(123)
sticker(gg, package="mzR", p_size = 9, s_x = 1.01, s_y = .81, s_width = 1.55,
        s_height = 1.55, p_color = col_text, h_fill = col_bg,
        spotlight = TRUE,
        h_color = col_border, filename="mzR_hl.png", p_family = "Aller_Lt")

