#################################
# Curso Introducción a R
# Mariana López Filloy
# Sección 1
# INTRODUCCIÓN
#################################

#### Instalación de paquetes ----
# CRAN
install.packages("tidyverse")
library(tidyverse)

# Bioconductor
install.packages("BiocManager")
library(BiocManager)
BiocManager::install("phyloseq")



#### Objetos ----
# Un objeto es una variable o algo que guarda información
# El operador de asignación es <-
# Recomendaciones al nombrar objetos:
#     - Sensible a mayúsculas
#     - No iniciar con número
#     - Sólo usar punto y guión bajo


#Operador de asignación opt + -

### Ejemplos:

#Mayúsculas:
MiObjeto <- "Caja"

print(miobjeto)
print(MiObjeto)

#Número al inicio:
2objeto <- "Zapato"
objeto2 <- "Zapato"

print(objeto2)

#Caracteres especiales:
*objeto <- "Salsa"
-objeto <- "Salsa"
obj-eto <- "Salsa"
objeto_3 <- "Salsa"

#### Operadores ----
# Sirven para realizar operaciones aritméticas

#Se pueden realizar operaciones entre números:
4+3

#Se pueden realizar operaciones entre objetos/variables:
x <- 4
y <- 3

x+y

#### Tipos de datos ----
a <- 10
b <- "hoja"
c <- TRUE

class(a) #Numérico
class(b) #Caracter
class(c) #Lógico

#### Estructura de datos ----

### Vectores

#Objetos unidimensionales
#Elementos de un solo tipo
#Pueden ser numéricos, tipo caracter o lógico

#Para poder crear un vector se usa combine: c()
remove(vector_1)

vector_1 <- c(12, 25, 67, 99)
vector_2 <- c("A", "E", "I", "A")

#Longitud del vector:
length(vector_1)

#Extraer elementos:
vector_1[2] #Extrae el valor que está en la segunda posición

#Ordenar elementos:
vector_1 <- sort(vector_1, decreasing = TRUE) #de mayor a menor
sort(vector_1, decreasing = FALSE) #de menor a mayor

# Eliminar los valores que se repiten
unique(vector_2) 
vector_3 <- unique(vector_2)

### Factores

#Se utiliza para clasificar los componentes de otros vectores
#Principalmente usado para estadística y gráficas

glucosa <- c(100, 87, 120, 99, 200, 185)
concentracion <- factor(c("alta", "normal", "alta", "baja", "alta", "alta"))

### Matrices

#Objetos de dos dimensiones
#Columnas deben de:
#   -Tener el mismo tipo de datos
#   -Tener el mismo número de datos

matriz1 <- matrix(c(2, 10, 45, 31, 11, 8),
                  nrow = 3,
                  ncol = 2)

matriz2 <- matrix(c("A", "B", "C", "D", "E", "F"),
                  nrow = 2,
                  ncol = 3)

#Obtener las dimensiones de la matriz:
dim(matriz1)
dim(matriz2) # Columnas y filas

#Obtener los elementos de una fila
matriz1[1,] #Elementos de la primera fila


#Obtener los elementos de una columna
matriz1[,1] #Elementos de la primera columna


#Obtener un elemento en específico
matriz1[2,2] #Elemento que está en la segunda fila de la segunda columna

### Data frames

#Son objetos bidimensionales con filas y columnas
#Todas las columnas deben de tener el mismo número de filas
#Pueden contener cualquier tipo de datos: numéricos, carácteres o lógicos

#Se pueden crear a partir de vectores
nombre <- c("Ana", "Martha", "Alex")
calificacion <- c(5, 8, 7.5)
reprueba <- c(TRUE, FALSE, FALSE)

df <- data.frame(nombre, calificacion, reprueba)

df2 <- data.frame(nombre = c("Ana", "Martha", "Alex"),
                  calificacion = c(5, 8, 7.5),
                  reprueba = c(TRUE, FALSE, FALSE))

#Para analizar estructura de Data Frame
str(df)

#Para extraer datos de las columnas
df$nombre
df$calificacion
df$reprueba

#Extraer datos en una posición
df[[1]] #La primera columna


### Tibbles

#Son objetos bidimensionales con filas y columnas como los data frames
#Al imprimir, solo se muestran las primeras 10 filas y tantas columnas como quepan en la pantalla
#A casa columna se le agrega el tipo de datos que contiene

#Es necesario cargar el paquete "Tibble" o el "tidyverse"
library(tidyverse)

#A partir de un Data Frame
tb <- as_tibble(df)

#A partir de los vectores
tb2 <- tibble(nombre, calificacion, reprueba)
