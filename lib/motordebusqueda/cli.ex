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
    IO.puts("  2. Indexar Sitios de Ejemplo")
    IO.puts("  3. Buscar")
    IO.puts("  4. Estadísticas")
    IO.puts("  5. Salir")

    menu_loop()
  end

  defp menu_loop do
    IO.puts("\n¿Qué deseas hacer? (1-5): ")

    case IO.gets("") |> String.trim() do
      "1" ->
        indexar_urls()

      "2" ->
        indexar_sitios_ejemplo()

      "3" ->
        buscar()

      "4" ->
        mostrar_estadisticas()

      "5" ->
        IO.puts("¡Hasta luego!")
        System.halt(0)

      _ ->
        IO.puts("Opción no válida. Intenta de nuevo.")
    end

    menu_loop()
  end

  defp indexar_urls do
    IO.puts("\n=== Indexar URLs ===")
    IO.puts("Ingresa las URLs a indexar (separadas por espacios):")
    IO.puts("Ejemplo: https://elixir-lang.org https://hexdocs.pm")

    urls =
      IO.gets("")
      |> String.trim()
      |> String.split(~r/\s+/)
      |> Enum.filter(&(String.length(&1) > 0))
      |> Enum.map(fn url ->
        if String.starts_with?(url, "http") do
          url
        else
          "https://" <> url
        end
      end)

    if Enum.empty?(urls) do
      IO.puts("No se ingresaron URLs.")
    else
      IO.puts("Indexando #{length(urls)} URLs. Esto puede tardar un momento...")
      Motordebusqueda.index_urls(urls)
      IO.puts("Indexación completada.")
    end
  end

  defp indexar_sitios_ejemplo do
    IO.puts("\n=== Indexar Sitios de Ejemplo ===")
    IO.puts("Indexando sitios de ejemplo para pruebas...")
    Motordebusqueda.index_sample_sites()
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

  defp mostrar_estadisticas do
    IO.puts("\n=== Estadísticas del Motor de Búsqueda ===")

    stats = Motordebusqueda.get_stats()

    IO.puts("Palabras indexadas: #{stats.palabras_indexadas}")
    IO.puts("Total de URLs indexadas: #{stats.total_urls}")

    if stats.total_urls > 0 do
      IO.puts("\nURLs en el índice:")

      Enum.each(stats.urls_indexadas, fn url ->
        IO.puts("- #{url}")
      end)
    end
  end
end
