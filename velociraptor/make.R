library(magick)
library(tidyverse)
library(magr)

img_original <- image_read("original.jpeg")

# img_original <- image_flatten(img_original, 'Modulate')

img_original <- image_rotate(img_original, 90)

img_data <- image_data(img_original)

img_matrix <- img_data[1, ,]
storage.mode(img_matrix) <- "numeric"

# quantile(img_matrix, seq(0, 1, 0.1))

img_matrix[img_matrix >= 0.9 * quantile(img_matrix, 0.5)] <- 0

img_matrix <- log(img_matrix + 1)

# heatmap(img_matrix, Rowv = NA, Colv = NA, scale = "none", col = c("white", "black"))

xy_coord <- as_tibble(which(img_matrix > 0, arr.ind = TRUE))

xy_coord %<>% mutate_all(function(x) {x + runif(length(x), -1, 1)})

library(iSEE)
keep <- subsetPointsByGrid(
  X = xy_coord$row,
  Y = xy_coord$col,
  resolution = 100
)
xy_coord <- xy_coord[keep,]

set.seed(1)
K <- kmeans(xy_coord, centers = 8)
xy_coord$cluster <- as.factor(K$cluster)

# library(ggplot2)
# ggplot(xy_coord) +
#   geom_point(aes(col, row, color = cluster)) +
#   theme_void()

start_cluster <- xy_coord %>% 
  group_by(cluster) %>% 
  summarise(mean_col = mean(col)) %>% 
  top_n(1, mean_col) %>% 
  pull(cluster)

library(SingleCellExperiment)
sce <- SingleCellExperiment(
  assays = list(matrix(NA, nrow = 0, ncol = nrow(xy_coord))),
  reducedDims = list(layout = as.matrix(xy_coord[, c("col", "row")])),
  colData = DataFrame(cluster = xy_coord$cluster)
)

library(slingshot)
sce <- slingshot(sce, clusterLabels = "cluster", reducedDim = "layout", start.clus = start_cluster)

pseudotime_columns <- grep("slingPseudotime_", names(colData(S)), value = TRUE)

plot_data <- tibble(
  x = reducedDim(sce)[, "col"],
  y = reducedDim(sce)[, "row"],
  color = rowMeans(as.matrix(colData(sce)[, pseudotime_columns]), na.rm = TRUE)
)

library(ggplot2)
gg <- ggplot(plot_data, aes(x, y)) +
  geom_point(aes(color = color)) +
  # geom_jitter(aes(color = color), width = 1, height = 1) +
  guides(color = "none") +
  scale_color_viridis_c() +
  theme_void()
gg
ggsave("velociraptor_pseudotime.pdf", width = 9, height = 7)

S <- SlingshotDataSet(sce)

library(ggplot2)
gg <- ggplot(plot_data, aes(x, y)) +
  geom_point(aes(color = color)) +
  # geom_jitter(aes(color = color), width = 1, height = 1) +
  guides(color = "none") +
  scale_color_viridis_c() +
  theme_void()
for (curve_name in names(S@curves)) {
  df <- bind_cols(
    as_tibble(S@curves[[curve_name]]$s),
    color = S@curves[[curve_name]]$lambda
  )
  df %<>% arrange(color)
  gg <- gg + geom_path(aes(col, row), df, size = 0.5)
}
gg
ggsave("velociraptor_curves.pdf", width = 9, height = 7)
