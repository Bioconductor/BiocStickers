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

p <- ggtree(tr, color='grey') + geom_tiplab(align=T, linesize=.05,
                                            linetype='dotted', size=1.2, color='grey')

##  align the alignment with tree
p2 <- facet_plot(p, 'Alignment', grl, geom_alignment, inherit.aes=FALSE,
                 alpha=.6, size=.1, mapping=aes(), color='grey', extend.size=.1)
p2 <- p2 + theme_transparent() + theme(strip.text = element_blank())+xlim_tree(3.4) +theme(panel.spacing = unit(0, "lines"))


#################################
library(hexSticker)
## p_x=1, p_y=1.5,
sticker(p2, package="ggtree",  p_size=9, s_x=.9, s_y = .68, s_width=1.8, s_height=1.2,
        ## h_color="#2C3E50", h_fill="#2574A9",
        filename="ggtree.png", p_family="Aller_Lt")



oldwd <- getwd()
setwd("~/github/plotTree-ggtree/plotTree/tree_example_april2015/")
info <- read.csv("info.csv")
tree <- read.tree("tree.nwk")
heatmap.colours=c("steelblue","grey","seagreen3","darkgreen","green","brown","tan", "red",
                  "orange","pink","magenta","purple","blue","skyblue3","blue","skyblue2")
names(heatmap.colours) <- 0:15
heatmapData=read.csv("res_genes.csv", row.names=1)

rn <- rownames(heatmapData)
heatmapData <- as.data.frame(sapply(heatmapData, as.character))

rownames(heatmapData) <- rn

cols <- c(HCMC='black', Hue='purple2', KH='skyblue2')
p <- ggtree(tree, layout='circular', size=.1) %<+% info +
#  geom_tippoint(aes(color=location), size=.001) + scale_color_manual(values=cols) #+
  geom_tiplab2(aes(label=name), align=T, linetype=NA, linesize=.05, size=.2, offset=1, hjust=0.5) #+
#  geom_tiplab2(aes(label=year), align=T, linetype=NA, size=.2, offset=3.5, hjust=0.5)

p
require(tidyr)
df <- p$data
df <- df[df$isTip,]
start <- max(df$x) + 2

dd <- as.data.frame(heatmapData)
## dd$lab <- rownames(dd)
lab <- df$label[order(df$y)]
dd <- dd[lab, , drop=FALSE]
dd$y <- sort(df$y)
dd$lab <- lab
## dd <- melt(dd, id=c("lab", "y"))
dd <- gather(dd, variable, value, -c(lab, y))

i <- which(dd$value == "")
if (length(i) > 0) {
  dd$value[i] <- NA
}
width=.5
width <- width * (p$data$x %>% range %>% diff) / ncol(heatmapData)

V2 <- start + as.numeric(as.factor(dd$variable)) * width

dd$x <- V2
dd$width <- width

dd$value[dd$value == 0] = NA

p2 <- p + geom_tile(data=dd, aes(x, y, fill=value), width=width, inherit.aes=FALSE)

p2 = p2 + scale_fill_manual(values=heatmap.colours, na.value=NA) #"white")

setwd(oldwd)
p2 <- p2+theme_tree()+theme_transparent()

#p2
sticker(p2, package="ggtree",  p_size=9.5, s_x=.98, s_y = .73, s_width=1.6, s_height=1.6,
        ## h_color="#2C3E50", h_fill="#2574A9",
        p_y=1.55, spotlight=T, l_x=.98, l_y=.73,
        filename="ggtree.png", p_family="Aller_Lt")

sticker(p2, package="ggtree",  p_size=9.5, s_x=.98, s_y = .73, s_width=1.6, s_height=1.6,
        ## h_color="#2C3E50", h_fill="#2574A9",
        p_y=1.55, spotlight=T, l_x=.98, l_y=.73,
        filename="ggtree.pdf", p_family="Aller_Lt")

