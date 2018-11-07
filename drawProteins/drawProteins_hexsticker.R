# script to create drawProteins sticker
# setwd("/Users/paulbrennan/Documents/drawProteins_hexsticker")
library(ggplot2)
# install.packages("hexSticker")
library(hexSticker)

library(drawProteins)

data("five_rel_data")
p <- draw_canvas(five_rel_data)
p <- draw_chains(p, five_rel_data, label_chains = FALSE, size =0.2)
p <- draw_domains(p, five_rel_data,
  show.legend = FALSE,
  label_size = 2)
p

p <- draw_phospho(p, five_rel_data)
p <- p  + theme_void()

sticker(p, package="drawProteins", p_size=6, s_x=.98,
  s_y=.88, s_width=1.4, s_height=1.1,h_fill = "#114466", h_color="#001030")

# this doesn't quite work :-(
# size of text is wrong... no labels... cramped!
# I think five proteins is probably too many...

# reduce to three....
# P19838
# Q04206
# Q04864

# get again from UniProt
prot_data <- drawProteins::get_features("Q04206 Q04864 P19838")

# turn the data into a dataframe
prot_data <- drawProteins::feature_to_dataframe(prot_data)

# create canvas
p <- draw_canvas(prot_data)

# customise the labels
p <- draw_chains(p, prot_data, label_size = 1.4,
  labels = c("c-Rel",
    "p50/p105",
    "p50/p105",
    "p65/Rel A"),
  size=0.2)

# draw domains without a legend or labels
p <- draw_domains(p, prot_data, show.legend = FALSE, label_domains = FALSE)

# add text and control size with geom_text rather than labels from drawProteins
p <- p + ggplot2::geom_text(data = prot_data[prot_data$type == "DOMAIN", ],
  ggplot2::aes(x = begin + (end-begin)/2,
               y = order,
               label = description),
           size = 1.3)

# keep phosphorylation sites small
p <- draw_phospho(p, prot_data, size = 1)

# a completely blank theme using theme_void()
p <- p  + theme_void()
p

# make the sticker using the ggplot object entitled p
# creates a png file
sticker(p,
  package="drawProteins",
  p_size=6,  # font size for package name
  s_x=.95,   # x position for ggplot object
  s_y=.86,   # y position for ggplot object
  s_width=1.4,
  s_height=1.1,
  h_fill = "#e8a935",   # background colour for hexagon
  h_color="#001030",    # border colour
  url = "www.bioconductor.org")

# make the PDF
sticker(p,
  package="drawProteins",
  p_size=6,  # font size for package name
  s_x=.95,   # x position for ggplot object
  s_y=.86,   # y position for ggplot object
  s_width=1.4,
  s_height=1.1,
  h_fill = "#e8a935",   # background colour for hexagon
  h_color="#001030",    # border colour
  url = "www.bioconductor.org",
  filename="drawProteins.pdf")
