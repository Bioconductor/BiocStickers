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
        filename="iSEE.pdf",
)



 gg <- ggplot() +
  annotation_custom(img) +
  theme_void()

col_text <- "#000000"    ## white
col_border <- "#3792AD"  ## BioC blue
col_bg <- "#dfdfe2"
sticker(gg,
        package="CSAMA2018",
        p_size = 7.3,
        s_x = 1.03,
        s_y = 0.73,
        s_width = 2.1,
        s_height = 1.1,
        h_fill = col_bg,
        h_color = col_border,
        p_family = "Aller_Lt",
        filename="CSAMA2018mod.png",
        spotlight = TRUE,
        l_x = 1.025, p_color = col_text,
        url = "www.bioconductor.org",
        u_color = col_border
)

