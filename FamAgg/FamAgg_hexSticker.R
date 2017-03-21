library(ggplot2)
library(png)
library(grid)
library(hexSticker)

## Settings:
col_bg <- "#663399"      ## rebeccapurple
col_border <- "#bf55ec"  ## Medium Purple
col_text <- "#ffffff"    ## white
col_ped <- "#ffffff"
## col_ped <- "#000000"
n_steps <- 30
## Upper rectangle
y_min <- 0.95
y_max <- 1.3
x_min <- 0.1
x_max <- 1.8
alpha_max <- 0.3
## alpha_max <- 0.5

## Create the pedigree - workaround since I don't know how to add a standard
## plot to a ggplot - create the plot, save it as png and load that.
library(FamAgg)
data(minnbreast)
## Subsetting to only few families of the whole data set.
mbsub <- minnbreast[, ]
mbped <- mbsub[, c("famid", "id", "fatherid", "motherid", "sex")]
## Renaming column names.
colnames(mbped) <- c("family", "id", "father", "mother", "sex")
## Add the cancer trait.
fad <- FAData(pedigree=mbped)
tcancer <- mbsub$cancer
names(tcancer) <- mbsub$id
trait(fad) <- tcancer
png("pedigree.png", width = 4, height = 3.5, units = "cm", res = 300,
    pointsize = 3)
par(bg = "NA", col = col_ped, col.lab = col_ped,
    col.axis = col_ped, fg = col_ped)
plotPed(fad, family="173", col = col_ped)
dev.off()

## Alternative families:
## 13, 432, 285, 173, 262
## plotPed(fad, family = "13")
## plotPed(fad, family = "173")
## plotPed(fad, family = "262")

img <- readPNG("./pedigree.png")
## Add alpha channel.
img_a <- matrix(rgb(img[,,1], img[,,2], img[,,3], img[,,4] * 0.6),
                nrow = dim(img)[1])
## g_img <- rasterGrob(img_a, width = 0.65, x = 0.48, interpolate = TRUE)
g_img <- rasterGrob(img_a, width = 1, x = 0.48, y = 0.49, interpolate = TRUE)

## Rectangle with color shade to transparency
ys <- seq(y_min, y_max, length.out = n_steps + 1)
alpha_steps <- seq(from = 0, to = alpha_max, length.out = n_steps)
trans_df <- data.frame(xmin = x_min, xmax = x_max, ymin = ys[-length(ys)],
                       ymax = ys[-1], alpha = alpha_steps)
trans_rect <- geom_rect(data = trans_df, fill = col_bg,
                        aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax,
                            alpha = alpha))

gg <- ggplot() +
    geom_rect(aes(xmin = 0, xmax = 1.5, ymin = 0, ymax = 1.5), fill = NA) +
    annotation_custom(g_img, xmin = -0.02, ymin = -0.15) +
    trans_rect + 
    theme_void() + guides(alpha = FALSE)
## print(gg)

sticker(gg, package="FamAgg", p_size = 9, s_x = 0.99, s_y = 1.01, s_width = 1.5,
        s_height = 1.5, p_color = col_text, h_fill = col_bg,
        h_color = col_border, filename="FamAgg.png", p_family = "Aller_Lt")


