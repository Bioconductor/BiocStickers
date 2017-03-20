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
