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
    :ets.new(:search_index, [:set, :public, :named_table])

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Motordebusqueda.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
