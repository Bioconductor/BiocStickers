library(ggplot2)
library(png)
library(grid)
library(hexSticker)

## Settings:
col_bg_1 <- "#1E8BC3"      ## Summer Sky
col_bg_2 <- "#2574A9"      ## Jelly Bean
col_bg_3 <- "#4B77BE"      ## Steel Blue
col_border_1 <- "#6BB9F0"  ## Malibu
col_border_2 <- "#5C97BF"  ## Fountain Blue
col_border_3 <- "#89C4F4"  ## Jordy Blue
col_bg <- col_bg_3
col_border <- col_border_3
col_text <- "#ffffff"    ## white
col_ped <- "#ffffff"
n_steps <- 30
## Transparence rectangle
y_min <- 0.75
y_max <- 1.04
x_min <- 0.1
x_max <- 1.9
alpha_max <- 0.7

img <- readPNG("./drawing_2.png")
## Invert and add alpha channel.
img_a <- matrix(rgb(1 - img[,,1], 1 - img[,,2], 1 - img[,,3], img[,,4] * 0.8),
                nrow = dim(img)[1])
g_img <- rasterGrob(img_a, width = 1, x = 0.495, interpolate = TRUE)

## Rectangle with color shade to transparency
ys <- seq(y_min, y_max, length.out = n_steps + 1)
alpha_steps <- c(seq(from = 0, to = alpha_max, length.out = n_steps / 3),
                 rep(alpha_max, n_steps / 3),
                 seq(from = alpha_max, to = 0, length.out = n_steps / 3))
trans_df <- data.frame(xmin = x_min, xmax = x_max, ymin = ys[-length(ys)],
                       ymax = ys[-1], alpha = alpha_steps, range = c(0, 0.4))
trans_rect <- geom_rect(data = trans_df, fill = col_bg,
                        aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax,
                            alpha = alpha))    

gg <- ggplot() +
    geom_rect(aes(xmin = 0, xmax = x_max, ymin = 0, ymax = 1.5), fill = NA) +
    annotation_custom(g_img, xmin = -0.02, ymin = -0.15) +
    trans_rect + 
    theme_void() + guides(alpha = FALSE) + 
    scale_alpha_continuous(range = c(0, alpha_max))
## print(gg)

sticker(gg, package="AnnotationFilter", p_size = 5.5, p_y = 1.25, s_x = 0.89,
        s_y = 1.08, s_width = 1.04, s_height = 1.7, p_color = col_text,
        h_fill = col_bg, h_color = col_border, filename="AnnotationFilter.png",
        p_family = "Aller_Lt")


