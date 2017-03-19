library("hexSticker")
## GithubSHA1: 89e4d60a370f0457a0c4c08a95d4065e29275809

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
## Redice k highest peaks
for (k in 1:12) {
    i <- arrayInd(which.max(M@map), dim(M@map))
    M@map[i] <- M@map[i]/2
}

## Based on MSnbase::plot3D,MSmap
library("lattice")
library("grid")
dd <- as(M, "data.frame")
par.set <-
    list(axis.line = list(col = "transparent"),
         box.3d = list(lwd = 0),
         clip = list(panel = "off"))

mz <- cloud(intensity ~ rev(mz) + rt ,
            data = dd,
            col = "#96281b",
            type = "h",
            scales = list(draw = FALSE),
            aspect = c(.8, 1),
            group = ms,
            zoom = 1.1, 
            par.settings = par.set,
            axis.line = list(col = "transparent"),
            screen = list(z = 40, x = -67, y = 5),
            xlab = NULL, ylab = NULL, zlab = NULL)

x <- sticker(mz, package = "MSnbase",
             p_size = 28,
             s_x = 1.1, s_y = 1.05,
             s_width = 1.6, s_height = 1,
             h_fill = "#f9690e",
             h_color = "#f39c12")
x


