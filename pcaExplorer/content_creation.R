## ideas:
# google palette - a la spectral
# transparency
# black, clean background
# put the arrow on pca plot to specify axes


library("macrophage")
library("DESeq2")
library("org.Hs.eg.db")
library("AnnotationDbi")
library("pcaExplorer")
library("ggplot2")

# dds object
data("gse", package = "macrophage")
dds_macrophage <- DESeqDataSet(gse, design = ~ line + condition)
rownames(dds_macrophage) <- substr(rownames(dds_macrophage), 1, 15)
dds_macrophage <- estimateSizeFactors(dds_macrophage)

vst_macrophage <- vst(dds_macrophage)
rld_macrophage <- rlog(dds_macrophage)

arrow_size <- 3
point_size <- 6

pca_df <- pcaplot(vst_macrophage, 
                  ntop = 486,
                  ellipse = FALSE, 
                  point_size = point_size, 
                  title = "", 
                  text_labels = FALSE,
                  returnData = TRUE)

pcaplot(vst_macrophage, 
        ntop = 486,
        ellipse = FALSE, 
        point_size = point_size, 
        title = "", 
        text_labels = FALSE)


(p <- ggplot(data = pca_df, aes(x = PC1, y = PC2)) + 
    geom_point(aes(col = group), size = point_size) + 
    scale_color_brewer(palette = "Spectral") + 
    coord_fixed(xlim = c(-90, 90), ylim = c(-55, 55)) + 
    geom_segment(
      x = -85, xend = 85, y = 0, yend = 0,
      lineend = "round", linejoin = "bevel",
      # color = "grey60",
      color = "grey90",
      size = arrow_size, arrow = arrow(length = unit(0.15, "inches"))
    ) +
    geom_segment(
      x = 0, xend = 0, y = -50, yend = 50,
      lineend = "round", linejoin = "bevel",
      # color = "grey60",
      color = "grey90",
      size = arrow_size, arrow = arrow(length = unit(0.15, "inches"))
    ) + 
    # theme_void() +
    theme(
      legend.position = "none",
      axis.line=element_blank(),
      axis.text.x=element_blank(),
      axis.text.y=element_blank(),
      axis.ticks=element_blank(),
      axis.title.x=element_blank(),
      axis.title.y=element_blank(),
      panel.background = element_rect(fill='transparent'), #transparent panel bg
      plot.background = element_rect(fill='transparent', color=NA), #transparent plot bg
      panel.grid.major = element_blank(), #remove major gridlines
      panel.grid.minor = element_blank(), #remove minor gridlines
      legend.background = element_rect(fill='transparent'), #transparent legend bg
      legend.box.background = element_rect(fill='transparent') #transparent legend panel
    )
)
  # theme(
        # panel.background = element_rect(fill = "transparent"))
# )

ggsave(p, filename = "pcaexplorer_plot.png", 
       width = 15, height = 10, 
       bg = "transparent")




library("png")
library("grid")
library("hexSticker")

## Settings:
col_border <- "#FF9966"            ## was the nice dark blue, now experimenting...
# col_border <- "#007696"            ## was the nice dark blue, now experimenting...
col_bg <- "#000000"                ## go dark this time
col_text <- "#FFFFFF"              ## white

img_file <- ("pcaexplorer_plot.png")
img <- readPNG(img_file)

sticker(img_file,
        package="pcaExplorer",
        p_size = 7.5,
        p_family = "Aller_Lt",
        p_color = col_text,
        s_x = 1,
        s_y = 0.66,
        s_width = 0.95,
        h_fill = col_bg,
        h_color = col_border,
        h_size = 1.5,
        spotlight = FALSE,
        url = "www.bioconductor.org",
        u_color = col_border,
        filename="pcaExplorer.pdf"
)




