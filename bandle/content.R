library(bandle)
library(pRoloc)
library(pRolocdata)
library(dplyr)
library(circlize)

## get THP1 data from pRolocdata
data("thpLOPIT_lps_mulvey2021")
data("thpLOPIT_unstimulated_mulvey2021")
xx <- commonFeatureNames(thpLOPIT_unstimulated_mulvey2021,
                         thpLOPIT_lps_mulvey2021)

## subset for translocating proteins
fd <- fData(xx[[1]])
sel <- fd |> 
  select(contains("translocation")) |>
  filter_all(any_vars(.==TRUE)) |>
  rownames()
x1 <- xx[[1]][sel, ]
x2 <- xx[[2]][sel, ]

## combine compartments to simplify chord diagram
## for sticker
x1 <- fDataToUnknown(x1, fcol = "localisation.pred", 
                     from = "Nucleolus", to = "Nucleus")
x1 <- fDataToUnknown(x1, fcol = "localisation.pred", 
                     from = "40S/60S Ribosome", to = "unknown")
x2 <- fDataToUnknown(x2, fcol = "localisation.pred", 
                     from = "Nucleolus", to = "Nucleus")
x2 <- fDataToUnknown(x2, fcol = "localisation.pred", 
                     from = "40S/60S Ribosome", to = "unknown")

## set colour scheme for chordDiagram
mycol <- c("#332288", "#AA4499", "#0170b4", "#88CCEE", "#204f20",
           "#D55E00", "#b80404", "#E18493", "#53CAB7")
scales::show_col(mycol)
colscheme <- c(mycol, "grey")
colscheme <- setNames(colscheme, 
                      c(getMarkerClasses(x1, "localisation.pred"), "unknown"))

## get data.frame of translocations between conditions
## using plotTable function from bandle
df <- plotTable(list(x1, x2), fcol = "localisation.pred")

## We could use the plotTranslocations from bandle will use
## custom code for the sticker 
# plotTranslocations(list(x1, x2), fcol = "localisation.pred", type = "chord")

## use circlize package to generate chord plot of translocations
customChord <- function(df, cols, ...) {
  if (missing(cols)) {
    ll <- unique(c(levels(df[,1]), levels(df[,2])))
    grid.col <- segcols <- setNames(rainbow(length(ll)), ll)
  } else {
    grid.col <- cols
  }
  chordDiagram(df, annotationTrack = "grid",
               preAllocateTracks = 1,
               grid.col = grid.col,
               directional = 1,
               direction.type = c("diffHeight", "arrows"),
               link.arr.type = "big.arrow", ...)
  circos.trackPlotRegion(track.index = 1, panel.fun = function(x, y) {
    xlim = get.cell.meta.data("xlim")
    ylim = get.cell.meta.data("ylim")
    sector.name = get.cell.meta.data("sector.index")
  }, bg.border = NA)
  # circos.clear()
}

## plot and save image
# pdf("images/bandle_chord.pdf", bg = "transparent")
# png("images/bandle_chord.pdf", bg = "transparent", units = "px")
set.seed(1)
circos.clear()
circos.par(gap.degree = 2)
customChord(df, cols = colscheme, diffHeight  = -0.01,
            transparency = 0.3, link.sort = FALSE)
# dev.off()
