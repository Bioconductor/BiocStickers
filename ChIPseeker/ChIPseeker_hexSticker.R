require(ggplot2)
require(hexSticker)



require(ChIPseeker)
data("tagMatrixList")

p <- plotAvgProf(tagMatrixList[-c(4,5)], xlim=c(-3000, 3000), conf=0.99,resample=1000)
## p$layers[[3]] <- NULL

## p <- p + scale_color_brewer(palette="Set1") + theme_void() +
##     ggimage::theme_transparent(legend.position='none')




d = p$data
head(d)

require(ggplot2)

g <- ggplot(d, aes(pos, value, color=.id)) +
    geom_ribbon(aes(ymin = Lower, ymax = Upper, fill=.id),
                linetype = 0, alpha = 0.25) +
    geom_line(size=.2) +
    scale_color_brewer(palette="Set1") +
    scale_fill_brewer(palette="Set1") +
    theme_void() +
    ggimage::theme_transparent(legend.position='none')

g
sticker(g, package="ChIPseeker", p_size=6, s_x=.98, s_y=.88, s_width=1.4, s_height=1.1,h_fill = "#114466", h_color="#001030")

sticker(g, package="ChIPseeker", p_size=6, s_x=.98, s_y=.88, s_width=1.4, s_height=1.1,h_fill = "#114466", h_color="#001030", filename="ChIPseeker.pdf")
