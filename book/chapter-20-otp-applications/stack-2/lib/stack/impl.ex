defmodule Stack.Impl do
  def pop([head | tail]) do
    {head, tail}
  end

  def push(stack, new_element) do
    [new_element | stack]
  end
end
