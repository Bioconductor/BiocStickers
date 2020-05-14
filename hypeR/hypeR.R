require(ggplot2)
require(hexSticker)
library(network)
library(igraph)
library(sna)
library(ggnetwork)

# Option 1
set.seed(1)
ig <- igraph::sample_pa(7, power=2, directed=FALSE)
mat <- as.matrix(igraph::as_adjacency_matrix(ig))

n <- network(mat, directed=FALSE, multiple=FALSE)
n %v% "size" <- sna::degree(n)
n %v% "type" <- c("internal", "leaf")[as.numeric(degree(n) == 2)+1]

set.seed(1)
p <- ggplot(n, aes(x = x, y = y, xend = xend, yend = yend)) +
     geom_edges(color = "grey50", alpha = 0.5) +
     geom_nodes(aes(x, y, alpha=type, size = 2*size), color="gold") +
     geom_nodes(aes(x, y, color=type, size = 1.5*size)) +
     scale_alpha_manual(values=c("leaf"=0.5, "internal"=0)) +
     scale_color_manual(values=c("leaf"="red1", "internal"="darkorchid4")) +
     guides(size = FALSE) +
     theme_void() + 
     theme(legend.position = "none")

# Option 2
set.seed(1)
ig <- igraph::sample_pa(40, power=1.6, directed=FALSE)
mat <- as.matrix(igraph::as_adjacency_matrix(ig))

n <- network(mat, directed=FALSE, multiple=FALSE)
n %v% "size" <- degree(n)

set.seed(6)
p <- ggplot(n, aes(x = x, y = y, xend = xend, yend = yend)) +
     geom_edges(color = "#dae1e7", alpha = 0.5) +
     geom_nodes(aes(x, y, size = 1.4*size), color = "#dae1e7") +
     guides(size = FALSE) +
     theme_void() + 
     theme(legend.position = "none")

set.seed(1)
sticker(subplot=p,
        package='hypeR',
        p_family="mono",
        p_y=1.6,
        p_size=5, 
        s_x=.98, 
        s_y=.88, 
        s_width=1.4, 
        s_height=1,
        l_x=1,
        l_y=1,
        l_width=4,
        l_height=4,
        l_alpha=0.2,
        spotlight=TRUE,
        h_fill="#162447", 
        h_color="#1b1b2f")
