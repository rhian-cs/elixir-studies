defmodule Stack.Server do
  use GenServer
  alias Stack.Impl

  def init(initial_stack) do
    {:ok, initial_stack}
  end

  def handle_call(:pop, _from, stack) do
    {element, new_stack} = Impl.pop(stack)

    {:reply, element, new_stack}
  end

  def handle_cast({:push, new_element}, stack) do
    {:noreply, Impl.push(stack, new_element)}
  end

  def terminate(reason, stack) do
    IO.puts("Terminating due to '#{reason}', stack: #{IO.inspect(stack)}")
  end
end
