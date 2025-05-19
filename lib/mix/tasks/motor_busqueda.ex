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
