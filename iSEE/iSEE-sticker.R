library(ggplot2)
library(png)
library(grid)
library(hexSticker)

## Settings:
## Bioconductor blue: #3792AD
## Bioconductor green: #8ACA25

# in honor of the conference where it all began, #euroBioc2017
col_border <- "#A3C1AD"                 # Cambridge Blue
col_bg <- "#FFFFFF"      ## classic white
col_text <- "#000000"    ## black

## col_border <- "#8ACA25"  ## BioC green

img_file <- ("./glasses_empty.png")
img_file <- ("./glasses_full_draft.png")
img_file <- ("./glasses_full.png")
img <- readPNG(img_file)
# img_glasses <- rasterGrob(img, width = 1.0, x = 0.5, y = 0.6,
                       # interpolate = TRUE)

sticker(img_file,
        package="iSEE",
        p_size = 9.3,
        p_family = "Aller_Lt",
        p_color = col_text,
        s_x = 1,
        s_y = 0.83,
        s_width = 0.95,
        # s_height = 1.1,
        h_fill = col_bg,
        h_color = col_border,
        spotlight = FALSE,
        url = "www.bioconductor.org",
        u_color = col_border,
        filename="iSEE.png",
)



# gg <- ggplot() +
#   annotation_custom(img) +
#   theme_void()

# generating the plots in the lenses via iSEE itself, using the TCGA data
# following instance defined here: https://github.com/LTLA/iSEE2018/blob/master/tours/tcga/

# as in data.R ------------------------------------------------------------

library(SingleCellExperiment)
library(ExperimentHub)
library(scater)
library(irlba)
library(Rtsne)
library(edgeR)
library(HDF5Array)

#########################################
# Downloading

ehub <- ExperimentHub::ExperimentHub()
eh1 <- ehub[["EH1"]] # an ExpressionSet
eh1044 <- ehub[["EH1044"]] # a SummarizedExperiment

se1 <- as(eh1, "SummarizedExperiment")
sce1 <- as(se1, "SingleCellExperiment")
sce1044 <- as(eh1044, "SingleCellExperiment")

#########################################
# Merging

# Prepare colData of identical dimensions prior to merging
# In addition, add a "CNTL" colData field to differentiate control and cancer samples

sce1044_colData <- DataFrame(matrix(
  data = NA, nrow = ncol(sce1044), ncol = ncol(colData(sce1)),
  dimnames = list(colnames(sce1044), colnames(colData(sce1)))
))
sce1044_colData$bcr_patient_barcode <- rownames(sce1044_colData)
sce1044_colData$CancerType <- sce1044$type
sce1044_colData$CNTL <- factor(TRUE, c(TRUE, FALSE))
colData(sce1044) <- sce1044_colData

sce1$CNTL <- factor(FALSE, c(TRUE, FALSE))

# Keep only controls for the available cancer types
sce1044 <- sce1044[,sce1044$CancerType %in% sce1$CancerType]
sce1044$CancerType <- droplevels(sce1044$CancerType)

# Rename identical "counts" assay names prior to merging

assayNames(sce1) <- "counts"
assayNames(sce1044) <- "counts"

# Merge the two objects

sce <- cbind(sce1, sce1044)

#########################################
# Add library size and CPM

colData(sce)[,"librarySize"] <- colSums(assay(sce, "counts"))
assay(sce, "log2CPM") <- cpm(assay(sce, "counts"), log = TRUE, prior.count = 0.25)

#########################################
# Dimensionality reduction

set.seed(12321)
sce <- runPCA(sce, exprs_values = "log2CPM")
irlba_out <- irlba(assay(sce, "log2CPM"))
tsne_out <- Rtsne(irlba_out$v, pca = FALSE, perplexity = 50, verbose = TRUE)
reducedDim(sce, "TSNE") <- tsne_out$Y

#########################################
# Saving the assay as HDF5-backed arrays

# h5filename <- "sce.h5"
# assay(sce, "counts") <- writeHDF5Array(assay(sce, "counts"), h5filename, "counts", chunkdim = c(100, 100), verbose=TRUE)
# assay(sce, "log2CPM") <- writeHDF5Array(assay(sce, "log2CPM"), h5filename, "log2CPM", chunkdim = c(100, 100), verbose=TRUE)
# saveRDS(file="sce.rds", sce)


# as in app.R -------------------------------------------------------------
library(iSEE)

# sce <- readRDS("sce.rds")
# tour <- read.delim("tour.txt", sep=";", stringsAsFactors = FALSE, row.names = NULL)
# path(assay(sce, "counts")) <- "sce.h5" 
# path(assay(sce, "log2CPM")) <- "sce.h5"

#######################################################
# Panel 1: colData (phenotype selection)
# Y = CancerType
# X = Gender
# select breast cancer female patients

cd <- colDataPlotDefaults(sce, 2)

# data
cd$DataBoxOpen <- c(TRUE, FALSE)
cd$YAxis <-  c("CancerType", "her2_status_by_ihc")
cd$XAxis <- c("Column data", "Column data")
cd$XAxisColData <- c("CNTL","CNTL")

# visual
cd$VisualBoxOpen <- c(TRUE, FALSE)
cd$ColorBy <- c("Column data", "None")
cd$ColorByColData <- c("CancerType", "CancerType")
cd$VisualChoices <- list(
  c("Color", "Points", "Other"),
  c("Color")
)
cd$PointAlpha <- c(0.25, 1)
cd$Downsample <- TRUE
cd$SampleRes <- 200
cd$LegendPosition <- c("Right", "Bottom")

# point selection
cd$BrushData <- list(
  # (female BRCA patients)
  list(
    xmin = 0.45, xmax = 2.55, ymin = 1.45, ymax = 2.55, mapping = list(x = "X", y = "Y"),
    domain = list(left = 0.4, right = 2.6, bottom = 0.4, top = 20.6),
    range = list(left = 55.8972468964041, right = 253.520547945205, bottom = 432.984589041096, top = 24.0290131340161),
    log = list(x = NULL, y = NULL), direction = "xy",
    brushId = "colDataPlot1_Brush", outputId = "colDataPlot1"),
  list(
    xmin = 1.45, xmax = 2.55, ymin = 4.45, ymax = 6.55, mapping = list(x = "X", y = "Y"),
    domain = list(left = 0.4, right = 2.6, bottom = 0.4, top = 6.6),
    range = list(left = 95.3796687714041, right = 368.520547945205, bottom = 543.693573416096, top = 24.8879973724842),
    log = list(x = NULL, y = NULL), direction = "xy",
    brushId = "colDataPlot2_Brush", outputId = "colDataPlot2")
)
cd$SelectBoxOpen <- c(FALSE, TRUE)
cd$SelectByPlot <- c("---", "Column data plot 1")
cd$SelectEffect <- c("Transparent", "Restrict")

#######################################################
# Panel 2: reduced dimensions (overview)
# selection: tSNE
# color: colData > CancerType
# downsample for speed (tSNE): 100
# panel width: 5
# legend position: right

rd <- redDimPlotDefaults(sce, 1)

# data
rd$Type <- "TSNE"

# visual
rd$VisualBoxOpen <- TRUE
rd$VisualChoices[[1]] <- c("Color", "Points", "Other")
rd$ColorBy <- "Column data"
rd$ColorByColData <- "CNTL"
rd$Downsample <- TRUE
rd$SampleRes <- 200
rd$LegendPosition <- "Bottom"

# select
rd$SelectBoxOpen <- TRUE
rd$SelectByPlot <- c("Column data plot 1")
rd$SelectAlpha <- 0.05

#######################################################
# Panel 3: feature assay (analysis)

fe <- featAssayPlotDefaults(sce, 1)

# data
fe$DataBoxOpen <- TRUE
fe$Assay <- 2
fe$XAxis <- "Column data"
fe$XAxisColData <- "CNTL"
fe$YAxisFeatName <- match("ERBB2", rownames(sce))

# visual
fe$VisualBoxOpen <- TRUE
fe$VisualChoices[[1]] <- c("Points")
fe$Downsample <- TRUE
fe$SampleRes <- 200

# select
fe$SelectBoxOpen <- TRUE
fe$SelectByPlot <- c("Column data plot 1")
fe$SelectEffect <- "Restrict"

#######################################################
# Panel 4: heatmap

hm <-  heatMapPlotDefaults(sce, 1)

# feature data
hm$FeatNameBoxOpen <- TRUE
hm$Assay <- 2
heatmaFeatureNames <- rev(c(
  "ERBB2","HSPA7","HSPA6","GDF6","DNAJA4","KPRP","EEF1A2","TNFAIP2","PDGFB",
  "TSPAN18","HSPA1A","ATP6V0A4","CFB","HSPA1B","EPGN","CALB2","PNMA2","SAA2",
  "CRYAB","KRT80","SRMS","GPR1","UCA1","TNFRSF11B","FAM83A","EPHA3",
  "CXCL5","RGS2","DDAH1","ULBP1","AKAP12","SOD2","KRT19","TLR3","SHC4","PPP1R3C",
  "PTK6","SPON1","MYADM","BST2","GRAMD2","SAA1","HSP90AA1","KRT18","EPHA4",
  "PIK3C2B","KLK6","CXCR1","PGM2L1","ANGPTL4","PAQR7","DAPK1","FAM198B",
  "SERPINB13","GBP6","VWA1","SLC1A1","HSPH1","KITLG","GPRC5A"))
heatmaFeatureIndex <- match(heatmaFeatureNames, rownames(sce))
hm$FeatName <- list(heatmaFeatureIndex)
# scaling
hm$CenterScale <- list(c("Centered", "Scaled"))
hm$Lower <- -2
hm$Upper <- 2

# column data
hm$ColDataBoxOpen <- TRUE
hm$ColData <- list(c("her2_status_by_ihc"))

# select
hm$SelectBoxOpen <- TRUE
hm$SelectByPlot <- c("Column data plot 2")
hm$SelectEffect <- "Restrict"

#######################################################
# Panel setup

initialPanels = DataFrame(
  Name = c(
    "Column data plot 1",
    "Reduced dimension plot 1",
    "Feature assay plot 1",
    "Column data plot 2",
    "Heat map 1",
    "Row statistics table 1"
  ),
  Width = c(
    3, # colData (1)
    4, # reducedDim
    5, # featAssays
    3, # colData (2)
    6, # heatMapPlot
    3 # rowStatTable
  ),
  Height = c(rep(500, 3), rep(600, 3))
)

#######################################################
# App initialization

iSEE(
  sce, 
  # tour = tour,
  redDimArgs = rd, colDataArgs = cd, featAssayArgs = fe,
  rowStatArgs = NULL, rowDataArgs = NULL, heatMapArgs = hm,
  redDimMax = 1, colDataMax = 2, featAssayMax = 1,
  rowStatMax = 1, rowDataMax = 1, heatMapMax = 1,
  initialPanels = initialPanels,
  appTitle = "Exploring the TCGA RNA-seq data after re-processing")


# after exploring live and storing the code -------------------------------

# basically to change the theme...

## The following list of commands will generate the plots created in iSEE
## Copy them into a script or an R session containing your SingleCellExperiment.
## All commands below refer to your SingleCellExperiment object as `se`.

se <- sce
colormap <- ExperimentColorMap()
colormap <- synchronizeAssays(colormap, se)
all_coordinates <- list()
custom_data_fun <- NULL
custom_stat_fun <- NULL

################################################################################
# Defining brushes
################################################################################

all_brushes <- list()
all_brushes[['colDataPlot1']] <- list(xmin = 0.56216090580703, xmax = 2.6, ymin = 1.3639188568183, ymax = 2.6136146234998, 
                                      mapping = list(x = "X", y = "Y", height = "2 * YWidth", width = "2 * XWidth", 
                                                     group = "interaction(X, Y)"), domain = list(left = 0.4, right = 2.6, bottom = 0.4, 
                                                                                                 top = 20.6), range = list(left = 53.1575208690069, right = 186.688188944777, 
                                                                                                                           bottom = 444.054393193493, top = 23.7921069615253), log = list(x = NULL, 
                                                                                                                                                                                          y = NULL), direction = "xy", brushId = "colDataPlot1_Brush", outputId = "colDataPlot1")
all_brushes[['colDataPlot2']] <- list(xmin = 1.45, xmax = 2.55, ymin = 4.45, ymax = 6.55, mapping = list(x = "X", 
                                                                                                         y = "Y"), domain = list(left = 0.4, right = 2.6, bottom = 0.4, top = 6.6), range = list(
                                                                                                           left = 95.3796687714041, right = 368.520547945205, bottom = 543.693573416096, 
                                                                                                           top = 24.8879973724842), log = list(x = NULL, y = NULL), direction = "xy", brushId = "colDataPlot2_Brush", 
                                      outputId = "colDataPlot2")

################################################################################
## Column data plot 1
################################################################################

plot.data <- data.frame(Y = colData(se)[,"CancerType"], row.names=colnames(se));
plot.data$X <- colData(se)[,"CNTL"];
plot.data$ColorBy <- colData(se)[,"CancerType"];
plot.data <- subset(plot.data, !is.na(X) & !is.na(Y));

# Saving data for transmission
all_coordinates[['colDataPlot1']] <- plot.data

# Setting up plot coordinates
set.seed(100);
j.out <- iSEE:::jitterSquarePoints(plot.data$X, plot.data$Y);
summary.data <- j.out$summary;
plot.data$jitteredX <- j.out$X;
plot.data$jitteredY <- j.out$Y;

# Creating the plot
plot.data.pre <- plot.data;
plot.data <- subset(plot.data, subsetPointsByGrid(jitteredX, jitteredY, resolution=200));

ggplot(plot.data) +
  geom_tile(aes(x = X, y = Y, height = 2*YWidth, width = 2*XWidth, group = interaction(X, Y)),
            summary.data, color = 'black', alpha = 0, size = 0.5) +
  geom_point(aes(color = ColorBy, x = jitteredX, y = jitteredY), alpha = 0.25, plot.data, size=1) +
  scale_color_manual(values=colDataColorMap(colormap, "CancerType", discrete=TRUE)(20), na.value='grey50', drop=FALSE) +
  scale_fill_manual(values=colDataColorMap(colormap, "CancerType", discrete=TRUE)(20), na.value='grey50', drop=FALSE) +
  labs(x = "CNTL", y = "CancerType", color = "CancerType", title = "CancerType vs CNTL") +
  scale_x_discrete(drop = FALSE) +
  scale_y_discrete(drop = FALSE) +
  theme_bw() +
  theme(legend.position = 'right', legend.text=element_text(size=9),
        legend.title=element_text(size=11), legend.box = 'vertical',
        axis.text.x = element_text(angle=90, size=10, hjust=1, vjust=0.5),
        axis.text.y = element_text(size=10),
        axis.title=element_text(size=12), title=element_text(size=12)) +
  geom_rect(aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax), color='#DB0230', alpha=0,
            data=do.call(data.frame, all_brushes[['colDataPlot1']][c('xmin', 'xmax', 'ymin', 'ymax')]),
            inherit.aes=FALSE)

################################################################################
## Reduced dimension plot 1
################################################################################

red.dim <- reducedDim(se, 2);
plot.data <- data.frame(X = red.dim[, 1], Y = red.dim[, 2], row.names=colnames(se));
plot.data$ColorBy <- colData(se)[,"CancerType"];
plot.data <- subset(plot.data, !is.na(X) & !is.na(Y));

# Receiving point selection
selected_pts <- shiny::brushedPoints(all_coordinates[['colDataPlot1']], all_brushes[['colDataPlot1']])
plot.data$SelectBy <- rownames(plot.data) %in% rownames(selected_pts);

# Saving data for transmission
all_coordinates[['redDimPlot1']] <- plot.data

# Creating the plot
plot.data.pre <- plot.data;
plot.data <- subset(plot.data, subsetPointsByGrid(X, Y, resolution=200));

ggplot() +
  geom_point(aes(x = X, y = Y, color = ColorBy), alpha=0.3, data=subset(plot.data, !SelectBy), size=1) +
  geom_point(aes(x = X, y = Y, color = ColorBy), alpha=0.3, data=subset(plot.data, SelectBy), color="#FF7B00", size=1) +
  labs(x = "Dimension 1", y = "Dimension 2", color = "CancerType", title = "(2) TSNE") +
  coord_cartesian(xlim = range(plot.data.pre$X, na.rm = TRUE),
                  ylim = range(plot.data.pre$Y, na.rm = TRUE), expand = TRUE) +
  scale_color_manual(values=colDataColorMap(colormap, "CancerType", discrete=TRUE)(20), na.value='grey50', drop=FALSE) +
  scale_fill_manual(values=colDataColorMap(colormap, "CancerType", discrete=TRUE)(20), na.value='grey50', drop=FALSE) +
  theme_bw() +
  theme(legend.position = 'bottom', legend.box = 'vertical', legend.text=element_text(size=9), legend.title=element_text(size=11),
        axis.text=element_text(size=10), axis.title=element_text(size=12), title=element_text(size=12))

################################################################################
## Column data plot 2
################################################################################

plot.data <- data.frame(Y = colData(se)[,"her2_status_by_ihc"], row.names=colnames(se));
plot.data$X <- colData(se)[,"CNTL"];
plot.data <- subset(plot.data, !is.na(X) & !is.na(Y));

# Receiving point selection
selected_pts <- shiny::brushedPoints(all_coordinates[['colDataPlot1']], all_brushes[['colDataPlot1']])
plot.data$SelectBy <- rownames(plot.data) %in% rownames(selected_pts);
plot.data.all <- plot.data;
plot.data <- subset(plot.data, SelectBy);

# Saving data for transmission
all_coordinates[['colDataPlot2']] <- plot.data

# Setting up plot coordinates
set.seed(100);
j.out <- iSEE:::jitterSquarePoints(plot.data$X, plot.data$Y);
summary.data <- j.out$summary;
plot.data$jitteredX <- j.out$X;
plot.data$jitteredY <- j.out$Y;

# Creating the plot
plot.data.pre <- plot.data;
plot.data <- subset(plot.data, subsetPointsByGrid(jitteredX, jitteredY, resolution=200));

ggplot(plot.data) +
  geom_tile(aes(x = X, y = Y, height = 2*YWidth, width = 2*XWidth, group = interaction(X, Y)),
            summary.data, color = 'black', alpha = 0, size = 0.5) +
  geom_point(aes(x = jitteredX, y = jitteredY), alpha = 1, plot.data, color='#000000', size=1) +
  labs(x = "CNTL", y = "her2_status_by_ihc", title = "her2_status_by_ihc vs CNTL") +
  scale_x_discrete(drop = FALSE) +
  scale_y_discrete(drop = FALSE) +
  theme_bw() +
  theme(legend.position = 'bottom', legend.text=element_text(size=9),
        legend.title=element_text(size=11), legend.box = 'vertical',
        axis.text.x = element_text(angle=90, size=10, hjust=1, vjust=0.5),
        axis.text.y = element_text(size=10),
        axis.title=element_text(size=12), title=element_text(size=12)) +
  geom_rect(aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax), color='#DB0230', alpha=0,
            data=do.call(data.frame, all_brushes[['colDataPlot2']][c('xmin', 'xmax', 'ymin', 'ymax')]),
            inherit.aes=FALSE)

################################################################################
## Feature assay plot 1
################################################################################

plot.data <- data.frame(Y=assay(se, 2, withDimnames=FALSE)[5650,], row.names = colnames(se))
plot.data$X <- colData(se)[,"CancerType"];
plot.data$ColorBy <- colData(se)[,"CancerType"];
plot.data <- subset(plot.data, !is.na(X) & !is.na(Y));

# Receiving point selection
selected_pts <- shiny::brushedPoints(all_coordinates[['colDataPlot1']], all_brushes[['colDataPlot1']])
plot.data$SelectBy <- rownames(plot.data) %in% rownames(selected_pts);

# Saving data for transmission
all_coordinates[['featAssayPlot1']] <- plot.data

# Setting up plot coordinates
plot.data$GroupBy <- plot.data$X;
set.seed(100);
plot.data$jitteredX <- iSEE::jitterViolinPoints(plot.data$X, plot.data$Y, 
                                                width=0.4, varwidth=FALSE, adjust=1,
                                                method='quasirandom', nbins=NULL);

# Creating the plot
plot.data.pre <- plot.data;
plot.data <- subset(plot.data, subsetPointsByGrid(jitteredX, Y, resolution=200));

ggplot() +
  geom_violin(aes(x = X, y = Y, group = GroupBy), alpha = 0.2, data=plot.data.pre, scale = 'width', width = 0.8) +
  geom_point(aes(y = Y, color = ColorBy, x = jitteredX), alpha=0.3, data=subset(plot.data, !SelectBy), size=1) +
  geom_point(aes(y = Y, color = ColorBy, x = jitteredX), alpha=0.3, data=subset(plot.data, SelectBy), color="#FF7B00", size=1) +
  labs(x = "CancerType", y = "ERBB2 (log2CPM)", color = "CancerType", title = "ERBB2 vs CancerType") +
  coord_cartesian(ylim = range(plot.data.pre$Y, na.rm=TRUE), expand = TRUE) +
  scale_color_manual(values=colDataColorMap(colormap, "CancerType", discrete=TRUE)(20), na.value='grey50', drop=FALSE) +
  scale_fill_manual(values=colDataColorMap(colormap, "CancerType", discrete=TRUE)(20), na.value='grey50', drop=FALSE) +
  scale_x_discrete(drop = FALSE) +
  theme_bw() +
  theme(legend.position = 'bottom', legend.text=element_text(size=9),
        legend.title=element_text(size=11), legend.box = 'vertical',
        axis.text.x = element_text(angle=90, size=10, hjust=1, vjust=0.5),
        axis.text.y=element_text(size=10),
        axis.title=element_text(size=12), title=element_text(size=12))

################################################################################
## Heat map 1
################################################################################

value.mat <- as.matrix(assay(se, 2)[c(7503L, 9296L, 8336L, 18671L, 22238L, 7017L, 18343L, 6014L, 
                                      4554L, 15350L, 660L, 15736L, 4382L, 9377L, 15856L, 5613L, 9432L, 
                                      8296L, 17985L, 7529L, 1697L, 13804L, 19799L, 16830L, 16382L, 
                                      18504L, 20774L, 9434L, 19610L, 486L, 21938L, 4646L, 17418L, 4379L, 
                                      5612L, 6179L, 21138L, 21882L, 7401L, 19880L, 9474L, 4155L, 17986L, 
                                      16124L, 2706L, 5608L, 8310L, 3478L, 1281L, 8309L, 21540L, 15587L, 
                                      21125L, 5342L, 9410L, 4993L, 7062L, 8316L, 8317L, 5650L), , drop=FALSE]);
plot.data <- reshape2::melt(value.mat, varnames = c('Y', 'X'));

plot.data[['OrderBy1']] <- factor(colData(se)[['her2_status_by_ihc']][match(plot.data$X, rownames(colData(se)))]);
plot.data <- dplyr::arrange(plot.data, OrderBy1);
plot.data$X <- factor(plot.data$X, levels = unique(plot.data$X));

# Receiving selection data
selected_pts <- shiny::brushedPoints(all_coordinates[['colDataPlot2']], all_brushes[['colDataPlot2']])
plot.data$SelectBy <- plot.data$X %in% rownames(selected_pts);
plot.data.all <- plot.data;
plot.data <- subset(plot.data, SelectBy);

# Centering and scaling
plot.data$value <- plot.data$value - ave(plot.data$value, plot.data$Y);
gene.var <- ave(plot.data$value, plot.data$Y, FUN=function(x) { sum(x^2)/(length(x)-1) });
plot.data$value <- plot.data$value/sqrt(gene.var);

# Creating the heat map
p0 <- ggplot(plot.data, aes(x = X, y = Y)) +
  geom_raster(aes(fill = value)) +
  labs(x='', y='') +
  scale_fill_gradientn(colors=c('purple','purple','black','yellow','yellow'),
                       values=c(0,0.321230637449858,0.456482083389419,0.59173352932898,1),
                       limits=c(-6.75012500189321,8.03714759328281), na.value='grey50') +
  scale_y_discrete(expand=c(0, 0)) +
  theme(axis.text.x=element_blank(), axis.ticks.x=element_blank(), axis.line=element_blank());
heatlegend <- cowplot::get_legend(p0 + theme(legend.position='bottom'));

# Adding annotations
legends <- list()

p1 <- ggplot(plot.data, aes(x = X, y = 1)) +
  geom_raster(aes(fill = OrderBy1)) +
  labs(x='', y='') +
  scale_y_continuous(breaks=1, labels='her2_status_by_ihc') +
  scale_fill_manual(values=colDataColorMap(colormap, 'her2_status_by_ihc', discrete=TRUE)(6), na.value='grey50', drop=FALSE, name='her2_status_by_ihc') +
  theme(axis.text.x=element_blank(), axis.ticks=element_blank(), axis.title.x=element_blank(),
        rect=element_blank(), line=element_blank(), axis.title.y=element_blank(),
        plot.margin = unit(c(0,0,-0.5,0), 'lines'));
legends[[1]] <- cowplot::get_legend(p1 + theme(legend.position='bottom', plot.margin = unit(c(0,0,0,0), 'lines')));

# Laying out the grid
cowplot::plot_grid(
  cowplot::plot_grid(
    p1 + theme(legend.position='none'),
    p0 + theme(legend.position='none'),
    ncol=1, align='v', rel_heights=c(0.1, 1)),
  heatlegend, ncol=1, rel_heights=c(0.9, 0.1))

################################################################################
## To guarantee the reproducibility of your code, you should also
## record the output of sessionInfo()
sessionInfo()

## selecting now

red.dim <- reducedDim(se, 2);
plot.data <- data.frame(X = red.dim[, 1], Y = red.dim[, 2], row.names=colnames(se));
plot.data$ColorBy <- colData(se)[,"CancerType"];
plot.data <- subset(plot.data, !is.na(X) & !is.na(Y));

# Receiving point selection
selected_pts <- shiny::brushedPoints(all_coordinates[['colDataPlot1']], all_brushes[['colDataPlot1']])
plot.data$SelectBy <- rownames(plot.data) %in% rownames(selected_pts);

# Saving data for transmission
all_coordinates[['redDimPlot1']] <- plot.data

# Creating the plot
plot.data.pre <- plot.data;
plot.data <- subset(plot.data, subsetPointsByGrid(X, Y, resolution=200));

## lens 1   
lens1plot <- 
  ggplot() +
  geom_point(aes(x = X, y = Y, color = ColorBy), alpha=0.3, data=subset(plot.data, !SelectBy), size=1) +
  geom_point(aes(x = X, y = Y, color = ColorBy), alpha=0.3, data=subset(plot.data, SelectBy), color="#FF7B00", size=1) +
  labs(x = "Dimension 1", y = "Dimension 2", color = "CancerType", title = "(2) TSNE") +
  coord_cartesian(xlim = range(plot.data.pre$X, na.rm = TRUE),
                  ylim = range(plot.data.pre$Y, na.rm = TRUE), expand = TRUE) +
  scale_color_manual(values=colDataColorMap(colormap, "CancerType", discrete=TRUE)(20), na.value='grey50', drop=FALSE) +
  scale_fill_manual(values=colDataColorMap(colormap, "CancerType", discrete=TRUE)(20), na.value='grey50', drop=FALSE) +
  theme_bw() +
  theme(legend.position = 'bottom', legend.box = 'vertical', legend.text=element_text(size=9), legend.title=element_text(size=11),
        axis.text=element_text(size=10), axis.title=element_text(size=12), title=element_text(size=12))


## lens 2
plot.data <- data.frame(Y=assay(se, 2, withDimnames=FALSE)[5650,], row.names = colnames(se))
plot.data$X <- colData(se)[,"CancerType"];
plot.data$ColorBy <- colData(se)[,"CancerType"];
plot.data <- subset(plot.data, !is.na(X) & !is.na(Y));

# Receiving point selection
selected_pts <- shiny::brushedPoints(all_coordinates[['colDataPlot1']], all_brushes[['colDataPlot1']])
plot.data$SelectBy <- rownames(plot.data) %in% rownames(selected_pts);

# Saving data for transmission
all_coordinates[['featAssayPlot1']] <- plot.data

# Setting up plot coordinates
plot.data$GroupBy <- plot.data$X;
set.seed(100);
plot.data$jitteredX <- iSEE::jitterViolinPoints(plot.data$X, plot.data$Y, 
                                                width=0.4, varwidth=FALSE, adjust=1,
                                                method='quasirandom', nbins=NULL);

# Creating the plot
plot.data.pre <- plot.data;
plot.data <- subset(plot.data, subsetPointsByGrid(jitteredX, Y, resolution=200));

lens2plot <- 
  ggplot() +
  geom_violin(aes(x = X, y = Y, group = GroupBy), alpha = 0.2, data=plot.data.pre, scale = 'width', width = 0.8) +
  geom_point(aes(y = Y, color = ColorBy, x = jitteredX), alpha=0.3, data=subset(plot.data, !SelectBy), size=1) +
  geom_point(aes(y = Y, color = ColorBy, x = jitteredX), alpha=0.3, data=subset(plot.data, SelectBy), color="#FF7B00", size=1) +
  labs(x = "CancerType", y = "ERBB2 (log2CPM)", color = "CancerType", title = "ERBB2 vs CancerType") +
  coord_cartesian(ylim = range(plot.data.pre$Y, na.rm=TRUE), expand = TRUE) +
  scale_color_manual(values=colDataColorMap(colormap, "CancerType", discrete=TRUE)(20), na.value='grey50', drop=FALSE) +
  scale_fill_manual(values=colDataColorMap(colormap, "CancerType", discrete=TRUE)(20), na.value='grey50', drop=FALSE) +
  scale_x_discrete(drop = FALSE) +
  theme_bw() +
  theme(legend.position = 'bottom', legend.text=element_text(size=9),
        legend.title=element_text(size=11), legend.box = 'vertical',
        axis.text.x = element_text(angle=90, size=10, hjust=1, vjust=0.5),
        axis.text.y=element_text(size=10),
        axis.title=element_text(size=12), title=element_text(size=12))


## applying the themes and saving

lens1plot_final <- 
  lens1plot + theme_void() + ggtitle(label = "") + theme(legend.position="none")

lens2plot_final <- 
  lens2plot + theme_void() + ggtitle(label = "") + theme(legend.position="none")

ggsave("lens1plot.png", lens1plot_final, height = 10, width = 10, dpi = 300)
ggsave("lens2plot.png", lens2plot_final, height = 7, width = 10, dpi = 300)



