defmodule Motordebusqueda.MixProject do
  use Mix.Project

  def project do
    [
      app: :motordebusqueda,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :inets, :ssl],
      mod: {Motordebusqueda.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # HTTP client
      {:httpoison, "~> 2.1"},
      # Parser HTML
      {:floki, "~> 0.34.0"}
    ]
  end

  # Define aliases
  defp aliases do
    [
      # Alias para ejecutar el motor de búsqueda
      motor: ["run -e 'Motordebusqueda.CLI.main()'"]
    ]
  end
end
