# Ejercicios Capítulo 2 Flex

Implementación de los ejercicios del capítulo 2 del libro *Flex &
Bison*.

Cada ejercicio está organizado en una carpeta independiente que
contiene:

-   El archivo fuente `.l`
-   El archivo de prueba `Prueba.txt`

------------------------------------------------------------------------

# 📁 Estructura del Proyecto

EjerciciosFlex/ │ ├── Ejercicio1/ │ ├── Ejercicio1.l │ └── Prueba.txt │
├── Ejercicio2/ │ ├── Ejercicio2.l │ └── Prueba.txt │ └── Ejercicio3/
├── Ejercicio3.l └── Prueba.txt

------------------------------------------------------------------------

# Requerimientos del Sistema

Se requiere:

-   GCC (compilador de C)
-   Flex
-   Librería libfl

## Instalación (si no está instalado)

sudo apt update sudo apt install flex bison gcc

Verificar:

    flex --version gcc --version

------------------------------------------------------------------------

# Compilación y Ejecución por Ejercicio

 IMPORTANTE: Compilar cada ejercicio desde su carpeta correspondiente.

------------------------------------------------------------------------

# EJERCICIO 1

    cd Ejercicio1 flex Ejercicio1.l gcc lex.yy.c -lfl -o Ejercicio1
    ./Ejercicio1 Prueba.txt

------------------------------------------------------------------------

#  EJERCICIO 2

    cd Ejercicio2 flex Ejercicio2.l gcc lex.yy.c -lfl -o Ejercicio2
    ./Ejercicio2 Prueba.txt

------------------------------------------------------------------------

#  EJERCICIO 3

    cd Ejercicio3 flex Ejercicio3.l gcc lex.yy.c -lfl -o Ejercicio3
    ./Ejercicio3 Prueba.txt

------------------------------------------------------------------------

# Descripción de los Programas

## Ejercicio 1 -- Procesamiento por bloques

-   Cuenta líneas, palabras y caracteres.
-   Procesa bloques usando \[\^\\n\]+
-   Maneja el salto de línea explícitamente.

Salida ejemplo:

Lines: X Words: Y Chars: Z

------------------------------------------------------------------------

## Ejercicio 2 -- Concordancia case-insensitive

-   Construye tabla hash de palabras.
-   No distingue mayúsculas/minúsculas.
-   Usa tolower() en hash.
-   Usa strcasecmp() para comparar.
-   Muestra palabra y líneas donde aparece.

------------------------------------------------------------------------

## Ejercicio 3 -- Tabla hash con chaining

-   Implementa tabla hash con listas enlazadas.
-   Maneja colisiones.
-   Usa memoria dinámica (malloc).
-   Genera referencia cruzada palabra → líneas.

------------------------------------------------------------------------
