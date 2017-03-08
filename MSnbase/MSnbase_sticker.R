
## Get the data
library("rpx")
px1 <- PXDataset("PXD000001")
f <- "TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01-20141210.mzML"
mzf <- pxget(px1, f)

## From ?MSmap in MSnbase
library("MSnbase")
## reads the data 
ms <- openMSfile(mzf)
hd <- header(ms)
     
## a set of spectra of interest: MS1 spectra eluted
## between 30 and 35 minutes retention time
ms1 <- which(hd$msLevel == 1)
rtsel <- hd$retentionTime[ms1] / 60 > 30 &
    hd$retentionTime[ms1] / 60 < 35
     
## the map
M <- MSmap(ms, ms1[rtsel], 521, 523, .005, hd)

## Remove 0 intensities for clarity
M@map[M@map <= 0] <- NA

## Based on MSnbase::plot3D,MSmap
library("lattice")
library("grid")
dd <- as(M, "data.frame")
par.set <-
    list(axis.line = list(col = "transparent"),
         box.3d = list(lwd = .7),
         clip = list(panel = "off"))

mz <- cloud(intensity ~ rev(mz) + rt ,
            data = dd,
            col = "#bebebe",
            type = "h",
            scales= list(draw=FALSE),
            aspect=c(.8, 1),
            group = ms,
            zoom = 1, 
            par.settings = par.set,
            axis.line = list(col = "transparent"),
            xlab=NULL, ylab=NULL, zlab=NULL)

gmz <- grid.grabExpr(print(mz))


## Based on ggtree_sticker.R
library("ggplot2")
library("ggforce")
library("ggtree")
d = data.frame(x0=1, y0=1, r=1)
hex <- ggplot() +
    geom_circle(aes(x0=x0, y0=y0, r=r), size=4, data=d, n=5.5,
                fill="#d35400", color="#f39c12") + coord_fixed()

library("showtext")
font.add("Aller", "../fonts/Aller/Aller_Rg.ttf")

MSnbase_sticker <- hex +
    annotation_custom(gmz, xmin=-.03, xmax=2, ymin=0.05, ymax=1.75) +
    annotate('text', x = 1, y = 1.48, label='MSnbase', family = 'Aller', size = 27, color="white") +
    scale_y_continuous(expand=c(0,0), limits=c(-.015,2.02)) +
    scale_x_continuous(expand=c(0,0), limits=c(.13, 1.88)) +
    theme(plot.margin = unit(c(0,0,0,0), "lines"))

MSnbase_sticker <- MSnbase_sticker + theme_transparent() +
    theme(strip.text = element_blank()) +
    xlim_tree(3.8) +
    theme(line = element_blank(),
          text = element_blank(),
          title = element_blank())


ggsave(MSnbase_sticker, width=6, height=6.9,
       file = "MSnbase-2.png",
       bg = 'transparent')



