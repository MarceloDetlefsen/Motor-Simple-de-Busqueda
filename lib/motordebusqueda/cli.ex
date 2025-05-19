defmodule Motordebusqueda.CLI do
  @moduledoc """
  Módulo CLI para interactuar con el motor de búsqueda.
  """

  def main do
    # Inicializar la tabla ETS (ahora verifica si ya existe)
    IO.puts("Inicializando motor de búsqueda...")
    Motordebusqueda.start()

    IO.puts("\n=== Motor de Búsqueda Simple ===")
    IO.puts("Comandos disponibles:")
    IO.puts("  1. Indexar URLs")
    IO.puts("  2. Buscar")
    IO.puts("  3. Salir")

    menu_loop()
  end

  defp menu_loop do
    IO.puts("\n¿Qué deseas hacer? (1-3): ")

    case IO.gets("") |> String.trim() do
      "1" ->
        indexar_urls()

      "2" ->
        buscar()

      "3" ->
        IO.puts("¡Hasta luego!")
        System.halt(0)

      _ ->
        IO.puts("Opción no válida. Intenta de nuevo.")
        menu_loop()
    end

    menu_loop()
  end

  defp indexar_urls do
    IO.puts("\n=== Indexar URLs ===")
    IO.puts("Ingresa las URLs a indexar (separadas por espacios):")

    urls =
      IO.gets("")
      |> String.trim()
      |> String.split(" ")
      |> Enum.filter(&(String.length(&1) > 0))

    if Enum.empty?(urls) do
      IO.puts("No se ingresaron URLs.")
    else
      IO.puts("Indexando #{length(urls)} URLs. Esto puede tardar un momento...")
      Motordebusqueda.index_urls(urls)
      IO.puts("Indexación completada.")
    end
  end

  defp buscar do
    IO.puts("\n=== Buscar ===")
    IO.puts("Ingresa el término de búsqueda:")

    query = IO.gets("") |> String.trim()

    if String.length(query) < 3 do
      IO.puts("El término de búsqueda debe tener al menos 3 caracteres.")
    else
      IO.puts("Resultados para '#{query}':")

      case Motordebusqueda.search(query) do
        [] ->
          IO.puts("No se encontraron resultados.")

        results ->
          results
          |> Enum.with_index(1)
          |> Enum.each(fn {result, index} ->
            IO.puts("#{index}. #{result}")
          end)
      end
    end
  end
end
