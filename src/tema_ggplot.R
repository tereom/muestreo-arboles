library(ggplot2)
library(grid)
#library(extrafont)


# Mi tema
#quartzFont(c("Gill Sans MT", "Gill Sans MT Italic", "Gill Sans MT Bold", 
#  "Gill Sans MT Italic"))

paleta <- c("#999999", "#FF9933", "#56B4E9", "#009E73", "#F0E442", "#0072B2", 
	"#D55E00", "#CC79A7")

# tamaño lineas
linea.t <- 0.4
# transparencia lineas
linea.a <- 0.7

# relleno histogramas
bar.f <- "gray60"

# tamaño notas
texto.t <- 2.9 


# tamaño punto
punto.t <- 1.6
#  transparencia puntos
punto.a <- 0.7 #color
0.6 #negro

# histograma 
fill = "black"
alpha = 0.5
theme_set(theme_bw())
base_size <- 12
# base_family <- "Gill Sans MT"
theme_old <- theme_update(
	plot.title = element_text(size = base_size * 0.9),

    axis.ticks = element_line(colour = "gray70", size = 0.1),
	axis.ticks.margin = unit(0.1, "cm"),

    axis.text.y = element_text(
		size = base_size * 0.7, vjust = 0.5, hjust = 1, colour = "grey40"),
    axis.text.x = element_text( 
		size = base_size * 0.7, vjust = 1, colour = "grey40"),
	axis.title.x = element_text( 
		size = base_size * 0.8, vjust = 0.2),
	axis.title.y = element_text( 
		size = base_size * 0.8, vjust = 0.2, 
		angle = 90, lineheight = 0.9),
		
	legend.key = element_blank(), 
	legend.key.size = unit(.9, "lines"),
	legend.title = element_text( size = base_size * 0.8,
		 hjust = 0),
	legend.text = element_text( size = base_size * 0.7, 
		colour = "grey40"),
	legend.text.align = 0,
	legend.position = "right",
	
	strip.background = element_blank(), 
	strip.text.x = element_text( size = base_size * 0.8), 
	strip.text.y = element_text( size = base_size * 0.8, 
		angle = -90), plot.background = element_rect(colour = NA), 

	panel.border = element_rect(fill = NA, colour = "grey70")
)
