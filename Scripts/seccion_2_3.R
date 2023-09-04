#################################
# Curso Introducción a R
# NOMBRE
# Sección 2.3
# BASES DE DATOS -Unión de bases
#################################

##### Cargado de paquetes----
pacman::p_load(tidyverse,
               janitor)

#### Bases de datos ----

#Importar bases de datos:


#Explorar bases de datos:
medallas_1 %>% 
  glimpse()

medallas_2 %>% 
  str()

medallas_3 %>% 
  colnames()

medallas_4 %>% 
  head()

medallas_5 %>% 
  tail()

#Limpiar nombres:
medallas_1 <- medallas_1 %>% 
  clean_names()

medallas_2 <- medallas_2 %>% 
  clean_names()

medallas_3 <- medallas_3 %>% 
  clean_names()

medallas_4 <- medallas_4 %>% 
  clean_names()

#### Unir por filas ----
# Caso 1: Ambas tienen las mismas variables:
bind_rows(medallas_1,
          medallas_2)

bind_rows(medallas_2,
          medallas_1)

# Caso 2: NO tienen las mismas variables:
bind_rows(medallas_1,
          medallas_3)

#### Unir por columnas ----

# Caso 1: Comparten algunas variables y tienen las mismas filas
bind_cols(medallas_1,
          medallas_4)

# Eliminar las columnas repetidas:
bind_cols(medallas_1,
          medallas_4 %>% select(-c(1:3))) #¿Qué función nos ayuda a seleccionar columnas?

# Caso 2: Comparten algunas variables y tienen las mismas filas
#         pero las observaciones están en otro orden

bind_cols(medallas_1,
          medallas_5)

medallas_5 %>% 
  arrange(lugar) %>% # ¿Cómo reordenamos las observaciones en una columna?
  select(-c(1:3)) %>% # ¿Cómo seleccionamos las columnas?
  bind_cols(medallas_1) %>%  # ¿Cómo unimos las bases?
  relocate(1:3, .after = "total") # ¿Cómo cambiamos el orden de las columnas?

  
#Caso 3: Comparten algunas variables pero no tienen las mismas filas
bind_cols(medallas_1,
          medallas_6)

full_join(medallas_1,
          medallas_6)

# Otra opción para escribir menos código en el caso 2: Usar una "llave"
medallas_1 %>% 
  full_join(y = medallas_5,
            by = c("lugar" ,
                   "pais",
                   "codigo_pais"))

medallas_1 %>% 
  full_join(y = medallas_5,
            by = c("lugar"))


