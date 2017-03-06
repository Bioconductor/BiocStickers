
library(ggforce)
d = data.frame(x0=1, y0=1, r=1)
hex <- ggplot() + geom_circle(aes(x0=x0, y0=y0, r=r), size=4, data=d, n=5.5, fill="#2574A9", color="#2C3E50") + coord_fixed()

require(emojifont)
font.add("PTSans", "PTSans.ttc")
hex <- hex+annotate('text', x=1, y=1.48, label='treeio', family='PTSans', size=35, color="white")

require(ggtree)
set.seed(2017-03-06)
tr <- rtree(10)
dd = data.frame(id=tr$tip.label, value=abs(rnorm(10)))
p <- ggtree(tr, size=2, color="darkgrey") + theme_transparent()
require(ggstance)
p <- facet_plot(p, panel="Trait", data=dd, geom=geom_barh, mapping=aes(x=value), stat='identity', fill='grey', color='darkgrey')


hex2 <- hex+ geom_fontawesome("fa-file-text-o", size=40, x=.6, y=.85, color="grey") +
    annotation_custom(ggplotGrob(p), xmin=1.2, xmax=1.8, ymin=.45, ymax=1.15)

treeio_sticker <- hex2+geom_fontawesome("fa-angle-double-right", size=30, color="#2C3E50", x=1.15, y=1) +
    geom_fontawesome("fa-angle-double-left", size=30, color="#2C3E50", x=.95, y=.7) +
    theme_tree() + theme_transparent()+
    scale_y_continuous(expand=c(0,0), limits=c(-.015,2.02)) +
    scale_x_continuous(expand=c(0,0), limits=c(.13, 1.88)) +
    theme(plot.margin = unit(c(0,0,0,0), "lines"))


ggsave("treeio.png", treeio_sticker, width=6, height=6.9, bg="transparent")
