library("ggplot2")
library("ggimage")
library("showtext")
library("hexSticker")

ccol <- c(package="#FFFFFF",
          text="#A3ACBF",
          border="#5D6F95",
          background="#2E4372",
          pacman="#0E224E",
          eye="#020F2B")

### text
font.add("Aller", system.file(file.path("fonts", "Aller", "Aller_Rg.ttf"), package="sticker"))
showtext.auto()

gg <- ggplot() +
      theme_void() +
      theme_transparent() +
      xlim(-1, 1) +
      ylim(-1, 1) +
      geom_text(aes_(x=-0.45, y=-0.15, angle=0), label="LAAGK",
                color="#A3ACBF", family="Aller", size=16) +
      geom_image(aes_(x=0.25, y=-0.05, image="imagesrc/cleaver.svg.png", angle=45), size=0.4) +
      geom_text(aes_(x=0.28, y=-0.425, angle=-45), label="VEDSD",
                color="#A3ACBF", family="Aller", size=16)

set.seed(123)
sticker(gg,
        package="cleaver",
        p_color = "#FFFFFF",           # name col
        p_size = 32,
        h_fill = "#2E4372",            # background col
        h_color = "#5D6F95",           # border col
        s_x = 1,
        s_y = 1,
        s_w = 2,
        s_h = 2,
        url = "www.bioconductor.org",
        u_color = "#FFFFFF",
        u_size = 4,
        u_x = 1,
        u_y = 0.07,
        spotlight = TRUE,
        l_alpha = 0.15,
        l_width = 4,
        l_height = 4)
