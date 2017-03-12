## drawing color: #F2F1EF (carrara), #DADFE1 (iron)
library(ggplot2)
library(png)
library(grid)
library(sticker)

## check gridBase

## Settings:
col_bg <- "#663399"      ## rebeccapurple
col_border <- "#bf55ec"  ## Medium Purple
col_text <- "#ffffff"    ## white
col_ped <- "#ffffff"
n_steps <- 80
## Upper rectangle
y_min <- 1.03
y_max <- 1.1
x_min <- 0.3
x_max <- 1.2
## Lower rectangle
y_min_2 <- 0.9
y_max_2 <- 0.97
x_min_2 <- x_min
x_max_2 <- x_max
alpha_max <- 0.3

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
img_a <- matrix(rgb(img[,,1], img[,,2], img[,,3], img[,,4] * 0.7),
                nrow = dim(img)[1])
g_img <- rasterGrob(img_a, width = 0.55, x = 0.48, interpolate = TRUE)

## Rectangle with color shade to transparency
ys <- seq(y_min, y_max, length.out = n_steps + 1)
alpha_steps <- seq(from = alpha_max, to = 0, length.out = n_steps)
upper_df <- data.frame(xmin = x_min, xmax = x_max, ymin = ys[-length(ys)],
                       ymax = ys[-1], alpha = alpha_steps)
upper_rect <- geom_rect(data = upper_df, fill = col_bg,
                        aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax,
                            alpha = alpha))
## Lower rectangle
ys <- rev(seq(y_min_2, y_max_2, length.out = n_steps + 1))
alpha_steps <- seq(from = alpha_max, to = 0, length.out = n_steps)
lower_df <- data.frame(xmin = x_min_2, xmax = x_max_2, ymin = ys[-length(ys)],
                       ymax = ys[-1], alpha = alpha_steps)
lower_rect <- geom_rect(data = lower_df,
                        aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax,
                            alpha = alpha), fill = col_bg)

gg <- ggplot() +
    annotation_custom(g_img, xmin = -0.02, ymin = -0.15) +
    geom_rect(aes(xmin = 0, xmax = 1.5, ymin = 0, ymax = 1.5), fill = NA) +
    lower_rect +
    scale_alpha_continuous(range = c(0, 0.7)) +
    upper_rect +
    geom_rect(aes(xmin = x_min, xmax = x_max,
                  ymin = y_max_2, ymax = y_min, alpha = alpha_max),
              fill = col_bg) +
    theme_void() + guides(alpha = FALSE)
## print(gg)

x <- make_sticker(ggplotGrob(gg), package = "FamAgg",
                  grob_xmin = -0.288,
                  grob_xmax = 2.3,
                  grob_ymax = 2.3,
                  grob_ymin = -0.25,
                  col_text = col_text,
                  text_size = 9,
                  col_border = col_border,
                  col_background = col_bg,
                  font = "Aller_Lt.ttf")
## print(x)
