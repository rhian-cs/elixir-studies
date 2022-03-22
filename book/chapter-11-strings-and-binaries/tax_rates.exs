defmodule TaxCalculator do
  @tax_rates [NC: 0.075, TX: 0.08]

  def calculate(orders) do
    for order <- orders do
      [{:total_amount, calculate_total_amount(order, @tax_rates)} | order]
    end
  end

  defp calculate_total_amount(order, tax_rates) do
    order[:net_amount] * tax_rate_factor(order, tax_rates)
  end

  defp tax_rate_factor(order, tax_rates) do
    1 + Keyword.get(tax_rates, order[:ship_to], 0)
  end
end

defmodule CSVParser do
  def parse(filename) do
    {:ok, file} = File.open(filename)
    stream = IO.stream(file, :line)
    headers = read_header(file)

    format(stream, headers) |> Enum.to_list()
  end

  defp read_header(file) do
    file
    |> IO.read(:line)
    |> parse_line()
    |> Enum.map(&String.to_atom/1)
  end

  defp format(stream, headers) do
    Stream.map(stream, &read_body_line(&1, headers))
  end

  defp read_body_line(line, headers) do
    Enum.zip(headers, evaluate_line(line))
  end

  defp evaluate_line(line) do
    parse_line(line) |> Enum.map(&eval/1)
  end

  defp parse_line(line) do
    line |> String.trim() |> String.split(",")
  end

  defp eval(string) do
    {value, _} = Code.eval_string(string)

    value
  end
end

Path.absname("book/chapter-11-strings-and-binaries/taxes.csv")
|> CSVParser.parse()
|> TaxCalculator.calculate()
|> IO.inspect()
