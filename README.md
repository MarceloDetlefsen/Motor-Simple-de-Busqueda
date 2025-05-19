# Motor Simple de Busqueda en Elixir
https://github.com/MarceloDetlefsen/Motor-Simple-de-Busqueda.git

# 📊 Resumen del Proyecto
Este proyecto implementa un motor de búsqueda simple en Elixir que:
1. Indexa contenido web: Puede extraer y analizar texto de páginas web reales o sitios de ejemplo
2. Almacena un índice invertido: Guarda una estructura de datos optimizada para búsquedas rápidas
3. Procesa y clasifica resultados: Ordena los resultados según la relevancia (frecuencia de palabras)
4. Proporciona una interfaz CLI: Ofrece un menú interactivo en la línea de comandos

El motor utiliza ETS (Erlang Term Storage) para almacenar eficientemente el índice en memoria, y emplea procesamiento concurrente para indexar múltiples URLs de forma simultánea.

# 🛠️ Instalación y Ejecución
1. Clonar el repositorio:
    ```bash
    git clone https://github.com/MarceloDetlefsen/Motor-Simple-de-Busqueda.git
    cd motor-de-busqueda
    ```

2. Instalar las dependencias:
    ```bash
    mix deps.get
    ```

3. Compilar el programa:
    ```bash 
    mix compile
    ```

4. Ejecutar el programa:
    ```bash
    mix motor
    ```

# 📚 Flujo de Trabajo Recomendado
Para probar el motor de búsqueda:
1. Ejecuta mix motor
2. Selecciona la opción 2 para indexar los sitios de ejemplo
3. Selecciona la opción 3 y busca términos como "elixir" o "programación"
4. Explora las estadísticas con la opción 4
5. Para probar con sitios web reales, usa la opción 1 (requiere conexión a internet)

# Autor
👨‍💻 Marcelo Detlefsen