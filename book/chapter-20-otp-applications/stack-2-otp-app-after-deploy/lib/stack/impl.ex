defmodule Stack.Impl do
  def pop([head | tail]) do
    {head, tail}
  end

  def push(stack, new_element, multiplier \\ 1) do
    head = new_element * multiplier

    [head | stack]
  end
end
