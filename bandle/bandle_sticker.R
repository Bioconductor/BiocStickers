library(hexSticker)

p_size <- 24  # size of package name
p_y <- 1.4  # position of package name
p_color <- "#FFFFFFDD"
h_color <- "#C5EFF7"
h_fill <-  "#336E7B"
u_color <- "#FFFFFF"
u_size <- 3.7  # url size
u_x <- 1.01
u_y <- 0.08
s_x <- 1  # x and y position of subplot
s_y <- 1.02  
s_width <- .88  # width and height of subplot
s_height <- .008

sticker("images/bandle_chord.png", package = "bandle",
        p_color = p_color,
        p_size = p_size,
        p_y = p_y,
        h_fill = h_fill,
        h_color = h_color,
        s_width = s_width, 
        # s_height = s_height,
        s_x = s_x, 
        s_y = s_y,
        url = "www.bioconductor.org",
        u_color = u_color,
        u_size = u_size,
        u_x = u_x,
        u_y = u_y,
        filename = "bandle.png")

