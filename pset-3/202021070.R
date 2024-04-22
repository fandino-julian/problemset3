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

# Función para importar un archivo
import_file <- function(file_path) {
  # Usamos la función import de la librería rio para importar el archivo
  data <- rio::import(file_path)
  
  # Devolvemos los datos importados
  return(data)
}

# Aplicamos la función import_file a cada archivo en la lista file_list
data_list <- lapply(file_list, import_file)

# Combinamos todos los dataframes en uno solo usando rbindlist de la librería data.table
combined_data <- data.table::rbindlist(data_list, fill = TRUE)

# Imprimir los datos combinados
print(combined_data)