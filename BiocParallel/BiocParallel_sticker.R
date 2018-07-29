library(hexSticker)
library(ggplot2)
library(ggthemes)
library(png)
library(grid)


## Image for the computer
img <- readPNG(source = "computer-icon.png")
computer_img <- rasterGrob(img, interpolate=TRUE)

## Plot cirles
circle_plot <- function(center = c(0,0), diameter = 0.5, npoints = 100) {
    r = diameter / 2
    tt <- seq(0,2*pi,length.out = npoints)
    xx <- center[1] + r * cos(tt)
    yy <- center[2] + r * sin(tt)
    dat <- data.frame(x = xx, y = yy)
    plot <- geom_polygon(data = dat, aes(x = x, y = y), fill = "lightblue")
    plot
}

## Plot arrows
arrow_plot <- function(start, end, size) {
    dat <- data.frame(x=start[1], y= start[2])
    arrow <- geom_segment(data=dat,
                          aes(x = x, y = y,
                              xend = end[1], yend = end[2]),
                          arrow = arrow(angle=10, length=unit(0.25,"cm")),
                          size = size, color = "red" , alpha = 0.5)
    arrow
}

## List of points
cp <- list(
    c(1,1), c(2,1), c(3,1), c(4,1), c(5,1)
)


## Plot
p <- ggplot() +
    ## Master
    annotation_custom(computer_img,
                      xmin = 2.5, xmax=3.5,
                      ymin=2.5, ymax= 3.5) +
    ## Workers
    circle_plot(cp[[1]]) +
    circle_plot(cp[[2]]) +
    circle_plot(cp[[3]]) +
    circle_plot(cp[[4]]) +
    circle_plot(cp[[5]]) +
    ## arrows
    arrow_plot(c(3,3), cp[[1]], size = 1) +
    arrow_plot(c(3,3), cp[[2]], size = 1) +
    arrow_plot(c(3,3), cp[[3]], size = 1) +
    arrow_plot(c(3,3), cp[[4]], size = 1) +
    arrow_plot(c(3,3), cp[[5]], size = 1) +
    ## Labels
    geom_label(aes(x = cp[[1]][1], y = 1, label = "W"), color = "black", fontface="bold") +
    geom_label(aes(x = cp[[2]][1], y = 1, label = "W"), color = "black", fontface="bold") +
    geom_label(aes(x = cp[[3]][1], y = 1, label = "W"), color = "black", fontface="bold") +
    geom_label(aes(x = cp[[4]][1], y = 1, label = "W"), color = "black", fontface="bold") +
    geom_label(aes(x = cp[[5]][1], y = 1, label = "W"), color = "black", fontface="bold") +
    ## Scale
    scale_y_continuous(limits=c(0, 4)) +
    ## Theme
    theme(legend.position = "none",
          panel.background = element_blank(),
          axis.title = element_blank(),
          axis.ticks = element_blank(),
          axis.text = element_blank(),
          plot.background = element_rect(fill = "transparent",
                                         colour = NA), # bg of the plot
          panel.grid.major = element_blank(), # get rid of major grid
          panel.grid.minor = element_blank() # get rid of minor grid
    )

## Save PNG subplot
ggsave(p, bg = "transparent", filename = "subplot.png")


## Use hexSticker to plot
subplot <- "subplot.png"
sticker(subplot,
        p_size=7,  ## size of BiocParallel heading
        s_x=1.0, ## X axis location subplot
        s_y=0.8, ## y axis location subplot
        s_width=0.7,
        s_height = 0.5,
        h_fill="#F0E442",
        package="BiocParallel")
