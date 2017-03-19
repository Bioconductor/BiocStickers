library("hexSticker")
## GithubSHA1: 89e4d60a370f0457a0c4c08a95d4065e29275809

p_size <- 24
p_y <- 1.4
p_color <- "#FFFFFFDD"
h_color <- "#C5EFF7"
h_fill <-  "#336E7B"
s_x <- 0.94
s_y <- 0.87
s_width <- 0.9
s_height <- 0.9

sticker("img_cog.png", package = "pRoloc",
        p_color = p_color,
        p_size = p_size,
        p_y = p_y,
        h_fill = h_fill,
        h_color = h_color,
        s_width = s_width, s_height = s_height,
        s_x = s_x, s_y = s_y)

sticker("img_pointer.png", package = "pRolocGUI",
        p_color = p_color,
        p_size = p_size,
        p_y = p_y,
        h_fill = h_fill,
        h_color = h_color,
        s_width = s_width, s_height = s_height,
        s_x = s_x, s_y = s_y)

sticker("img_file.png", package = "pRolocdata",
        p_color = p_color,
        p_size = p_size,
        p_y = p_y,
        h_fill = h_fill,
        h_color = h_color,
        s_width = s_width, s_height = s_height,
        s_x = s_x, s_y = s_y)

