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
end
