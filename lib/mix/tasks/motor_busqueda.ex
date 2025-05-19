# Universidad del Valle de Guatemala
# Algoritmos y Estructuras de Datos
# Ing. Douglas Barrios
# @author: Marcelo Detlefsen
# Creación: 18/05/2025
# Última modificación: 19/05/2025
# File Name: motor_busqueda.ex
# Descripción: Tarea Mix personalizada para iniciar el motor de búsqueda desde la línea de comandos.
#              Se asegura de cargar las dependencias y ejecuta la interfaz CLI del sistema.

defmodule Mix.Tasks.MotorBusqueda do
  use Mix.Task

  @shortdoc "Inicia el motor de búsqueda"
  def run(_) do
    # Asegurarse de que todas las dependencias estén cargadas
    Application.ensure_all_started(:motordebusqueda)

    # Iniciar el CLI
    Motordebusqueda.CLI.main()
  end
end
