#################################
# Curso Introducción a R
# Mariana
# Sección 2.2
# BASES DE DATOS -Trabajo con datos
#################################

#Paquetes para el trabajo con bases de datos:
install.packages("pacman")
pacman::p_load(tidyverse,
               janitor)

#Pacman carga los paquetes y si no se han instalado previamente, también los instala

#Las bases de datos se modifican con un paquete llamado dplyr que es parte del tidyverse

#Se utilizan bases de datos "tidy"
#   - Cada variable se encuentra en una columna
#   - Cada observación en una fila

#Se utiliza la pipa %>% 
#   Windows/Linux: ctrl + shift + m
#   MacOs: command + shift + m

# POR FAVOR IMPORTA LA BASE DE DATOS: bd_plantas
bd_plantas <- read_csv("bases_de_datos/seccion_2/bd_plantas.csv")

# clean_names() de janitor
bd_plantas
bd_plantas %>% 
  clean_names()
bd_plantas # No se guardaron los cambios porque no se asignó a un nuevo objeto
bd_plantas_limpio <- bd_plantas %>% 
  clean_names()

# Algunas funciones útiles:
# glimpse() - Darte una idea de tus datos
bd_plantas_limpio %>% 
  glimpse()
glimpse(bd_plantas_limpio)

#head()
bd_plantas_limpio %>% 
  head()
head(bd_plantas_limpio)

#tail()
bd_plantas_limpio %>% 
  tail()
tail(bd_plantas_limpio)

#str()
bd_plantas_limpio %>% 
  str()
str(bd_plantas_limpio)

#### Modificar columnas ----

### Rename ----
# Rename tiene la función de renombrar las columnas en una base de datos:
# Estructura: 
# tibble %>% 
#   rename ( nombre nuevo = nombre viejo)
bd_plantas_limpio %>% 
  colnames()

bd_plantas_limpio %>% 
  rename(nombre = nombre_comun,
      altura_m = tamano_maximo_metros,
      longitud_hoja_cm = longitud_maxima_hoja_cm,
      ancho_hoja_cm = ancho_maximo_hoja_cm)

#Guardarlo
bd_plantas_limpio <- bd_plantas_limpio %>% 
  rename(nombre = nombre_comun,
      altura_m = tamano_maximo_metros,
      longitud_hoja_cm = longitud_maxima_hoja_cm,
      ancho_hoja_cm = ancho_maximo_hoja_cm)

### Relocate ----
# Relocate tiene la función de reacomodar las columnas en una base de datos:
# Estructura: 
# tibble %>%
#  relocate (variable, .posición)

# Mover a una variable antes que otra:
bd_plantas_limpio %>% 
  relocate(origen, .before = nombre)

bd_plantas_limpio %>% 
  relocate(8, .before = 1)

# Mover a una variable después que otra:
bd_plantas_limpio %>% 
  relocate(color_flor, .after = ancho_hoja_cm)

#Mover más de una variable
bd_plantas_limpio %>% 
  relocate(c(longitud_hoja_cm, ancho_hoja_cm), .before = nombre)

# Mover más de una variable (continuas)
bd_plantas_limpio %>% 
  relocate(c(color_flor: ancho_hoja_cm), .before = nombre)

#Mover las columnas por tipo de datos que contiene
bd_plantas_limpio %>% 
  relocate(where(is.double), .before = where(is.character))


### Select ----
# Select tiene la función de seleccionar las columnas en una base de datos:
# Estructura:
#   tibble %>%
#    select(método de selección)

#Por nombre de las variables
bd_plantas_limpio %>% 
  select(nombre, origen)

#Por posición de las variables
bd_plantas_limpio %>% 
  select(1,3)
                   
#Una serie de variables
bd_plantas_limpio %>% 
  select(4:7)

bd_plantas_limpio %>% 
  select(altura_m:origen)

#Variables cuyo nombre comienza con un patrón
bd_plantas_limpio %>% 
  select(starts_with(match = "color"))

#Variables cuyo nombre termina con un patrón
bd_plantas_limpio %>% 
  select(ends_with(match = "cm"))

#Variables cuyo nombre contiene  un patrón
bd_plantas_limpio %>% 
  select(contains(match = "hoja"))

# Variables que cumplen con una condición
bd_plantas_limpio %>% 
  select(where(is.double))

bd_plantas_limpio %>% #¿Y si es texto?
  select(where(is.character))

#Se quieren seleccionar todas las variables excepto 1
bd_plantas_limpio %>% 
  select(-nombre)

#Se quieren excluir muchas variables
bd_plantas_limpio %>% 
  select(-c(nombre, color_flor, origen))

#Se pueden combinar varios métodos de selección
bd_plantas_limpio %>% 
  select(nombre,
      starts_with("color"),
      8)


### Mutate ----
# Mutate tiene como función crear variables

# Estructura:
#   tibble %>%
#    mutate(variable a crear)

#Una constante:
bd_plantas_limpio %>% 
  mutate(inventario = "a") %>% 
  select(6:9)

# Copiar una columna
bd_plantas_limpio %>% 
  mutate(copia_nombres = nombre)

# Calcular cosas - Ej. transformar cm a m
bd_plantas_limpio %>% 
  mutate(long_max_hoja_m = longitud_hoja_cm/100,
         ancho_max_hoja_m = ancho_hoja_cm/100)

bd_plantas_limpio %>% 
  mutate(long_max_hoja_m = longitud_hoja_cm/100,
         ancho_max_hoja_m = ancho_hoja_cm/100,
         .keep = "used") #mantener las columnas que se usaron par construir las variables,
                         #además de las nuevas variables

bd_plantas_limpio %>% 
  select(longitud_hoja_cm, ancho_hoja_cm) %>% 
  mutate(long_max_hoja_m = longitud_hoja_cm/100,
      ancho_max_hoja_m = ancho_hoja_cm/100)

#Comparar cosas
# Uso de operadores de comparación:
#  > Mayor que
#  >= Mayor o igual que
#  < Menor que
#  <= Menor o igual que
#  == Exactamente igual que
#  != Diferente a 

bd_plantas_limpio %>% 
  colnames()

bd_plantas_limpio %>% 
  mutate(mas_larga_que_ancha = longitud_hoja_cm > ancho_hoja_cm)

bd_plantas_limpio %>% #Usando una condición
  mutate(mas_larga_que_ancha = if_else(condition = longitud_hoja_cm > ancho_hoja_cm,
                                       true = "Sí", 
                                       false = "No"))

#Crear una variable que contenga categorías
bd_plantas_limpio %>% 
  mutate(altura = case_when(altura_m < 10 ~ "bajo",
                         altura_m >= 10 & altura_m <= 20 ~ "medio",
                         altura_m > 20 ~ "alto"))

#### Modificar renglones ----

### Filter ----
# Filter tiene como función extraer una(s) fila(s) usando alguna condición

# Estructura:
#   tibble %>%
#    filter(condición)

#Comparar variables numéricas
bd_plantas_limpio %>% 
  filter(altura_m == 30)

#En un rango de valores
bd_plantas_limpio %>% 
  filter(altura_m > 8 & altura_m < 15)

#Texto
bd_plantas_limpio %>% 
  filter(color_flor == "Rojo")

# Texto varias opciones
bd_plantas_limpio %>% 
  filter(color_flor == "Rojo" | color_flor == "amarilla" | color_flor == "magenta")
bd_plantas_limpio %>% 
  filter(color_flor == "Rojo" & color_flor == "amarilla" & color_flor == "magenta")

# Más de una variable de texto
bd_plantas_limpio %>% 
  filter(color_flor == "Rojo",
         color_hoja == "Rojo")

bd_plantas_limpio %>% 
  filter(color_flor == "Rojo") %>% 
  filter(color_hoja == "Verde")

# Texto y valores
bd_plantas_limpio %>% 
  filter(altura_m > 10, 
         color_flor == "Rojo")

# NAs
bd_plantas_limpio %>% 
  filter(is.na(ancho_hoja_cm))

bd_plantas_limpio %>% 
  filter(!is.na(ancho_hoja_cm))


### Arrange ----
# Arrange tiene como función reordenar los renglones según un valor

# Estructura:
#   tibble %>%
#    arrange(forma en la que se quiere reordenar)

## Variables numéricas/double
# Reordenar de forma ascendente
bd_plantas_limpio %>% 
  arrange(altura_m)

#Reordenar de forma descendiente
bd_plantas_limpio %>% 
  arrange(-altura_m)

## Variables texto/character
# Reordenar de forma ascendente (alfabéticamente)
bd_plantas_limpio %>% 
  arrange(nombre_cientifico)

# Reordenar de forma descendiente 
bd_plantas_limpio %>% 
  arrange(-nombre)

bd_plantas_limpio %>% 
  arrange(desc(nombre))

bd_plantas_limpio %>% 
  arrange(desc(altura_m)) #También ordena de forma descendiente 

#### Otras funciones ----

### Summarise ----
# summarise nos da como resultado un tibble nuevo con la información solicitada
# sirve para estadística descriptiva

# Estructura:
#   tibble %>%
#    summarise(función)

#Algunas funciones útiles:
# n() - Número de observaciones
bd_plantas_limpio %>% 
  summarise(total_de_plantas = n())

# n_distinct(x) - Número de observaciones únicas
bd_plantas_limpio %>% 
  summarise(n_distinct(color_flor))

# mean() - Media
bd_plantas_limpio %>% 
  summarise(media_altura = mean(x = altura_m))

# sum() - Suma
bd_plantas_limpio %>% 
  summarise(suma_altura = sum(x=altura_m))

# min() - Mínimo
bd_plantas_limpio %>% 
  summarise(minimo = min(x= altura_m))

# max() - Máximo
bd_plantas_limpio %>% 
  summarise(maximo = max(x= altura_m))

#Otras funciones importantes:
# median() - Mediana
# sd() - Desviación estándar
# first() - Primer valor
# last() - Último valor


# Y los NA??
bd_plantas_limpio %>% 
  summarise(suma_ancho =sum(x=ancho_hoja_cm))

bd_plantas_limpio %>% 
  summarise(suma_ancho =sum(x=ancho_hoja_cm,
                            na.rm = TRUE))

bd_plantas_limpio %>% 
  summarise(media_ancho = mean(x=ancho_hoja_cm,
                            na.rm = TRUE))

#Varias funciones a la vez
bd_plantas_limpio %>% 
  summarise(media = mean(x = ancho_hoja_cm, na.rm = T),
            suma = sum(x = ancho_hoja_cm, na.rm = T),
            minimo = min(x = ancho_hoja_cm, na.rm = T)) 
# agrupando
bd_plantas_limpio %>% 
  summarise(media = mean(x = ancho_hoja_cm, na.rm = T),
       suma = sum(x = ancho_hoja_cm, na.rm = T),
       minimo = min(x = ancho_hoja_cm, na.rm = T),
       .by = color_hoja) 

# Para no escribir todo mil veces
bd_plantas_limpio %>% 
  summarise(across(.cols = c(altura_m, longitud_hoja_cm), 
                   .fns =  mean,
                   na.rm = T))

bd_plantas_limpio %>% 
  summarise(media_ancho = mean(x = longitud_hoja_cm, na.rm = T),
            media_altura = mean(x = altura_m, na.rm = T)) 


#### Modificar texto dentro de tibble ----
#Se usa el paquete Stringr - Tidyverse

#Mayúsculas y minúsculas
bd_plantas_limpio %>% 
  mutate(color = str_to_lower(string = color_flor))

bd_plantas_limpio %>% 
  mutate(color_flor = str_to_lower(string = color_flor))

bd_plantas_limpio %>% 
  mutate(color_flor = str_to_upper(string = color_flor))

bd_plantas_limpio %>% 
  mutate(nombre_cientifico = str_to_title(string = nombre_cientifico))

bd_plantas_limpio %>% 
  mutate(origen = str_to_sentence(string = origen))

#Palabras
bd_plantas_limpio %>% 
  mutate(color_flor = str_replace_all(string = color_flor, pattern = "ca", replacement = "co"),
         color_flor = str_replace_all(string = color_flor, pattern = "lla", replacement = "llo"))

#Modificar todo 
bd_plantas_limpio %>% 
  mutate(color_flor = str_to_lower(string = color_flor),
         color_flor = str_replace_all(string = color_flor, pattern = "ca", replacement = "co"),
         color_flor = str_replace_all(string = color_flor, pattern = "lla", replacement = "llo"))

