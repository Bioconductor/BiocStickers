if (!require('hexSticker')) install.packages('hexSticker')

library(hexSticker)
imgurl <- "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Emojione_1F30A.svg/512px-Emojione_1F30A.svg.png"
sticker(imgurl, package="zinbwave",
        s_x=1, s_y=.8, s_width=.5, s_height=.5,
        h_color="#ff9966", h_fill="white", p_color = "#4E94B5",
        filename="zinbwave.png")

