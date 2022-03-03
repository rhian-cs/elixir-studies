defmodule MyList do
  def map([], _func), do: []

  def map([head | tail], func) do
    [func.(head) | map(tail, func)]
  end

  def reduce([], value, _fun), do: value

  def reduce([head | tail], value, fun) do
    reduce(tail, fun.(head, value), fun)
  end

  # MyList.mapsum [1, 2, 3], &(&1 * &1) => 14
  def mapsum([], _fun), do: 0

  def mapsum(list, fun) do
    map(list, fun) |> reduce(0, &(&1 + &2))
  end

  def max([]), do: 0

  def max([head | tail]) do
    do_max(tail, head)
  end

  defp do_max([], current_max), do: current_max

  defp do_max([head | tail], current_max) do
    new_max = if head > current_max, do: head, else: current_max

    do_max(tail, new_max)
  end

  def caesar(list, offset) do
    Enum.map(list, &caesar_offset(&1, offset))
  end

  defp caesar_offset(character, offset) do
    if character + offset > ?z do
      character - offset
    else
      character + offset
    end
  end

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
