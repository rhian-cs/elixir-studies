defmodule WeatherParser.CLI do
  def run(argv) do
    argv
    |> parse_args()
    |> process
  end

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

  def process(:help) do
    IO.puts("""
    usage: weather_parser <location>
    """)

    System.halt(0)
  end
end
