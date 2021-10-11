library(hexSticker)
library(showtext)
font_add_google("Oswald", "oswald")

s <- sticker("mbkmeans2.jpg", package="mbkmeans", 
        p_size=8, p_color = "#ff2726",
        p_family = "oswald",
        p_y=.67, p_x=.7,
        s_y=1, s_width=1.5, s_x=.9,
        filename="mbkmeans_sticker.png",
        h_color="#ffdc4f",
        white_around_sticker = TRUE,
        angle = -45,
        )
plot(s)

## note that the image was modified from unsplash.com
