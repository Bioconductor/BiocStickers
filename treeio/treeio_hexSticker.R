require(emojifont)
require(ggtree)
require(hexSticker)


set.seed(2017-03-06)
tr <- rtree(10)
dd = data.frame(id=tr$tip.label, value=abs(rnorm(10)))
p <- ggtree(tr, size=.5, color="darkgrey") + theme_transparent()
require(ggstance)
p <- facet_plot(p, panel="Trait", data=dd, geom=geom_barh, mapping=aes(x=value), stat='identity', fill='grey', color=NA, width=.6, size=.5)



## pg <- ggplot(d=data.frame(x=c(1,10), y=c(1,5)), aes(x, y)) + geom_blank() + coord_fixed()

## pg <- pg + geom_fontawesome("fa-file-text-o", size=40, x=2.6, y=3.2, color="grey") +
##     annotation_custom(ggplotGrob(p), xmin=5, xmax=10, ymin=1, ymax=5)+
##     geom_fontawesome("fa-angle-double-right", size=10, color="#2C3E50", x=5, y=4) +
##     geom_fontawesome("fa-angle-double-left", size=10, color="#2C3E50", x=4, y=2) +
##     theme_tree() + theme_transparent()

## pf <- tempfile(fileext=".png")
## ggsave(pg, filename=pf, bg="transparent", width=5, height=3)

## sticker(pf, package="treeio", p_size=9, p_y=1.5,
##         s_x=1.02, s_y=.8, s_width=.9, s_height=1,
##         ## h_color="#2C3E50", h_fill="#2574A9",
##         filename="docs/treeio.png")

p <- p+theme(strip.text = element_blank()) #element_text(size=5), strip.background = element_blank())
p <- p+theme(panel.spacing = unit(0, "lines"))
hexagon() + geom_fontawesome("fa-file-text-o", size=14, x=.6, y=.85, color="grey") +
    geom_fontawesome("fa-angle-double-right", size=6, color="#2C3E50", x=1.15, y=1) +
    geom_fontawesome("fa-angle-double-left", size=6, color="#2C3E50", x=.9, y=.7) +
    geom_subview(p, x=1.48, y=.8, width=0.8, height=.9) + geom_pkgname("treeio", family="Aller_Lt", size=9) +
    save_sticker("treeio.png")
