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
  end

  def take(list, index) do
  end
end
