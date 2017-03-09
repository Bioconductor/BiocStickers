source("../src/make_sticker.R")

library("ggplot2")
library("pRoloc")
library("pRolocdata")

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

## swap ER/Golgi with proteasome colours
cls0 <- getStockcol()
tmp <- cls0[5]
cls0[5] <- cls0[14]
cls0[14] <- tmp
cls <- cls0[as.numeric(p$loc)]
cls[p$loc == "unknown"] <- "#FFFFFF20"
p$col <- cls
g <- ggplot(aes(x = x, y = y, size = cex),
            data = p) +
    geom_point(colour = "#00000080", shape = 1) +
    geom_point(colour = p$col) +
    theme(legend.position="none")
g <- g +
    theme(plot.margin = unit(c(0, 0, 0, 0), "lines"))
g0 <- g <- g +
    theme_transparent() +
    theme(strip.text = element_blank()) +
    theme(line = element_blank(),
          text = element_blank(),
          title = element_blank())

cl <- setdiff(unique(getMarkers(hyperLOPIT2015)), "unknown")
for (i in cl)
    g <- g + geom_density_2d(aes(x = x, y = y),
                             data = subset(p, loc %in% i),
                             bins = 8, colour = "#000000AA",
                             inherit.aes = FALSE)

pRoloc <- list(text_size = 67,
               text_y = 1.5,
               col_text = "#FFFFFF",            
               col_border = "#C5EFF7",
               col_background = "#336E7B",
               grob_xmin = 0.1, grob_xmax = 1.8,
               grob_ymin = 0.1, grob_ymax = 1.65)

gcog <- g + geom_fontawesome("fa-cog",
                             size = 200, x = 0, y = 0,
                             color="#BEBEBEBB")
make_sticker(gcog,
             package = "pRoloc",
             text_size = pRoloc$text_size,
             text_y = pRoloc$text_y,
             col_border = pRoloc$col_border,
             col_background = pRoloc$col_background,
             col_text = pRoloc$col_text,
             grob_xmin = pRoloc$grob_xmin,
             grob_xmax = pRoloc$grob_xmax,
             grob_ymin = pRoloc$grob_ymin,
             grob_ymax = pRoloc$grob_ymax)

library("emojifont")
ggui <- g + geom_fontawesome("fa-hand-pointer-o",
                             size = 200, x = 0, y = 0,
                             color="#BEBEBECC")

make_sticker(ggui,
             package = "pRolocGUI",
             text_size = pRoloc$text_size,
             text_y = pRoloc$text_y,
             col_border = pRoloc$col_border,
             col_background = pRoloc$col_background,
             col_text = pRoloc$col_text,
             grob_xmin = pRoloc$grob_xmin,
             grob_xmax = pRoloc$grob_xmax,
             grob_ymin = pRoloc$grob_ymin,
             grob_ymax = pRoloc$grob_ymax)


gdata <- g + geom_fontawesome("fa-file-text-o",
                              size = 200, x = 0, y = 0,
                              color="#BEBEBEBB")

make_sticker(gdata,
             package = "pRolocdata",
             text_size = pRoloc$text_size,
             text_y = pRoloc$text_y,
             col_border = pRoloc$col_border,
             col_background = pRoloc$col_background,
             col_text = pRoloc$col_text,
             grob_xmin = pRoloc$grob_xmin,
             grob_xmax = pRoloc$grob_xmax,
             grob_ymin = pRoloc$grob_ymin,
             grob_ymax = pRoloc$grob_ymax)
