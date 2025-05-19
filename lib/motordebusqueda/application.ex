# Universidad del Valle de Guatemala
# Algoritmos y Estructuras de Datos
# Ing. Douglas Barrios
# @author: Marcelo Detlefsen
# Creación: 18/05/2025
# Última modificación: 19/05/2025
# File Name: application.ex
# Descripción: Este módulo define la aplicación principal para el motor de búsqueda simple.
#              Al iniciar, se asegura de que exista una tabla ETS llamada :search_index,
#              la cual se utilizará para almacenar el índice de búsqueda en memoria.
#              Además, configura el supervisor principal de la aplicación.

defmodule Motordebusqueda.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Motordebusqueda.Worker.start_link(arg)
      # {Motordebusqueda.Worker, arg}
    ]

    # Inicializar la tabla ETS al arrancar la aplicación
    # Verificar si la tabla ya existe antes de crearla
    case :ets.whereis(:search_index) do
      :undefined ->
        :ets.new(:search_index, [:set, :public, :named_table])

      _ ->
        # La tabla ya existe, no hacer nada
        :ok
    end

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Motordebusqueda.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
