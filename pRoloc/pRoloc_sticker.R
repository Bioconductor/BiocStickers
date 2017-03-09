source("../src/make_sticker.R")

library("ggplot2")
library("pRoloc")
library("pRolocdata")
setMSnbaseVerbose(FALSE)

data(hyperLOPIT2015)
setStockcol(NULL)
setStockcol(paste0(getStockcol(), 90))

p <- plot2D(hyperLOPIT2015, fcol = "final.assignment",
            plot = FALSE,
            cex = fData(hyperLOPIT2015)$svm.score * 10)
p <- data.frame(p)
p$cex <- fData(hyperLOPIT2015)$svm.score * 2
p$loc <- factor(fData(hyperLOPIT2015)$final.assignment)
colnames(p)[1:2] <- c("x", "y")
cls <- getStockcol()[as.numeric(p$loc)]
cls[p$loc == "unknown"] <- "#FFFFFF20"
p$col <- cls
g <- ggplot(aes(x = x, y = y, size = cex),
            data = p) +
    geom_point(colour = "#00000080", shape = 1) +
    geom_point(colour = p$col) +
    theme(legend.position="none")
g <- g +
    theme(plot.margin = unit(c(0, 0, 0, 0), "lines"))
g <- g +
    theme_transparent() +
    theme(strip.text = element_blank()) +
    theme(line = element_blank(),
          text = element_blank(),
          title = element_blank())
save(g, file = "pRoloc_base_image.rda")

cl <- setdiff(unique(getMarkers(hyperLOPIT2015)), "unknown")
for (i in cl)
    g <- g + geom_density_2d(aes(x = x, y = y),
                             data = subset(p, loc %in% i),
                             bins = 10, colour = "#00000070",
                             inherit.aes = FALSE)

make_sticker(g,
             package = "pRoloc",
             text_size = 29,
             text_y = 1.6,
             col_border = "#C5EFF7",
             col_background = "#336E7B",
             col_text = "#C5EFF7",
             grob_xmin = 0.1, grob_xmax = 1.8,
             grob_ymin = 0.1, grob_ymax = 1.65)



