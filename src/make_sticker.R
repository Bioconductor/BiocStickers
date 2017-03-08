##' This function can be used to create a hexagonal sticker following
##' the guidelines described in the BioC-sticker sticker
##' repository. The function requires the following packages: ggplot2,
##' ggforce, ggtree, showtext and grid, if lattice objects are used.
##'
##' @title Create a BioC sticker.
##' @param x The package logo. Can either be a ggplot, lattice or grob
##'     object.
##' @param package Package name, to be used as label on the
##'     sticker. Default is "MyPackage".
##' @param text_size Label font size. Default is 27.
##' @param col_text Label font colour. Default is \code{"#E4F1FE"}.
##' @param col_background Background colour. Default is
##'     \code{"#446CB3"}.
##' @param col_border Border colour. Default is \code{"#59ABE3"}.
##' @param grob_xmin Left position of the image. Default is -0.03.
##' @param grob_xmax Right position of the image. Default is 2.
##' @param grob_ymin Bottom position of the image. Default is 0.05.
##' @param grob_ymax Top position of the image. Default is 1.75.
##' @param text_x Text horizontal alignment. Default is 1.
##' @param text_y Text vertical alignment. Default is 1.44.
##' @param filename By default, the sticker is saved saved printed to
##'     a png file named after the \code{package} name. If you prefer
##'     not to create any file, set to \code{NULL}.
##' @return Invisibly returns the \code{ggplot} sticker
##'     object. Creates a png file as side effect, unless
##'     \code{filename} is \code{NULL}.
##' @author Laurent Gatto and Guangchuang Yu
##' @examples
##' stkr <- make_sticker(package = "Bioconductor",
##'                      filename = NULL)
##' print(stkr)
##' library("ggplot2")
##' p <- ggplot(aes(x = mpg, y = wt), data = mtcars) + geom_point()
##' x <- make_sticker(p, "Bioconductor", filename = NULL,
##'                   grob_xmin = 0.5, grob_xmax = 1.5,
##'                   grob_ymin = .35, grob_ymax = 1.25)
##' x
make_sticker <- function(x,
                         package = "MyPackage",
                         text_size = 27,
                         col_text = "#E4F1FE",
                         col_background = "#446CB3",
                         col_border = "#59ABE3",
                         grob_xmin = -.03,
                         grob_xmax = 2,
                         grob_ymin = 0.05,
                         grob_ymax = 1.75,
                         text_x = 1,
                         text_y = 1.44,
                         filename = paste(package, "png", sep = ".")) {
    library("ggplot2")
    library("ggforce")
    suppressPackageStartupMessages(library("ggtree"))
    library("showtext")

    fonturl <- "https://rawgit.com/jotsetung/BioC-stickers/master/fonts/Aller/Aller_Rg.ttf"
    font.add("Aller", fonturl)

    d <- data.frame(x0 = 1, y0 = 1, r = 1)
    hex <- ggplot() +
        geom_circle(aes(x0 = x0, y0 = y0, r = r),
                    size = 4, data = d, n = 5.5,
                    fill = col_background, color = col_border) +
        coord_fixed()
    sticker <- hex + theme_transparent() +
        theme(strip.text = element_blank()) +
        xlim_tree(3.8) +
        theme(line = element_blank(),
              text = element_blank(),
              title = element_blank())

    if (!missing(x)) {
        if (inherits(x, "ggplot"))
            x <- ggplotGrob(x)
        if (inherits(x, "lattice")) {
            library("grid")
            x <- grid.grabExpr(x)
        }
        stopifnot(inherits(x, "grob"))
        sticker <- sticker +
            annotation_custom(x,
                              xmin = grob_xmin, xmax = grob_xmax,
                              ymin = grob_ymin, ymax = grob_ymax) 
    }

    sticker <- sticker + 
        annotate('text', x = text_x, y = text_y, label = package,
                 family = 'Aller', size = text_size, color = col_text) +
        scale_y_continuous(expand = c(0, 0), limits = c(-.015, 2.02)) +
        scale_x_continuous(expand = c(0, 0), limits = c(.13, 1.88)) +
        theme(plot.margin = unit(c(0, 0, 0, 0), "lines"))

    if (!is.null(filename))
        ggsave(sticker, width = 6, height = 6.9,
               file = filename,
               bg = 'transparent')
    invisible(sticker)
}
