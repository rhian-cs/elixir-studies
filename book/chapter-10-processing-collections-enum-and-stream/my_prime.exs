defmodule MyList do
  def span(from, to) when from > to do
    do_span([from], to)
  end

  def span(from, to) do
    do_span([to], from)
  end

  defp do_span(list = [from | _], from), do: list

  defp do_span(list = [head | _tail], from) do
    do_span([head - 1 | list], from)
  end
end

defmodule MyPrime do
  def all(max_value) when max_value >= 2 do
    for x <- MyList.span(2, max_value), prime?(x), do: x
  end

  defp prime?(2), do: true

  defp prime?(n) do
    Enum.all?(previous_numbers(n), &is_not_divisible_by(n, &1))
  end

  defp previous_numbers(n) do
    MyList.span(2, n - 1)
  end

  defp is_not_divisible_by(n, value) do
    rem(n, value) != 0
  end
end
