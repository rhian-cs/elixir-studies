defmodule MyList do
  def all?([head | tail], func) do
    func.(head) && all?(tail, func)
  end

  def all?([], _func), do: true

  def each(list, func) do
    do_each(list, func)
    :ok
  end

  defp do_each([head | tail], func) do
    func.(head)
    do_each(tail, func)
  end

  defp do_each([], _func), do: nil

  def filter([head | tail], func) do
    if(func.(head)) do
      [head | filter(tail, func)]
    else
      filter(tail, func)
    end
  end

  def filter([], _func), do: []

  def split(list, threshold) do
    {
      filter_with_index(list, fn index -> index < threshold end),
      filter_with_index(list, fn index -> index >= threshold end)
    }
  end

  def take(list, threshold) do
    filter_with_index(list, fn index -> index < threshold end)
  end

  defp filter_with_index(list, func) do
    do_filter_with_index(list, func, 0)
  end

  defp do_filter_with_index([head | tail], func, index) do
    if(func.(index)) do
      [head | do_filter_with_index(tail, func, index + 1)]
    else
      do_filter_with_index(tail, func, index + 1)
    end
  end

  defp do_filter_with_index([], _func, _index), do: []

  def flatten([]), do: []

  def flatten([head | tail]) when is_list(head) do
    flatten(head ++ tail)
  end

  def flatten([head | tail]) do
    [head | flatten(tail)]
  end
end
