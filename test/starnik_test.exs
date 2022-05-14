defmodule StarnikTest do
  use ExUnit.Case
  doctest Starnik

  test "greets the world" do
    assert Starnik.hello() == :world
  end
end
