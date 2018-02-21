library(ggplot2)
library(png)
library(grid)
library(hexSticker)

## Settings:
## Bioconductor blue: #3792AD
## Bioconductor green: #8ACA25
## Grey: #696E76
col_border <- "#4B77BE"  ## Steel Blue
col_bg <- "#ABB7B7"      ## Edward
## col_bg <- "#ffffff"
col_text <- "#FFFFFF"    ## white

## col_border <- "#8ACA25"  ## BioC green

img <- readPNG("./lamb-peitler.png")
img_lamb <- rasterGrob(img, width = 1.0, x = 0.5, y = 0.6,
                       interpolate = TRUE)
gg <- ggplot() +
    annotation_custom(img_lamb) +
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
        filename="CSAMA2018.png",
        spotlight = TRUE,
        l_x = 1.025, p_color = col_text,
        url = "www.bioconductor.org",
        u_color = col_border
        )

## col_text <- "#FFFFFF"    ## white
## col_border <- "#3792AD"  ## BioC blue
## col_bg <- "#696E76"      ## Dark grey
## sticker(gg,
##         package="CSAMA2018",
##         p_size = 7.3,
##         s_x = 1.03,
##         s_y = 0.73,
##         s_width = 2.1,
##         s_height = 1.1,
##         h_fill = col_bg,
##         h_color = col_border,
##         p_family = "Aller_Lt",
##         filename="CSAMA2018_dark.png",
##         spotlight = TRUE,
##         l_x = 1.025, p_color = col_text,
##         url = "www.bioconductor.org",
##         u_color = col_border
##         )

## col_text <- "#FFFFFF"    ## white
## col_border <- "#3792AD"  ## BioC blue
## col_bg <- "#ABB7B7"      ## Edward
## sticker(gg,
##         package="CSAMA2018",
##         p_size = 7.3,
##         s_x = 1.03,
##         s_y = 0.73,
##         s_width = 2.1,
##         s_height = 1.1,
##         h_fill = col_bg,
##         h_color = col_border,
##         p_family = "Aller_Lt",
##         filename="CSAMA2018_grey.png",
##         spotlight = TRUE,
##         l_x = 1.025, p_color = col_text,
##         url = "www.bioconductor.org",
##         u_color = col_border
##         )

