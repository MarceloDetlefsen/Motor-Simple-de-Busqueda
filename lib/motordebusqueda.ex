defmodule Motordebusqueda do
  @moduledoc """
  Motor de búsqueda simplificado con Elixir.
  """
  @user_agents [
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64)",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)"
  ]

  def start() do
    :ets.new(:search_index, [:set, :public, :named_table])
    :ok
  end

  def index_urls(urls) when is_list(urls) do
    urls
    |> Task.async_stream(&index_url/1, max_concurrency: 5)
    |> Stream.run()
  end

  defp index_url(url) do
    headers = [{"User-Agent", Enum.random(@user_agents)}]

    case HTTPoison.get(url, headers) do
      {:ok, %{status_code: 200, body: html}} ->
        words =
          html
          |> Floki.parse_document!()
          |> Floki.text()
          |> String.downcase()
          |> String.split(~r/\W+/, trim: true)
          |> Enum.filter(&(String.length(&1) > 2))

        Enum.each(words, fn word ->
          :ets.update_counter(:search_index, word, {2, {url, 1}}, {word, []})
        end)

      {:error, reason} ->
        IO.puts("Error indexing #{url}: #{reason}")
    end
  end

  def search(query) do
    query = String.downcase(query)

    case :ets.lookup(:search_index, query) do
      [{^query, urls}] ->
        urls
        |> Enum.sort_by(fn {_url, count} -> -count end)
        |> Enum.map(fn {url, count} -> "#{url} (#{count} matches)" end)

      [] ->
        []
    end
  end
end
