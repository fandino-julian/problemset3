##Problem Set 3
## Julian Fandiño_202021070##
version
## version.string R version 4.3.2 (2023-10-31)##

# Cargar las librerías
library(pacman)
library(rio)
library(data.table)
library(tidyverse)

# Establecer la ruta de la carpeta input
ruta_input <- "~/Desktop/R/Problem sets/ps3/pset-3/input"

# Crear un vector con los nombres de los archivos en la carpeta input
# Usamos full.names = TRUE para obtener la ruta completa de cada archivo
file_list <- list.files(path = ruta_input, recursive = TRUE, full.names = TRUE)

# Imprimir la lista de archivos
print(file_list)

# Función para importar una lista de archivos
import_list <- function(file_list) {
  # Aplicamos la función import_file a cada archivo en la lista file_list
  data_list <- lapply(file_list, import_file)
  
  # Devolvemos la lista de dataframes
  return(data_list)
}

# Crear las listas de rutas de archivos para cada categoría
rutas_fuerza_trabajo <- file_list %>% str_subset("Fuerza de trabajo")
rutas_no_ocupados <- file_list %>% str_subset("No ocupados")
rutas_ocupados <- file_list %>% str_subset("Ocupados")

# Importar los archivos y combinarlos en dataframes
fuerza_trabajo_data <- import_list(rutas_fuerza_trabajo) %>% rbindlist(l=., use.names=T , fill=T)
no_ocupados_data <- import_list(rutas_no_ocupados) %>% rbindlist(l=., use.names=T , fill=T)
ocupados_data <- import_list(rutas_ocupados) %>% rbindlist(l=., use.names=T , fill=T)


