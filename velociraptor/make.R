library(magick)

img_original <- image_read("original.jpeg")

# img_original <- image_flatten(img_original, 'Modulate')

img_original <- image_rotate(img_original, 90)

img_data <- image_data(img_original)

img_matrix <- img_data[1, ,]
storage.mode(img_matrix) <- "numeric"

# quantile(img_matrix, seq(0, 1, 0.1))

img_matrix[img_matrix >= 0.9 * quantile(img_matrix, 0.5)] <- 0

img_matrix <- log(img_matrix + 1)

heatmap(img_matrix, Rowv = NA, Colv = NA, scale = "none", col = c("white", "black"))

xy_coord <- as.data.frame(which(img_matrix > 0, arr.ind = TRUE))

library(ggplot2)
ggplot(xy_coord) +
  geom_point(aes(col, row)) +
  theme_void()
