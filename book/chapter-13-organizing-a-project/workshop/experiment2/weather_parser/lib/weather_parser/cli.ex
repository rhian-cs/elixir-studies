defmodule WeatherParser.CLI do
  @moduledoc """
  Handle the command line parsing and the dispatch
  to the module that fetches weather data from
  the american weather API
  """
  def main(argv) do
    argv
    |> parse_args()
    |> process()
  end

  @doc """
  `argv` can be -h or --help, which returns :help.

  Otherwise it is expected to be an american location, e.g. `KDTO`.

  Returns :help if help was called, otherwise returns the specified
  location.
  """
  def parse_args(argv) do
    case parse_args_from_string(argv) do
      {[help: true], _, _} -> :help
      {_, [location], _} -> location
      _ -> :help
    end
  end

  defp parse_args_from_string(argv) do
    OptionParser.parse(
      argv,
      switches: [help: :boolean],
      aliases: [h: :help]
    )
  end

  defp process(location) do
    WeatherParser.WeatherGov.fetch(location)
    |> decode_response()
    |> pretty_output()
  end

  def decode_response({:ok, weather}), do: weather

  def decode_response({:error, error}) do
    IO.puts("Error fetching weather: #{error}")
    System.halt(2)
  end

  def pretty_output(weather) do
    "The weather at #{weather[:location]} is #{weather[:weather]} at #{weather[:temp_c]}°C."
    |> IO.puts()
  end

  defp process(:help) do
    IO.puts("""
    usage: weather_parser <location>
    """)

    System.halt(0)
  end
end
