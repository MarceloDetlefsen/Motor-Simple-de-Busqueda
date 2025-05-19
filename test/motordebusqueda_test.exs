# Universidad del Valle de Guatemala
# Algoritmos y Estructuras de Datos
# Ing. Douglas Barrios
# @author: Marcelo Detlefsen
# Creación: 18/05/2025
# Última modificación: 19/05/2025
# File Name: motordebusqueda_test.exs
# Descripción: Pruebas unitarias para el módulo Motordebusqueda.
#              Incluye pruebas para la inicialización, búsqueda y funcionamiento básico del motor de búsqueda.

defmodule MotordebusquedaTest do
  use ExUnit.Case
  doctest Motordebusqueda

  setup do
    # Limpiar la tabla ETS antes de cada prueba si existe
    if :ets.whereis(:search_index) != :undefined do
      :ets.delete_all_objects(:search_index)
    end

    :ok
  end

  test "greets the world" do
    assert Motordebusqueda.hello() == :world
  end

  test "can start search engine" do
    assert Motordebusqueda.start() == :ok
  end

  test "search returns empty list for non-indexed term" do
    Motordebusqueda.start()
    assert Motordebusqueda.search("término_inexistente") == []
  end
end
