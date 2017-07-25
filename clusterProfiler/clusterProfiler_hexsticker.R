require(ggplot2)
require(hexSticker)
require(clusterProfiler)
data(gcSample)
y = compareCluster(gcSample, 'enrichDO')
p <- dotplot(y) + theme_void() + theme(legend.position='none')+ theme_transparent()  +
    theme(panel.grid.major = element_line(size=.05, color='grey'))
sticker(p+scale_size(range=c(.1, 1)), package='clusterProfiler', p_size=6, s_x=.98, s_y=.88, s_width=.98, s_height=1.1,h_fill = "#008080", h_color="#336E7B")
