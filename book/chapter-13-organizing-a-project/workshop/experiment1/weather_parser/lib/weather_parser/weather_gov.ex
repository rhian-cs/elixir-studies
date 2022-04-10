defmodule WeatherParser.WeatherGov do
  @api_url Application.get_env(:weather_parser, :api_url)
  @headers [{"User-agent", "Elixir rhian.luis.cs+github@gmail.com"}]

  def fetch(location) do
    location
    |> weather_url()
    |> HTTPoison.get(@headers)
    |> handle_response()
  end

  defp weather_url(location) do
    "#{@api_url}/xml/current_obs/#{location}.xml"
  end

  defp handle_response({:ok, %{status_code: 200, body: body}}) do
    {:ok, WeatherXmlParser.parse(body)}
  end

  defp handle_response({_, %{status_code: _, body: body}}) do
    {:error, body}
  end
end
