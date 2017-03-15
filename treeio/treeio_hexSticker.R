require(emojifont)
require(ggtree)
require(hexSticker)


set.seed(2017-03-06)
tr <- rtree(10)
dd = data.frame(id=tr$tip.label, value=abs(rnorm(10)))
p <- ggtree(tr, size=1.5, color="darkgrey") + theme_transparent()
require(ggstance)
p <- facet_plot(p, panel="Trait", data=dd, geom=geom_barh, mapping=aes(x=value), stat='identity', fill='grey', color='darkgrey')

pg <- ggplot(d=data.frame(x=c(1,10), y=c(1,5)), aes(x, y)) + geom_blank() + coord_fixed()

pg <- pg + geom_fontawesome("fa-file-text-o", size=40, x=2.6, y=3.2, color="grey") +
    annotation_custom(ggplotGrob(p), xmin=5, xmax=10, ymin=1, ymax=5)+
    geom_fontawesome("fa-angle-double-right", size=10, color="#2C3E50", x=5, y=4) +
    geom_fontawesome("fa-angle-double-left", size=10, color="#2C3E50", x=4, y=2) +
    theme_tree() + theme_transparent()

pf <- tempfile(fileext=".png")
ggsave(pg, filename=pf, bg="transparent", width=5, height=3)

sticker(pf, package="treeio", p_size=9, p_y=1.5,
        s_x=1.02, s_y=.8, s_width=.9, s_height=1,
        ## h_color="#2C3E50", h_fill="#2574A9",
        filename="docs/treeio.png")

