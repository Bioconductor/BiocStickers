library(hexSticker)

imgurl <- "https://clipartion.com/wp-content/uploads/2015/11/bird-island-clipart-free-clip-art-images-830x301.png"

sticker(imgurl,
         package="dmrseq", 
         p_size=8, 
         s_x=1,
         s_y=1.2, 
         s_width=0.85, 
         s_height=1,
         p_x = 0.95,
         p_y = 0.6,
         h_color = "gold2",
         h_fill = "dodgerblue",
         p_color = "gold2",
filename="./inst/sticker/dmrseq.png")
