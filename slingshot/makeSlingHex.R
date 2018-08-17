require(hexSticker); require(magick); require(ggplotify); require(pdftools); require(ggplot2)
require(hexbin); require(sysfonts); require(showtext)

# helper functions from the hexSticker package
hexagon <- function(size=1.2, fill="#1881C2", color="#87B13F") {
    ggplot() + geom_hexagon(size=size, fill=fill, color=color) + theme_sticker(size)
}
whiteTrans <- function(alpha = 0.4) {
    function(n) {
        rgb(red = rep(1, n), green = rep(1, n), blue = rep(1, n),
            alpha = seq(0, alpha, length.out = n))
    }
}
spotlight <- function(alpha) {
    ## set.seed(123)
    vals_x <- rnorm(1000000, sd = 2, mean = 0)
    vals_y <- rnorm(1000000, sd = 2, mean = 0)
    hexbinplot(vals_x ~ vals_y, colramp = whiteTrans(alpha), colorkey = FALSE,
        bty = "n", scales = list(draw = FALSE), xlab = "", ylab = "",
        border = NA, par.settings = list(axis.line = list(col = NA)))
}
load_font <- function(family) {
    if (family == "Aller") {
        family <- "Aller_Rg"
    }
    
    fonts <- list.files(system.file("fonts", package="hexSticker"),
        pattern="ttf$", recursive=TRUE, full.names=TRUE)
    i <- family == sub(".ttf", "", basename(fonts))
    if (any(i)) {
        font_add(family, fonts[which(i)[1]])
        showtext_auto()
    }
    return(family)
}
geom_url <- function(url="www.bioconductor.org", x=1, y=0.08, family="Aller_Rg", size=1.5, color="black", angle=30, hjust=0, ...) {
    family <- load_font(family)
    d <- data.frame(x = x,
        y = y,
        url = url)
    geom_text(aes_(x=~x, y=~y, label=~url),
        data = d,
        size = size,
        color = color,
        family = family,
        angle = angle,
        hjust = hjust,
        ...)
}
geom_hexagon <- function(size=1.2, fill="#1881C2", color="#87B13F") {
    ## center <- 1
    ## radius <- 1
    ## d <- data.frame(x0 = center, y0 = center, r = radius)
    ## geom_circle(aes_(x0 = ~x0, y0 = ~y0, r = ~r),
    ##             size = size, data = d, n = 5.5,
    ##             fill = fill, color = color)
    hexd <- data.frame(x = 1+c(rep(-sqrt(3)/2, 2), 0, rep(sqrt(3)/2, 2), 0),
        y = 1+c(0.5, -0.5, -1, -0.5, 0.5, 1))
    hexd <- rbind(hexd, hexd[1, ])
    geom_polygon(aes_(x=~x, y=~y), data=hexd,
        size = size, fill = fill, color = color)
}
theme_sticker <- function(size=1.2, ...) {
    center <- 1
    radius <- 1
    h <- radius
    w <- sqrt(3)/2 * radius
    m <- 1.02
    list(theme_transparent() +
            theme(plot.margin = margin(b = -.2, l= -.2, unit = "lines"),
                strip.text = element_blank(),
                line = element_blank(),
                text = element_blank(),
                title = element_blank(), ...),
        coord_fixed(),
        scale_y_continuous(expand = c(0, size/sqrt(3)/44), limits = c(center-h*m , center+h*m )),
        scale_x_continuous(expand = c(0, 0), limits = c(center-w*m , center+w*m ))
    )
}


########################
# code to produce slingshot hex sticker
########################
hex <- hexagon(size = 1.2, fill = "grey15", color = "#506644FF")

logo_raw <- image_read("logo.pdf", density = 1000)

sticker <- hex + annotation_custom(as.grob(logo_raw),
    xmin = .15, xmax = 1.85, 
    ymin = .18, ymax = 1.88)

sticker <- sticker + geom_subview(subview = spotlight(.2), 
    x = 1, y = 1.55, width = 4, height = 4)

sticker <- sticker + geom_url('www.bioconductor.org', x = 1, y = .08, 
    color = 'white', family="Aller_Rg", size = 1.2, angle = 330, hjust = 'right')

ggsave(filename = 'slingshot.pdf', plot = sticker, width = 43.9, height = 50.8, 
    bg = "transparent", units = "mm", dpi = 1200)

ggsave(filename = 'slingshot.png', plot = sticker, width = 43.9, height = 50.8, 
    bg = "transparent", units = "mm", dpi = 1200)
