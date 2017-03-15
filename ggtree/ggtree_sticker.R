## author: Guangchuang Yu
## 2017-03-03
##
##
## original code to produce the sticker, both `sticker` and `hexSticker` packages are all based on this
##
## now change to using hexSticker package, see ggtree_hexSticker.R
##
##


## The empty hex

library(ggforce)
d = data.frame(x0=1, y0=1, r=1)
hex <- ggplot() + geom_circle(aes(x0=x0, y0=y0, r=r), size=4, data=d, n=5.5, fill="#2574A9", color="#2C3E50") + coord_fixed()


## data for alignment

library(ggbio)
library(biovizBase)
library(Homo.sapiens)

library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

data(genesymbol, package = "biovizBase")
wh <- genesymbol[c("BRCA1", "NBR1")]
wh <- range(wh, ignore.strand = TRUE)

gr.txdb <- crunch(txdb, which = wh)
## change column to  model
colnames(values(gr.txdb))[4] <- "model"
grl <- split(gr.txdb, gr.txdb$tx_id)
## fake some randome names
set.seed(2016-10-25)
names(grl) <- sample(LETTERS, size = length(grl), replace = TRUE)


## the random tree

library(ggtree)
n <- names(grl) %>% unique %>% length
set.seed(2016-10-25)
tr <- rtree(n)
set.seed(2016-10-25)
tr$tip.label = sample(unique(names(grl)), n)

p <- ggtree(tr, color='grey', size=1.5) + geom_tiplab(align=T, linesize=.1, linetype='dashed', size=4, color='grey')

##  align the alignment with tree
p2 <- facet_plot(p, 'Alignment', grl, geom_alignment, inherit.aes=FALSE, alpha=.6, mapping=aes(), color='grey')
p2 <- p2 + theme_transparent() + theme(strip.text = element_blank())+xlim_tree(3.8)

require(showtext)
font.add("Aller", "../fonts/Aller/Aller_Rg.ttf")

## add figure and package name to hex
ggtree_sticker <- hex+annotation_custom(ggplotGrob(p2), xmin=.2, xmax=1.7, ymin=0.25, ymax=1.25) +
    annotate('text', x=1, y=1.48, label='ggtree', family='Aller', size=35, color="white") +
    theme_tree() + theme_transparent()+ scale_y_continuous(expand=c(0,0), limits=c(-.015,2.02)) +
    scale_x_continuous(expand=c(0,0), limits=c(.13, 1.88)) + theme(plot.margin = unit(c(0,0,0,0), "lines"))

print(ggtree_sticker)
ggsave(ggtree_sticker, width=6, height=6.9, file="ggtree.png", bg='transparent')

