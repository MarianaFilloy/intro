#################################
# Curso Introducción a R
# Mariana
# Sección 3
# ESTADÍSTICA
#################################

#### Cargar paquetes ----
pacman::p_load(tidyverse,
               janitor,
               dunn.test)

# Casi todo se hace en stats que es un paquete incluído en R

#### Datos ----

## Generar datos: #Cada quien va a tener datos al azar
#Datos al azar:
datos <- sample(1:150, 150)
datos

#Datos con una distribución normal:
rnorm(150) #Por default la media 0 y la desv. est. es 1

datos_norm <- rnorm(150, mean=50, sd=10) 
datos_norm

## Importar datos / trabajar con datos preexistentes
datos_iris <- iris

### Medidas de tendencia central ----

## Media:
mean(x = datos)
mean(x = datos_norm)
mean(x = datos_iris) #Es un tibble, se necesita especificar de que variable

mean(datos_iris$Sepal.Length)

datos_iris %>% 
  summarize(mean(x = Sepal.Length))

## Mediana:
median( x= datos)

datos_iris %>% 
  summarize(median(x = Sepal.Length))

## Mínimo:
min(x= datos_norm)
datos_iris %>% 
  summarise(min(x = Sepal.Length))

## Máximo:
max(x = datos)
datos_iris %>% 
  summarise(max(x = Sepal.Length))

## Rango: Valor más chico y valor más grande
range(x=datos_norm)
datos_iris %>% 
  summarise(range(x = Sepal.Length))
datos_iris %>% 
  reframe(range(x = Sepal.Length))

#Rango intercuartil
IQR(datos)
IQR(x=datos_norm)
datos_iris %>% 
  summarise(IQR(x = Sepal.Length))

#Varianza
var(x=datos)

datos_iris %>% 
  summarise(var(x = Sepal.Length))

#Desviación estándar
sd(x= datos)
sd(x= datos_norm) #Es lo que le habíamos pedido?

datos_iris %>% 
  summarise(sd(x = Sepal.Length))

#Varios datos:
summary(object = datos)
summary(object = datos_norm)

summary(datos_iris)

datos_iris %>% 
  summarise(across (.cols = Sepal.Length,
                    .fns = c(mean, median, IQR)))

datos_iris %>% 
  summarise(across (.cols = Sepal.Length,
                    .fns = c(mean, median, IQR))) %>% 
  rename(media = Sepal.Length_1,        #¿cómo cambiamos el nombre de las variables?
         mediana = Sepal.Length_2,
         IQR = Sepal.Length_3)


#### Correlaciones ----
#Datos
diamonds

diamantes <- diamonds %>% 
  select(carat, price, depth) # solo queremos variables numéricas

#Estadística descriptiva
summary(diamantes)

#Existe correlación entre las características de los diamantes?
cor(x = diamantes)

# Existe correlación entre el precio y  los quilates?
cor( x = diamantes$carat, y = diamantes$price )

#Cambiar método de correlación
cor( x = diamantes$carat, y = diamantes$price, method = "spearman")
   # Opciones de métodos: “pearson”, “kendall”, “spearman”

#Matrices de correlaciones y redondeo
cor(diamantes)
round(cor(diamantes),
      digits = 3) #Redondear a dos decimales

#Visualizar de la forma más sencilla la correlación
plot(diamantes$carat, diamantes$price)

#### Comparación de una media ----
###Datos con una distribución normal
#Importar bases de datos
ratas_1 <- read_excel("bases_de_datos/seccion_3/ratas_1.xlsx")
ratas_2<- read_excel("bases_de_datos/seccion_3/ratas_2.xlsx")
ratas_3<- read_excel("bases_de_datos/seccion_3/ratas_3.xlsx")

#limpiar bases de datos
ratas_1 <- ratas_1 %>% 
  clean_names()
ratas_2 <- ratas_2 %>% 
  clean_names()
ratas_3 <- ratas_3 %>% 
  clean_names()

#Prueba de t - datos no pareados
t.test( formula = peso ~ tratamiento, data = ratas_1)
t.test( formula = peso ~ tratamiento, data = ratas_3)

#Prueba de t- datos pareados
t.test( x = ratas_2$peso_2, 
        y = ratas_2$peso_1,
        paired = TRUE)

### Datos que no tienen una distribución normal
# Importar bases de datos
edades <- read_excel("bases_de_datos/seccion_3/edades.xlsx")
carrera <- read_excel("bases_de_datos/seccion_3/carrera.xlsx")


# ¿Cómo sé si mis datos tienen una distr. norm.?
# Shapiro test - si p < 0.05 distribución no es normal
shapiro.test(x = edades$edad)
shapiro.test(x = carrera$carrera_1)
shapiro.test(x= carrera$carrera_2)

#Gráfico más básico para ver la distribución de los datos
hist(edades$edad) 
hist(carrera$carrera_1)
hist(carrera$carrera_2)

#Prueba de Mann-Whitney o Wilcoxon - datos no pareados
wilcox.test( formula = edad ~ h_o_m, data = edades)

#Prueba de Mann-Whitney o Wilcoxon - datos pareados
wilcox.test( x = carrera$carrera_2,
             y = carrera$carrera_1,
             paired = TRUE)

#### Comparación de varias medias ----
### Datos con una distribución normal
# Importar bases de datos
medicina

## ANOVA
aov(mejoria ~ medicina, medicina )
anova_med <- aov(mejoria ~ medicina, medicina )

summary(anova_med) # Pr(>F) = p valor

#Pruebas posthoc
pairwise.t.test(medicina$mejoria, medicina$medicina,
                p.adjust.method = "bonferroni") # ("holm", "hochberg", "hommel", 
                                          #    "bonferroni", "BH", "BY",
                                          #     "fdr", "none")

### Datos que no tienen una distribución normal
# Importar bases de datos
medicina_2

#Kruskal-Wallis test
kruskal.test(mejoria ~ medicina, medicina_2)

#Prueba posthoc - Dunn
dunn <- dunn.test(medicina_2$mejoria, medicina_2$medicina, 
                  method="bonferroni") #("none", "bonferroni", 
                                       #"sidak", "holm", "hs", 
                                       #"hochberg", "bh", "by")
dunn <- as_tibble(dunn)
dunn
