#################################
# Curso Introducción a R
# Nombre
# Sección 2.1
# BASES DE DATOS -Importar y exportar
#################################

#### Importar datos ----

### Archivos de texto plano/simple

# Son archivos que solamente contienen texto:
#     - Letras
#     - Números
#     - Signos de puntuación
# Almacenan información sin formato ni metadatos
# Se separan con tabulaciones, comas u otros signos
# Pueden ser leídos por personas y software

#Paquetes que permiten importar archivos de texto plano
install.packages("readr")
library(readr) #Paquete incluido en el Tidyverse
library(tidyverse)

#Recomendación: explorar los archivos primero

#Usando readr:

#Archivo con terminación .csv pero no separado por comas (,)
bd_personas_2 <- read_delim("bases_de_datos/seccion_2/bd_personas_2.csv", 
                            delim = "|", escape_double = FALSE, trim_ws = TRUE)

#Archivo csv
bd_personas_3 <- read_csv("bases_de_datos/seccion_2/bd_personas_3.csv")

#Archivo con terminación .csv del cual no queremos importar algunas filas
bd_personas_4 <- read_delim("bases_de_datos/seccion_2/bd_personas_4.csv",
                            delim = "|", escape_double = FALSE,
                            trim_ws = TRUE, skip = 2)

#Archivo con terminación .txt
bd_personas <- read_delim("bases_de_datos/seccion_2/bd_personas.txt",
                          delim = "\t")


### Archivos de excel

# Son archivos creados en Excel
# Su proceso de importación es más complejo que el de los archivos de texto plano

#Paquetes que permiten importar archivos de Excel
install.packages("readxl")
library(readxl)

#Usando readxl

#Base de datos ideal
bd_personas_5 <- read_excel("bases_de_datos/seccion_2/bd_personas_5.xls")

#Base de datos en la que los datos están en otra hoja que no es la principal
bd_personas_6 <- read_excel("bases_de_datos/seccion_2/bd_personas_6.xls", 
                            sheet = "2")

#Base de datos en la que los datos están en otra hoja que no es la principal y
# de la cual no se necesitan los primeros renglones
bd_personas_7 <- read_excel("bases_de_datos/seccion_2/bd_personas_7.xls", 
                            sheet = "2", skip = 5)

#Base de datos en la que los datos están en otra hoja que no es la principal y
# de la cual se quiere importar solamente unos renglones
bd_personas_8 <- read_excel("bases_de_datos/seccion_2/bd_personas_8.xls", 
                            sheet = "2", range = "A5:E13")


### Archivos binarios

# Son archivos compuestos por 0 y 1
# Solo pueden ser leídos por software

#Paquetes que permiten importar archivos binarios
library(readr)

bd_personas_rds <- read_rds(file = "bases_de_datos/seccion_2/bd_personas.rds")

## Archivos en repositorios
#En github
#https://tinyurl.com/bd-personas-3
#Buscar opción de datos "Raw"

bd_github <- read_csv(file = "https://tinyurl.com/bd-personas-3")

## Copiar datos de una tabla en internet
#Paquetes que permiten copiar datos
install.packages("datapasta")
library(datapasta)

# Ir a https://es.wikipedia.org/wiki/Tabla_(información)
# Copiar la tabla de edad
# En Addins, seleccionar Paste as tribble del paquete DATAPASTA
tabla <- tibble::tribble(
      ~Nombre,     ~Apellido, ~Años,
       "Luis",     "Enrique",   14L,
  "Blaszczyk", "Kostrzewski",   25L,
      "Lirio",   "McGarrett",   18L,
  "Olatunkbo",    "Chijiaku",   22L,
   "Adrienne",    "Anthoula",   22L,
     "Axelia",   "Atanasios",   22L,
  "Jon-Kabat",        "Zinn",   22L,
    "Thabang",       "Mosoa",   15L,
   "Kgaogelo",       "Mosoa",   11L
  )


#### Explorar algunas bases de datos de R ----
# The R Datasets Package
# https://www.rdocumentation.org/packages/datasets/versions/3.6.2

carros <- mtcars #Información de 32 automobiles publicada en Motor Trend US magazine
DNase #resultados de un ELISA
iris #Información de la planta Iris

#ggplot2
diamonds #Información de diamantes

#dplyr
starwars #Información de personajes de Starwars

#### Exportar datos ----

### Archivos de texto plano
carros <- mtcars

#Paquete: readr
#Función write_csv()


### Archivos de excel
starwars <- starwars

#Paquete: rio
install.packages("rio")
library(rio)

#Función export()
export(x = starwars,
       file = "output/starwars.xlsx") 

### Archivos binarios
diamantes <- diamonds

#Paquete: readr
# Función write_rds()
write_rds(x = diamantes,
          file = "output/diamantes.rds")
