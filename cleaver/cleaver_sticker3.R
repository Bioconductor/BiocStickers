library("sticker")
library("ggtree")
library("ggforce")
library("showtext")

ccol <- c(package="#FFFFFF",
          text="#A3ACBF",
          border="#5D6F95",
          background="#2E4372",
          pacman="#0E224E",
          eye="#020F2B")

font.add("Aller", system.file(file.path("fonts", "Aller", "Aller_Rg.ttf"), package="sticker"))
showtext.auto()

## pacman body
sticker  <- ggplot() +
            geom_arc_bar(aes(x0=0.8, y0=0.8, r0=0, r=0.25,
                             start=pi / 4, end=-(5 * pi) / 4,
                             fill="pacman", colour="pacman"),
                         show.legend=FALSE) +
            scale_fill_manual(values=ccol) +
            scale_colour_manual(values=ccol) +
            coord_fixed() +
            theme_transparent() +
            theme(strip.text = element_blank(),
                  line = element_blank(),
                  text = element_blank(),
                  title = element_blank()) +

            ## pacman eye
            geom_arc_bar(aes(x0=0.77, y0=0.92, r0=0, r=0.05,
                             start=0, end=2 * pi,
                             fill="eye", colour="eye"),
                         show.legend=FALSE) +

            ## peptide "LAAGKVEDSD"
            annotate("text", x=1.2, y=0.8, label="VEDSD",
                     family="Aller", size=14, color=ccol["text"]) +
            annotate("text", x=0.7, y=0.6, label="LAAGK", angle=45,
                     family="Aller", size=14, color=ccol["text"])

make_sticker(sticker,
             package="cleaver",
             text_size=32,
             col_background=ccol["background"],
             col_border=ccol["border"],
             col_text=ccol["package"],
             filename="cleaver3.png")
