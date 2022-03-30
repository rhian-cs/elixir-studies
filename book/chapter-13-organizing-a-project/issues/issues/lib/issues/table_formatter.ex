defmodule TableFormatter do
  def format(list) do
    headers = fetch_headers(list)

    fetch_columns(list, headers)
    |> calculate_max_columns_length(headers)
    |> format_list_to_table(list)
  end

  defp fetch_headers([head | _]) do
    Map.keys(head)
  end

  defp fetch_columns(list, headers) do
    Enum.map(headers, &fetch_column_values(&1, list))
  end

  defp fetch_column_values(key, list) do
    [key | Enum.map(list, &Map.get(&1, key))]
  end

  defp calculate_max_columns_length(columns, headers) do
    longest_strings = Enum.map(columns, &longest_string_in_column/1)

    Enum.zip(headers, longest_strings)
  end

  defp longest_string_in_column(column) do
    column
    |> Enum.map(&String.length/1)
    |> Enum.max()
  end

  defp format_list_to_table(max_column_lengths, list) do
    Enum.map(list, &format_table_row(&1, max_column_lengths))
    |> Enum.join("\n")
  end

  defp format_table_row(row, max_column_lengths) do
    Enum.map(row, &format_table_row_column(&1, max_column_lengths))
    |> Enum.join(" | ")
  end

  defp format_table_row_column({key, value}, max_column_lengths) do
    {_, pad_length} = Enum.find(max_column_lengths, 0, fn {pair_key, _} -> pair_key == key end)

    String.pad_trailing(value, pad_length, " ")
  end
end
