defmodule MyString do
  defguard invalid_ascii?(char) when char not in ?\s..?~

  def ascii_only?([head | _tail]) when invalid_ascii?(head), do: false
  def ascii_only?([_head | tail]), do: ascii_only?(tail)
  def ascii_only?([]), do: true

  def anagram?(word1, word2) do
    do_anagram?(
      String.to_charlist(word1),
      String.to_charlist(word2)
    )
  end

  defp do_anagram?(charlist1, charlist2) do
    Enum.sort(charlist1) == Enum.sort(charlist2)
  end

  def calculate(operation_str) do
    operation_str |> filter_blank |> parse_operation
  end

  defp filter_blank(str) do
    Enum.reject(str, &(&1 == ?\s))
  end

  defp parse_operation(operation_str) do
    {charlist1, [operation | charlist2]} = split_operation_str(operation_str)

    calculate_operation(
      [operation],
      [
        integer_from_charlist(charlist1),
        integer_from_charlist(charlist2)
      ]
    )
  end

  defp split_operation_str(operation_str) do
    Enum.split_while(operation_str, &(&1 in ?0..?9))
  end

  defp integer_from_charlist(charlist) do
    Enum.reverse(charlist) |> do_integer_from_charlist(1)
  end

  defp do_integer_from_charlist([head | tail], factor) when head in ?0..?9 do
    do_integer_from_charlist(tail, factor * 10) + (head - ?0) * factor
  end

  defp do_integer_from_charlist([], _), do: 0

  defp calculate_operation(operation, numbers) do
    apply(Kernel, operation |> List.to_atom(), numbers)
  end
end
