## ideas:

library("macrophage")
library("DESeq2")
library("org.Hs.eg.db")
library("AnnotationDbi")
library("pcaExplorer")
library("ideal")
library("GeneTonic")
library("ggplot2")

# dds object
data("gse", package = "macrophage")
dds_macrophage <- DESeqDataSet(gse, design = ~ line + condition)
rownames(dds_macrophage) <- substr(rownames(dds_macrophage), 1, 15)
dds_macrophage <- estimateSizeFactors(dds_macrophage)

vst_macrophage <- vst(dds_macrophage)
rld_macrophage <- rlog(dds_macrophage)


anno_df <- data.frame(
  gene_id = rownames(dds_macrophage),
  gene_name = mapIds(org.Hs.eg.db,
    keys = rownames(dds_macrophage),
    column = "SYMBOL",
    keytype = "ENSEMBL"
  ),
  stringsAsFactors = FALSE,
  row.names = rownames(dds_macrophage)
)

# de
data(res_de_macrophage, package = "GeneTonic")
res_de <- res_macrophage_IFNg_vs_naive

set.seed(5983)
to_keep <- sample(c(1:17806), size = 10000)

res_de_subset <- res_de[to_keep, ]

# res_enrich object
data(res_enrich_macrophage, package = "GeneTonic")
res_enrich <- shake_topGOtableResult(topgoDE_macrophage_IFNg_vs_naive)
res_enrich <- get_aggrscores(res_enrich, res_de, anno_df)

sig_genes <- intersect(
  mapIds(org.Hs.eg.db,
         keys = strsplit(res_enrich$gs_genes[3], ",")[[1]],
         column = "ENSEMBL",
         keytype = "SYMBOL"
  ),
  rownames(res_de_subset)
)

(p_ma <- ideal::plot_ma(res_obj = res_de_subset, 
                        draw_y0 = FALSE,
                        point_alpha = 1,
                        add_rug = FALSE, 
                        sig_color = "#DB4437",
                        intgenes = sig_genes, 
                        labels_intgenes = FALSE
                        ) + 
    theme_void() + 
    theme(legend.position = "none")
)

(p_hm <- GeneTonic::gs_heatmap(
  se = vst_macrophage[, vst_macrophage$condition_name %in% c("IFNg", "naive")], 
  res_de = res_de_subset,
  annotation_obj = anno_df,
  genelist = sig_genes, 
  cluster_columns = TRUE, cluster_rows = TRUE 
))

ggsave(p_ma, filename = "ideal_maplot.png", 
       width = 15, height = 10, 
       bg = "transparent")

png(filename = "ideal_heatmap.png", 
    width = 800, height = 800,
    bg = "transparent")
ComplexHeatmap::draw(p_hm)
dev.off()

library("png")
library("grid")
library("hexSticker")

## Settings:
col_border <- "#618fa7"            ## ideal green
col_bg <- "#FFFFFF"                ## white
col_text <- "#FFFFFF"              ## white

img_file <- ("assembled_image.png")
img <- readPNG(img_file)

sticker(img_file,
        package="", # will be already in the image
        p_size = 7.5,
        p_family = "Aller_Lt",
        p_color = col_text,
        s_x = 1,
        s_y = 1.1,
        s_width = 1,
        s_height = 0.85,
        h_fill = col_bg,
        h_color = col_border,
        h_size = 1.5,
        spotlight = FALSE,
        url = "www.bioconductor.org",
        u_color = col_border,
        white_around_sticker = TRUE,
        filename="ideal.pdf"
)




