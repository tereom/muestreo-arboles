library(plyr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(rgdal)
library(maptools)

arbolado <- tbl_df(read.csv("datos/arbolado.csv"))
conglomerado_bq <- tbl_df(read.csv("datos/conglomerado_bq.csv"))
conglomerado <- tbl_df(read.csv("datos/conglomerados.csv"))
selva <- tbl_df(read.csv("datos/selva.csv"))

arbolado
conglomerado_bq
conglomerado
selva

### Conglomerados BQP y BPQ
conglomerado

### Mapa
edo_shp <- readOGR("datos/estados", layer = "Mex_Edos")
edo_shp@data$id <- rownames(edo_shp@data)
edo_df <- edo_shp %>%
  subset(id %in% c(0, 7, 13, 17)) %>%  # extraemos Ags, Colima Jalisco y Nayarit
  fortify(region = "id") %>%
  mutate(id = as.numeric(id)) # hacemos el id numérica

head(edo_df)

ggplot(data = edo_df, aes(long, lat)) + 
  geom_polygon(colour='black', fill='white', aes(group = group)) + 
  geom_point(data = conglomerado, aes(x = X, y = Y, color = Veg_prim_levantada)) + # bpq y bqp
  coord_fixed() +
  xlim(-106, -101) +
  ylim(18.5, 23.5)

# añadimos conglomerados BQ

ggplot(data = edo_df, aes(long, lat)) + 
  geom_polygon(colour='black', fill='white', aes(group = group)) + 
  geom_point(data = conglomerado, aes(x = X, y = Y, color = Veg_prim_levantada)) + # bpq y bqp
  geom_point(data = conglomerado_bq, aes(x = X, y = Y, color = Veg_prim_levantada)) + # bpq y bqp
  coord_fixed() +
  xlim(-106, -101) +
  ylim(18.5, 23.5)

### Arbolado en conglomerado, selva y conglomerado_bq

sum(arbolado$IdConglomerado %in% conglomerado$IdConglomerado) / nrow(arbolado)
sum(arbolado$IdConglomerado %in% conglomerado_bq$IdConglomerado) / nrow(arbolado)
sum(arbolado$IdConglomerado %in% selva$IdConglomerado) / nrow(arbolado)

sum(selva$IdConglomerado %in% conglomerado_bq$IdConglomerado) / nrow(selva)

ggplot(data = edo_df, aes(long, lat)) + 
  geom_polygon(colour='black', fill='white', aes(group = group)) + 
  geom_point(data = conglomerado, aes(x = X, y = Y, color = Veg_prim_levantada)) + # bpq y bqp
  geom_point(data = conglomerado_bq, aes(x = X, y = Y, color = Veg_prim_levantada)) + # bp
  geom_point(data = arbolado, aes(x = X, y = Y, color = Veg_prim_levantada)) +
  geom_point(data = selva, aes(x = X, y = Y, color = Veg_prim_levantada)) +
  coord_fixed() +
  xlim(-106, -101) +
  ylim(18.5, 23.5)


# conglomerado, conglomerado_bq y selva tienen las mismas variable
sum(colnames(conglomerado) != colnames(conglomerado_bq))
sum(colnames(conglomerado) != colnames(selva))
colnames(conglomerado) %in% colnames(arbolado)

vars_comunes <- colnames(conglomerado)[colnames(conglomerado) %in% 
                                         colnames(arbolado)]

bases <- list(conglomerado, conglomerado_bq, selva)
names(bases) <- c("bpq_bqp", "bq", "selva")
congs <- ldply(bases, rbind)

ggplot(data = congs) + 
  geom_polygon(data = edo_df, colour='black', fill = "white", alpha = .7,
               aes(x = long, y = lat, group = group)) + 
  geom_point(aes(x = X, y = Y, color = Veg_prim_levantada, 
                 size = Arboles_x_cgl), alpha = 0.8) +
  # facet_wrap(~.id) +
  coord_fixed() +
  xlim(-106, -101.5) +
  ylim(18.6, 23.2)

congs <- congs %>%
  mutate(impacto = factor(con_Impactos_amb))

ggplot(congs, aes(x = .id, y = Arboles_x_cgl)) +
  geom_boxplot() 

ggplot(data = arbolado) + 
  geom_polygon(data = edo_df, colour='black', fill = "white", alpha = .7,
               aes(x = long, y = lat, group = group)) + 
  geom_point(aes(x = X, y = Y, color = Veg_prim_levantada)) +
  # facet_wrap(~.id) +
  coord_fixed() +
  xlim(-106, -101) +
  ylim(18.5, 23.5)


especie_num <- arbolado %>% 
  filter(!(Genero_Especie %in% c("En identificación en identificacion", 
      "En identificación En identificación", "Sin especie Sin especie", 
      "Sin especie En identificación"))) %>%
  group_by(Genero_Especie) %>%
  summarise(num = n()) %>% 
  arrange(desc(num))
especie_num
  
ggplot(especie_num, aes(x = log(num))) +
  geom_histogram(binwidth = 0.7)

ggplot(especie_num, aes(x = (num))) +
  geom_histogram(binwidth = 8)

