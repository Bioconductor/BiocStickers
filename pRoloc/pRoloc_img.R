library("ggplot2")
library("pRoloc")
library("pRolocdata")
library("emojifont")

data(hyperLOPIT2015)
setStockcol(NULL)
setStockcol(paste0(getStockcol(), 90))

p <- plot2D(hyperLOPIT2015, fcol = "final.assignment",
            plot = FALSE,
            cex = fData(hyperLOPIT2015)$svm.score)
p <- data.frame(p)
p$cex <- fData(hyperLOPIT2015)$svm.score * 2
p$loc <- factor(fData(hyperLOPIT2015)$final.assignment)
colnames(p)[1:2] <- c("x", "y")

## swap ER/Golgi with proteasome colours
cls0 <- getStockcol()
tmp <- cls0[5]
cls0[5] <- cls0[14]
cls0[14] <- tmp
cls <- cls0[as.numeric(p$loc)]
cls[p$loc == "unknown"] <- "#FFFFFF20"
p$col <- cls

## base image
g <- ggplot(aes(x = x, y = y, size = cex),
            data = p) +
    geom_point(colour = "#00000080", shape = 1) +
    geom_point(colour = p$col) +
        theme(legend.position="none")

g0 <- g <- g +
    theme(plot.margin = unit(c(0, 0, 0, 0), "lines")) + 
    theme_transparent() +
    theme(strip.text = element_blank()) +
    theme(line = element_blank(),
          text = element_blank(),
          title = element_blank())

## add cluster density
cl <- setdiff(unique(getMarkers(hyperLOPIT2015)), "unknown")
for (i in cl)
    g <- g + geom_density_2d(aes(x = x, y = y),
                             data = subset(p, loc %in% i),
                             bins = 8, colour = "#000000AA",
                             inherit.aes = FALSE)

gcog <- g + geom_fontawesome("fa-cog",
                             size = 200, x = .1, y = 0,
                             color="#BEBEBEBB")
ggsave(gcog, filename = "img_cog.png", bg = "transparent")

gpointer <- g + geom_fontawesome("fa-hand-pointer-o",
                             size = 200, x = .1, y = 0,
                             color="#BEBEBECC")
ggsave(gpointer, filename = "img_pointer.png", bg = "transparent")

gfile <- g + geom_fontawesome("fa-file-text-o",
                              size = 200, x = .1, y = 0,
                              color="#BEBEBEBB")
ggsave(gfile, filename = "img_file.png", bg = "transparent")
