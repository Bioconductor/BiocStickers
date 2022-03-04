library(magick)
library(tidyverse)
library(magrittr)

# Load and preprocess image ----

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

# Downsample resolution ----

library(iSEE)
keep <- subsetPointsByGrid(
  X = xy_coord$row,
  Y = xy_coord$col,
  resolution = 100
)
xy_coord <- xy_coord[keep,]

library(ggplot2)
gg <- ggplot(xy_coord, aes(col, row)) +
  geom_point() +
  guides(color = "none") +
  scale_color_viridis_c() +
  theme_void()
gg
ggsave("velociraptor_points.pdf", width = 9, height = 7)

# Compute pseudotime ----

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

pseudotime_columns <- grep("slingPseudotime_", names(colData(sce)), value = TRUE)

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

# Compute principal curves ----

S <- SlingshotDataSet(sce)

library(ggplot2)
gg <- ggplot(plot_data, aes(x, y)) +
  geom_point(aes(color = color)) +
  guides(color = "none") +
  scale_color_viridis_c() +
  theme_void()
for (curve_name in names(S@curves)) {
  df <- bind_cols(
    as_tibble(S@curves[[curve_name]]$s),
    color = S@curves[[curve_name]]$lambda
  )
  df %<>% arrange(color) %>% 
    head(floor(nrow(df) * 0.96))
  gg <- gg + geom_path(aes(col, row), df,
                       size = 1, arrow = arrow(angle = 20, length = unit(0.1, "inches")))
}
gg
ggsave("velociraptor_curves.pdf", width = 9, height = 7)

# Compute velocity vectors ----

get_cells_nearby <- function(data, x, y, resolution = 50) {
  ref_x <- x
  ref_y <- y
  x_distance_max <- diff(range(plot_data$x)) / resolution
  y_distance_max <- diff(range(plot_data$y)) / resolution
  x_max <- x + x_distance_max
  x_min <- x - x_distance_max
  y_max <- y + y_distance_max
  y_min <- y - y_distance_max
  subdata <- data %>% 
    filter(x > x_min & x < x_max & y > y_min & y < y_max) %>% 
    filter(x != ref_x & y != ref_y)
  subdata
}

get_gradient <- function(data, x, y, resolution = 50, min.neighbours = 10) {
  subdata <- get_cells_nearby(data, x, y, resolution)
  if (nrow(subdata) < min.neighbours) {
    return(c(x = NA, y = NA))
  }
  gradient_x <- coefficients(lm(color ~ x, subdata))["x"]
  gradient_y <- coefficients(lm(color ~ y, subdata))["y"]
  return(c(gradient_x, gradient_y))
}

field_resolution = 25
grid_x <- seq(min(plot_data$x), max(plot_data$x), length.out = field_resolution)
grid_y <- seq(min(plot_data$y), max(plot_data$y), length.out = field_resolution)

vector_field <- as_tibble(expand.grid(x = grid_x, y = grid_y))

out <- t(sapply(seq_len(nrow(vector_field)), function(i) get_gradient(plot_data, vector_field$x[i], vector_field$y[i], resolution = field_resolution * 2, min.neighbours = 5)))
colnames(out) <- c("x_gradient", "y_gradient")
# out

vector_field2 <- bind_cols(vector_field, as_tibble(out))
vector_field2 <- subset(vector_field2, !is.na(vector_field2$x_gradient))

gradient_expand <- 4

gg <- ggplot(vector_field2, aes(x, y, xend = x + x_gradient * gradient_expand, yend = y + y_gradient * gradient_expand)) +
  geom_segment(arrow = arrow(angle = 20, length = unit(0.05, "inches"))) +
  theme_void()
gg
ggsave("velociraptor_field.pdf", width = 9, height = 7)

library(ggplot2)
gg <- ggplot(plot_data, aes(x, y)) +
  geom_point(aes(color = color), alpha = 0.7) +
  guides(color = "none") +
  scale_color_viridis_c() +
  theme_void()
gg <- gg + geom_segment(
  aes(x, y, xend = x + x_gradient * gradient_expand, yend = y + y_gradient * gradient_expand),
  vector_field2,
  arrow = arrow(angle = 25, length = unit(0.1, "inches")),
  size = 1.1
  )
gg
ggsave("velociraptor_pseudotime_fieldblack.pdf", width = 9, height = 7)

library(ggplot2)
gg <- ggplot(plot_data, aes(x, y)) +
  geom_point(aes(color = color), alpha = 1) +
  guides(color = "none") +
  scale_color_viridis_c() +
  theme_void()
gg <- gg + geom_segment(
  aes(x, y, xend = x + x_gradient * gradient_expand, yend = y + y_gradient * gradient_expand),
  vector_field2,
  arrow = arrow(angle = 25, length = unit(0.1, "inches")),
  size = 1.1, color = "white"
)
gg
ggsave("velociraptor_pseudotime_fieldwhite.pdf", width = 9, height = 7)
