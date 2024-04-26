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

# Supongamos que 'fuerza_trabajo_data', 'no_ocupados_data' y 'ocupados_data' son tus dataframes

# 2.1 Creación de bases de datos
# Sumar el número de individuos por categoría, teniendo en cuenta el factor de expansión
fuerza_trabajo_sum <- fuerza_trabajo_data[FT == 1 | PET == 1, sum(FEX_C18), by = MES]
ocupados_sum <- ocupados_data[FT == 1, sum(FEX_C18), by = MES]
no_ocupados_sum <- no_ocupados_data[DSI == 1, sum(FEX_C18), by = MES]

# Renombrar las columnas para que sean más descriptivas
setnames(fuerza_trabajo_sum, "V1", "Fuerza_laboral")
setnames(ocupados_sum, "V1", "Ocupados")
setnames(no_ocupados_sum, "V1", "Desempleados")

# 2.2 Colapsar datos a nivel mensual
# Unificar todas las bases de datos en una única base llamada Output
Output <- merge(fuerza_trabajo_sum, ocupados_sum, by = "MES", all = TRUE)
Output <- merge(Output, no_ocupados_sum, by = "MES", all = TRUE)

# 2.3 Tasas de desempleo y ocupación
# Calcular las tasas
Output$Tasa_desempleo <- Output$Desempleados / Output$Fuerza_laboral
Output$Tasa_ocupacion <- Output$Ocupados / Output$Fuerza_laboral

# Imprimir la base de datos Output
print(Output)


