defmodule WeatherParserTest do
  use ExUnit.Case
  doctest WeatherParser

  test "greets the world" do
    assert WeatherParser.hello() == :world
  end
end
