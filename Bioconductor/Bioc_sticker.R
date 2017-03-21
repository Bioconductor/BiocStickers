library("hexSticker")
## GithubSHA1: 89e4d60a370f0457a0c4c08a95d4065e29275809

bioc_blue <- "#1892AA"
bioc_green <- "#99C53C"

sticker("biocnote.png", package = "Bioconductor",
        p_size = 16,
        p_y = 1.47,
        p_color = bioc_blue,
        s_x = 1.25, s_y = 0.8,
        s_width = 0.55, s_height = 0.55,
        h_color = bioc_blue,
        h_fill = "#FFFFFF")

sticker("biocnote.png", package = "",
        p_size = 16,
        p_y = 1.47,
        p_color = bioc_blue,
        s_x = 1.15, s_y = 0.93,
        s_width = 0.65, s_height = 0.65,
        h_color = bioc_blue,
        h_fill = "#FFFFFF",
        filename = "Bioconductor2.png")

hex <- hexSticker:::make_hex(size = 1.2, fill = "#FFFFFF", color = bioc_blue)
subplot <- hexSticker:::toGrob("biocnote.png")
x <- ggtree:::subview(hex, subplot,
                      x = 1.0, y = 0.97,
                      width = 0.67, 
                      height = 0.67)
x <- hexSticker:::add_pkg_name(x, "Bio", 0.45, 1, bioc_green, "Aller_Rg", 18)
x <- hexSticker:::add_pkg_name(x, "conductor", 1.20, 1, bioc_blue, "Aller_Rg", 18)
hexSticker:::save_sticker(x, "Bioconductor5.png")


## Note with small Bioconductor logo overlay.
library(ggplot2)
library(grid)
library(png)
library(sysfonts)
library(showtext)
font_family <- "Aller_Lt"
x_text <- 0.775
y_text <- 0.97
img <- readPNG("./biocnote.png")
g_img <- rasterGrob(img, width = 0.8, x = 0.5, interpolate = TRUE)
fonts <- list.files(system.file("fonts", package="hexSticker"),
                    pattern="ttf$", recursive=TRUE, full.names=TRUE)
i <- font_family == sub(".ttf", "", basename(fonts))
if (any(i)) {
    font.add(font_family, fonts[which(i)[1]])
    showtext.auto()
}
gg <- ggplot() +
    geom_rect(aes(xmin = 0, xmax = 1.5, ymin = 0, ymax = 1.5), fill = NA) +
    annotation_custom(g_img, xmin = 0, ymin = 0) +
    annotate("text", x = x_text - 0.365, y = y_text, label = "i",
             color = bioc_green, size = 4, family = font_family) +
    annotate("text", x = x_text, y = y_text, label = "B oconductor",
             color = bioc_blue, size = 4, family = font_family) +
    theme_void()
sticker(gg, package = "",
        s_x = 1.0, s_y = 0.93,
        s_width = 0.95, s_height = 0.95,
        h_color = bioc_blue,
        h_fill = "#FFFFFF",
        filename = "Bioconductor3.png")

## Green "Bio" and blue "conductor"
font_family <- "Aller_Lt"
x_text <- 0.28
y_text <- 0.97
img <- readPNG("./biocnote.png")
g_img <- rasterGrob(img, width = 0.8, x = 0.5, interpolate = TRUE)
fonts <- list.files(system.file("fonts", package="hexSticker"),
                    pattern="ttf$", recursive=TRUE, full.names=TRUE)
i <- font_family == sub(".ttf", "", basename(fonts))
if (any(i)) {
    font.add(font_family, fonts[which(i)[1]])
    showtext.auto()
}
gg <- ggplot() +
    geom_rect(aes(xmin = 0, xmax = 1.5, ymin = 0, ymax = 1.5), fill = NA) +
    annotation_custom(g_img, xmin = 0, ymin = 0) +
    annotate("text", x = x_text, y = y_text, label = "Bio",
             color = bioc_green, size = 4.6, family = font_family) +
    annotate("text", x = x_text + 0.55, y = y_text, label = "conductor",
             color = bioc_blue, size = 4.6, family = font_family) +
    theme_void()
sticker(gg, package = "",
        s_x = 1.025, s_y = 0.9,
        s_width = 0.95, s_height = 0.95,
        h_color = bioc_blue,
        h_fill = "#FFFFFF",
        filename = "Bioconductor4.png")
