############################################
# Curso Introducción a R
# Nombre
# Sección 4_1
# VISUALIZACIÓN DE DATOS - ggplot2 básicos
############################################

#### Cargar paquetes ----
pacman::p_load(tidyverse,
               janitor,
               RColorBrewer, #paletas de colores
               corrplot,    #correlalogramas
               readxl)     

#### Datos ----
pacientes <- read_excel("bases_de_datos/seccion_4/pacientes.xlsx")

pacientes <- pacientes %>% 
  clean_names()

#### Gráfico más básico ----
# Paquete incluido dentro del tidyverse
# Básicos para trabajar con ggplot2
#     - tibble  -> datos con los que trabajaremos
#     - ggplot()  -> programa para graficar
#     - aes()  -> elementos estéticos
#     - geom_*()  -> tipo de gráfico

# Ejemplo:
pacientes %>%
  ggplot() +
  aes(x = glucosa,
      y = insulina) +
  geom_point() # Gráfico de dispersión - puntos

# Otra forma de escribir:
pacientes %>%
  ggplot(aes(x = glucosa,
             y = insulina)) +
  geom_point()

# Otra
pacientes %>%
  ggplot() +
  geom_point(aes(x = glucosa,
                 y = insulina)) +
  geom_line(aes(x = glucosa,
                y = insulina)) # Los elementos estéticos se aplican sobre esa gráfica

#### Agregar colores ----
# Se agregan en la gráfica cuando es un color definido

pacientes %>%
  ggplot(aes(x = glucosa,
             y = insulina)) +
  geom_point(color = "blue")

# Se agregan dentro de aes cuando es por una variable(color = variable categórica)
pacientes %>%
  ggplot(aes(x = glucosa,
             y = insulina,
             color = diagnostico)) +
  geom_point()

#### Cambiar la forma ----
# Se agregan dentro de aes(shape = variable categórica)

pacientes %>%
  ggplot(aes(x = glucosa,
             y = insulina,
             color = sexo)) +
  geom_point()

# Cambiar la transparencia ----
# Se agrega dentro de aes(alpha = número (0-1))
pacientes %>%
  ggplot(aes(x = glucosa,
             y = insulina,
             alpha = 0.5)) +
  geom_point()

#Cambiar el tamaño ----
# Se agrega dentro de aes(size = variable categórica)
pacientes %>%
  ggplot(aes(x = glucosa,
             y = insulina,
             size= imc)) +
  geom_point()

# Se agrega dentro geom_*(size = número)
pacientes %>%
  ggplot(aes(x = glucosa,
             y = insulina)) +
  geom_point(size =4)

#Combinado
grafica <- pacientes %>%
  ggplot(aes(x = glucosa,
             y = insulina,
             color = diagnostico,
             shape = sexo)) +
  geom_point(size = 2,
             alpha = 0.9)

grafica

########## Otros gráficos ########## 
#### Histograma ----
#Más básico
pacientes %>% 
  ggplot(aes(x=glucosa)) + 
  geom_histogram() #algunos valores se enciman

pacientes %>% 
  ggplot(aes(x=glucosa)) + 
  geom_histogram(binwidth = 1) # cada valor representa una raya

#Color de las barras : color (borde)
pacientes %>% 
  ggplot(aes(x=glucosa, color=diagnostico)) +
  geom_histogram()

#Color de las barras : fill (relleno)
pacientes %>% 
  ggplot(aes(x=glucosa, fill=diagnostico)) +
  geom_histogram()

#### Caja y bigote ----
### Básico
pacientes %>%
  ggplot( aes(x=diagnostico, y=glucosa)) +
  geom_boxplot()

### Distribución - violín
pacientes %>% 
  ggplot(aes(x = diagnostico, y=glucosa)) +
  geom_violin()

### Distribución - puntos ordenados
pacientes %>%
  ggplot( aes(x=diagnostico, y=glucosa)) +
  geom_boxplot() +
  geom_point(color="blue", size=0.8)

### Distribución - puntos desordenados
pacientes %>%
  ggplot( aes(x=diagnostico, y=glucosa)) +
  geom_boxplot() +
  geom_jitter(color="blue", size=0.8)

#### Barras ----
# Gráfico más básico
pacientes %>% 
  ggplot(aes(x = paciente, y=ldl)) +
  geom_col()
  
#### Agregar colores 
# Se agregan en la gráfica cuando es un color definido
# color -> borde
pacientes %>% 
  ggplot(aes(x = paciente, y=ldl)) +
  geom_col(color = "red", fill = "blue")

# fill -> relleno
pacientes %>% 
  ggplot(aes(x = paciente, y=ldl)) +
  geom_col(fill = "seagreen")

#Graficar la media
pacientes %>% 
  summarise(mean = mean(x=glucosa), # ¿cómo se obtenía la estadística de un tibble?
            sd = sd(x=glucosa),
            .by = diagnostico) %>% 
  ggplot(aes(x = diagnostico, 
             y = mean)) +
  geom_col()

media <- pacientes %>% 
  summarise(mean = mean(x=glucosa),
            sd = sd(x=glucosa),
            .by = diagnostico)

media %>% 
  ggplot(aes(x = diagnostico, 
             y = mean)) +
  geom_col()

#Cambiar el color 
media %>% 
  ggplot(aes(x = diagnostico, 
             y = mean,
             fill = diagnostico)) +
  geom_col()

media %>% 
  ggplot(aes(x = diagnostico, 
             y = mean,
             fill = diagnostico)) +
  geom_col() +
  scale_fill_manual(values = c("orange", "#AED3E3", "pink") ) #nombre del color o
                                                              #código hexadecimal
# R color brewer
# https://colorbrewer2.org/#type=qualitative&scheme=Dark2&n=3
RColorBrewer::display.brewer.all()

media %>% 
  ggplot(aes(x = diagnostico, 
             y = mean,
             fill = diagnostico)) +
  geom_col() +
  scale_fill_brewer(palette = "Pastel1")

#### Cambiar ancho de las barras - width
media %>% 
  ggplot(aes(x = diagnostico, y=mean, fill = diagnostico)) +
  geom_col(width = 0.2)

### Voltear las barras
media %>% 
  ggplot(aes(x = diagnostico, y=mean, fill = diagnostico)) +
  geom_col() +
  coord_flip()

### Reordenar variables - dplyr 
pacientes %>% 
  mutate(diagnostico = factor(diagnostico, levels=c("Normal", "Sobrepeso", "Obesidad"))) %>% 
  #¿Cómo creamos una nueva columna?
  summarise(mean = mean(x=glucosa), #estadística en un tibble
            .by = diagnostico) %>% 
  ggplot(aes(x = diagnostico, y=mean, fill = diagnostico)) +
  geom_col() 

media_ord <- pacientes %>% 
  mutate(diagnostico = factor(diagnostico, levels=c("Normal", "Sobrepeso", "Obesidad"))) %>% 
  summarise(mean = mean(x=glucosa),
            sd = sd(x=glucosa),
            .by = diagnostico)

media_ord %>% 
  ggplot(aes(x = diagnostico, y=mean, fill = diagnostico)) +
  geom_col() 

### Agregar barra de error
# Más básica
media_ord %>% 
  ggplot(aes(x = diagnostico, y=mean, fill = diagnostico)) +
  geom_col() +
  geom_errorbar(aes(x=diagnostico, ymin=mean-sd, ymax=mean+sd))

#Otros tipos de barras
media_ord %>% 
  ggplot(aes(x = diagnostico, y=mean, fill = diagnostico)) +
  geom_col() +
  geom_crossbar(aes(x=diagnostico, ymin=mean-sd, ymax=mean+sd))

media_ord %>% 
  ggplot(aes(x = diagnostico, y=mean, fill = diagnostico)) +
  geom_col() +
  geom_linerange(aes(x=diagnostico, ymin=mean-sd, ymax=mean+sd))

media_ord %>% 
  ggplot(aes(x = diagnostico, y=mean, fill = diagnostico)) +
  geom_col() +
  geom_pointrange(aes(x=diagnostico, ymin=mean-sd, ymax=mean+sd))

#Algunos cambios
media_ord %>% 
  ggplot(aes(x = diagnostico, y=mean, fill = diagnostico)) +
  geom_col() +
  geom_errorbar(aes(x=diagnostico, ymin=mean-sd, ymax=mean+sd),
                colour="orange", # Color 
                alpha=0.5,       # transparencia
                size=1.5)        # grosor 

### Algunos otros tipos de barras
# Hay que transponer los datos:
datos_t <- pacientes %>%
  select(-c(sexo, paciente)) %>% 
  pivot_longer(!diagnostico, names_to = "variable", values_to = "count")

### Barras agrupadas
#Por variable
datos_t %>% 
  ggplot(aes(x = variable, y=count, fill = diagnostico)) +
  geom_bar(position="dodge", stat="identity")

#sobrepuestas
datos_t %>% 
  ggplot(aes(x = variable, y=count, fill = diagnostico)) +
  geom_bar(position="stack", stat="identity") #No es lo correcto para estos datos

#Sobrepuestas pero como porcentaje
datos_t %>% 
  ggplot(aes(x = variable, y=count, fill = diagnostico)) +
  geom_bar(position="fill", stat="identity") 

datos_t %>% 
  ggplot()+ 
  aes(x = variable, y=count) +
  geom_bar(position="fill", stat="identity", fill = diagnostico) 

### Correlalogramas ----
# Correlaciones solo se pueden hacer con datos numéricos
# Quiero saber la relación entre los datos en los pacientes con obesidad
ob <- pacientes %>% 
  filter(diagnostico == "Obesidad") %>% #¿Cómo me quedo con los datos de px con obesidad? FILA
  select(where(is.double)) # ¿Cómo me quedo con los datos numéricos? COLUMNA

# ¿Cómo obtengo la correlación entre las variables? 
c_ob <- cor(x = ob)

#Gráfico más básico
corrplot(c_ob)

#Cambiar aspecto
corrplot(c_ob, method = "circle") #circle (default),square,ellipse,number,shade,color,pie

#Cambiar tipo
corrplot(c_ob, type = "lower") #upper, lower, full (default)

#Cambiar orden
corrplot(c_ob, order = "alphabet") #AOE, FPC, hclust, alphabet

#Cambiar colores usando R color brewer
RColorBrewer::display.brewer.all()

# COL1 - colores secuenciales
corrplot(c_ob, col = COL1("YlOrRd", 10))

# COL2 - colores divergentes
corrplot(c_ob, col = COL2("PuOr", 10))
