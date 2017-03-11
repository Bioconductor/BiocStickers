## drawing color: #F2F1EF (carrara), #DADFE1 (iron)
library(ggplot2)
library(png)
library(grid)
library(sticker)

## Settings:
col_bg <- "#96281b"      ## Old brick
col_border <- "#ef4836"  ## flamingo
col_text <- "#F2F1EF"    ##  carrara
n_steps <- 60
y_min <- 1.0
y_max <- 1.15
x_min <- 0.2
x_max <- 1.2

## Read the drawing
img <- readPNG("./drawing.png")
## g_img <- rasterGrob(img, width = 0.55, y = 0.4, x = 0.48, interpolate = TRUE)
g_img <- rasterGrob(img, width = 0.475, x = 0.48, interpolate = TRUE)

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
    trans_rect +
    geom_rect(aes(xmin = 0.33, xmax = 1.1, ymin = 0.7, ymax = 1.2, alpha = 0.05),
              fill = col_bg) +
    geom_rect(aes(xmin = 0.6, xmax = 0.95, ymin = 0.395, ymax = 0.7, alpha = 0.05),
              fill = col_bg) +
    theme_void() + guides(alpha = FALSE)
## print(gg)

x <- make_sticker(ggplotGrob(gg), package = "xcms",
                  grob_xmin = -0.288,
                  grob_xmax = 2.3,
                  grob_ymax = 2.3,
                  grob_ymin = -0.6,
                  col_text = col_text,
                  text_size = 9,
                  col_border = col_border,
                  col_background = col_bg,
                  font = "Aller_Lt.ttf")
## print(x)
