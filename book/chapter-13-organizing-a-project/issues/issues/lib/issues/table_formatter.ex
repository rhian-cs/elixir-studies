defmodule TableFormatter do
  def format(list, headers) do
    rows = fetch_rows(list, headers)
    longest_columns = calculate_longest_columns(list, headers)

    format_list_as_table(rows, headers, longest_columns)
  end

  defp fetch_rows(list, headers) do
    Enum.map(list, &map_to_array(&1, Keyword.values(headers)))
  end

  defp map_to_array(map, headers) do
    Enum.map(headers, &Map.get(map, "#{&1}"))
  end

  defp calculate_longest_columns(list, headers) do
    Enum.map(headers, &calculate_longest_entry(list, &1))
  end

  defp calculate_longest_entry(list, {renamed_header, original_header}) do
    list
    |> pluck_from_map_list("#{original_header}")
    |> add_header_to_list(renamed_header)
    |> stringify_list()
    |> Enum.map(&String.length/1)
    |> Enum.max()
  end

  defp pluck_from_map_list(list, key) do
    Enum.map(list, &Map.get(&1, key))
  end

  defp add_header_to_list(list, header) do
    [header | list]
  end

  defp stringify_list(list) do
    Enum.map(list, &"#{&1}")
  end

  defp format_list_as_table(rows, headers, longest_columns) do
    [
      format_row(Keyword.keys(headers), longest_columns),
      format_header_divider(longest_columns),
      format_rows(rows, longest_columns)
    ]
    |> Enum.join("\n")
  end

  defp format_header_divider(longest_columns) do
    longest_columns |> Enum.map(&String.duplicate("-", &1 + 1)) |> Enum.join("+-")
  end

  defp format_rows(rows, longest_columns) do
    Enum.map_join(rows, "\n", &format_row(&1, longest_columns))
  end

  defp format_row(row, longest_columns) do
    row
    |> Enum.zip(longest_columns)
    |> Enum.map_join(" | ", &adjust_row_length/1)
  end

  defp adjust_row_length({field, max_length}) do
    String.pad_trailing("#{field}", max_length)
  end
end
