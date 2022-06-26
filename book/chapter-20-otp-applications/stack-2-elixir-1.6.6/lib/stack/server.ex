defmodule Stack.Server do
  use GenServer
  alias Stack.Impl

  @vsn "0"

  ## External API

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def pop do
    with element = GenServer.call(__MODULE__, :pop),
    do: "#{element} was removed from the stack."
  end

  def push(new_element) do
    GenServer.cast(__MODULE__, {:push, new_element})
  end

  ## GenServer implementation

  def init(_) do
    {:ok, Stack.Stash.get()}
  end

  def handle_call(:pop, _from, stack) do
    {element, new_stack} = Impl.pop(stack)

    {:reply, element, new_stack}
  end

  def handle_cast({:push, new_element}, stack) do
    {:noreply, Impl.push(stack, new_element)}
  end

  def terminate(_reason, stack) do
    Stack.Stash.update(stack)
  end
end
