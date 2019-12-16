# to be done out of this script:
# - import svg of gin tonic
# - export to hi-res png
# - assemble in powerpoint with dna helix
# - group up and export as picture (GT_logo_full.png)

# Assembling all the pieces together --------------------------------------

library(ggplot2)
library(png)
library(grid)
library(hexSticker)

## Settings:
col_border <- "#264095"            ## some nice dark blue
col_bg <- "#1A81C2"                ## nice full blue
col_text <- "#FFFFFF"              ## white

img_file <- ("GT_logo_full.png")
img <- readPNG(img_file)

sticker(img_file,
        package="GeneTonic",
        p_size = 7.5,
        p_family = "Aller_Lt",
        p_color = col_text,
        s_x = 0.92,
        s_y = 0.77,
        s_width = 0.52,
        s_height = 0.52,
        h_fill = col_bg,
        h_color = col_border,
        h_size = 1.5,
        spotlight = FALSE,
        url = "www.bioconductor.org",
        u_color = col_border,
        filename="GeneTonic.pdf"
)

# afterwards: export to png via Preview or similar applications

