defmodule MotordebusquedaTest do
  use ExUnit.Case
  doctest Motordebusqueda

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
