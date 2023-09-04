############################################
# Curso Introducción a R
# Nombre
# Sección 4_2
# VISUALIZACIÓN DE DATOS - aspectos visuales
############################################

#### Cargar paquetes ----
pacman::p_load(tidyverse,
               janitor,
               readxl,
               RColorBrewer,
               ggthemes,
               scales)

#### Datos ----
pacientes

#### Aspectos estéticos ----

## Formas ----
# Diagrama de dispersión - geom_point()
#Básico - puntos
pacientes %>%
  ggplot(aes(x = imc,
             y = insulina)) +
  geom_point()
# Cambiar forma - pch = # del 1-22
pacientes %>%
  ggplot(aes(x = imc,
             y = insulina)) +
  geom_point(pch = 7,
             size = 5, 
             color = "red")

## Líneas ----
# Diagrama de línea - geom_line()
#Básico - linea contínua
pacientes %>%
  ggplot(aes(x = glucosa,
             y = glucosa)) +
  geom_line()

# Cambiar tipo de línea - linetype o lty = # del 1-6
pacientes %>%
  ggplot(aes(x = glucosa,
             y = glucosa)) +
  geom_line(lty = 3)

#Cambiar grosor de línea - lwd = #
pacientes %>%
  ggplot(aes(x = glucosa,
             y = glucosa)) +
  geom_line(lwd = 8,
            lty = 4)

## Temas ----
#theme_()
#ggplot2
pacientes %>%
  ggplot(aes(x = imc,
             y = insulina)) +
  geom_point() +
  theme_classic()

#ggthemes
pacientes %>%
  ggplot(aes(x = imc,
             y = insulina)) +
  geom_point() +
  theme_economist()

## Leyendas/labels ----
media_ord <- pacientes %>% 
  mutate(diagnostico = factor(diagnostico, levels=c("Normal", "Sobrepeso", "Obesidad"))) %>% 
  summarise(mean = mean(x=glucosa),
            sd = sd(x=glucosa),
            .by = diagnostico)

grafica <- media_ord %>% 
  ggplot(aes(x = diagnostico, y=mean, fill = diagnostico)) +
  geom_col() +
  scale_fill_manual(values = c("orange", "#AED3E3", "pink") )

# posición
grafica +
  theme(legend.position = "bottom") # "top", "right", "bottom" o "left"

#Eliminar label
grafica +
  theme(legend.position = "none")

grafica +
  theme_void()

# Texto - color, tamaño & negritas
grafica +
  theme(legend.text = element_text(size = 8, colour = "red", face = "bold"))

# Título - color, tamaño & itálica
grafica +
  theme(legend.title = element_text(size = 12, colour = "blue",face = "italic"),
        legend.text = element_text(size = 8, colour = "red", face = "bold"))

# Cambiar título
grafica +
  labs(fill = "Diagnóstico según IMC")

## Título a gráfico ----
#Agregar título
grafica +
  ggtitle("Glucosa por diagnóstico")

#Cambiar aspectos visuales
grafica +
  ggtitle("Glucosa por diagnóstico") +
  theme(plot.title = element_text(color="red", size=14, face="bold.italic"))

## Ejes ----
#Títulos de ejes
grafica +
  theme(axis.title.x = element_text(color="blue", size=14, face="bold"),
        axis.title.y = element_text(color="#993333", size=8, face="italic"))

#Eliminar títulos
grafica +
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank())

#Modificar texto ejes
grafica +
  theme(axis.text.x = element_text(color="#9f4b32", size=10, face="bold", angle=90))

#Ticks
grafica +
  theme(axis.ticks = element_blank())

grafica +
  theme(axis.ticks = element_line(linewidth = 5, color="red") ,
        axis.ticks.length = unit(.5, "cm"))

#Línea eje
grafica +
  theme(axis.line = element_line(colour = "darkblue", 
                                linewidth = 3, linetype = 2))

# Modificar ejes
pacientes %>%
  ggplot(aes(x = glucosa,
             y = insulina,
             color = diagnostico)) +
  geom_point() +
  scale_x_continuous(name = "Glucosa (mg/dl)", limits=c(70, 100))+
  scale_y_continuous(name = "Insulina (mg/dl)", breaks=seq(15,50,1))


# Escala - Porcentaje
datos_t <- pacientes %>%
  select(-c(sexo, paciente)) %>% 
  pivot_longer(!diagnostico, names_to = "variable", values_to = "count")

datos_t %>% 
  ggplot(aes(x = variable, y=count, fill = diagnostico)) +
  geom_bar(position="fill", stat="identity")

datos_t %>% 
  ggplot(aes(x = variable, y=count, fill = diagnostico)) +
  geom_bar(position="fill", stat="identity") +
  scale_y_continuous(labels = percent) # del paquete scales

# Moneda
diamonds %>% 
  ggplot(aes(x = price, y=carat)) +
  geom_point() +
  scale_x_continuous(labels = dollar) # del paquete scales

# Notación científica
diamonds %>% 
  ggplot(aes(x = price, y=carat)) +
  geom_point() +
  scale_x_continuous(labels = scientific) # del paquete scales


## Facet ----
#Todo junto
datos_t %>% 
  ggplot(aes(x = variable, y=count, fill = diagnostico)) +
  geom_bar(position="dodge", stat="identity")

#Dividir por columnas
datos_t %>% 
  ggplot(aes(x = variable, y=count, fill = diagnostico)) +
  geom_bar(position="dodge", stat="identity") +
  facet_wrap(~diagnostico)

#### Exportar archivos ----
#Manualmente:
# Como imagen:
#   - PNG
#   - JPEG
#   - TIFF
#   - BMP
#   - SVG
#   - EPS
# Como PDF

#Con código:
#Automáticamente guarda la última gráfica realizada
ggsave(filename = "output/grafica.eps",
       width = 16,
       height = 9,
       dpi = 300)
