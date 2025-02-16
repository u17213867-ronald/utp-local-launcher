# Proyecto de Gestión de Servicios y Contenedores

Este proyecto está diseñado para manejar la construcción, actualización, inicio y detención de diversos proyectos y contenedores mediante comandos `Makefile`. A continuación, se describen las secciones y comandos disponibles en el archivo `Makefile`.

## Variables

- **BRANCH**: Especifica la rama del repositorio que se utilizará. Por defecto, está configurado como `develop`.

## Secciones de Comandos

### 1. **Build Section (Construcción)**
Esta sección está destinada a construir proyectos específicos y todos los proyectos en general.

- **build**: Construye todos los proyectos definidos en el `Makefile`.
  - Uso:
    ```bash
    make build
    ```

### 2. **Update Section (Actualización)**
Esta sección se usa para actualizar un proyecto específico o todos los proyectos.

- **update**: Actualiza todos los proyectos.
  - Uso:
    ```bash
    make update
    ```

### 3. **Start Section (Inicio)**
Comandos para iniciar servicios y contenedores.

- **up**: Inicia todos los contenedores de infraestructura, servicios, portal y Solr.
  - Uso:
    ```bash
    make up
    ```

- **down**: Detiene y elimina todos los contenedores Docker activos.
  - Uso:
    ```bash
    make down
    ```

### 4. **Help Section (Ayuda)**
- **help**: Muestra la lista de todos los comandos disponibles con su descripción.
  - Uso:
    ```bash
    make help
    ```

## Variables de Estilo

El archivo `Makefile` incluye una sección que utiliza colores para mejorar la legibilidad de los mensajes en la terminal:
- **GREEN**: Color verde
- **WHITE**: Color blanco
- **YELLOW**: Color amarillo
- **RESET**: Resetea el color a los valores predeterminados de la terminal

## Requerimientos

Asegúrate de tener las siguientes herramientas instaladas:
- `make`: Para ejecutar los comandos.
- `docker`: Para manejar contenedores.
- `perl`: Utilizado para generar la salida del comando de ayuda.

## Cómo usar el `Makefile`

1. Clona el repositorio y navega hasta el directorio donde se encuentra el `Makefile`.
2. Ejecuta los comandos de `make` según sea necesario. Ejemplo:
   ```bash
   make build
