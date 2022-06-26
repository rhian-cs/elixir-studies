defmodule Stack.Stash do
  use GenServer

  @name __MODULE__
  def start_link(initial_stack) do
    GenServer.start_link(__MODULE__, initial_stack, name: @name)
  end

  def get do
    GenServer.call(@name, {:get})
  end

  def update(new_stack) do
    GenServer.cast(@name, {:update, new_stack})
  end

  ## Server Implementation

  def init(initial_stack) do
    {:ok, initial_stack}
  end

  def handle_call({:get}, _from, stack) do
    {:reply, stack, stack}
  end

  def handle_cast({:update, new_stack}, _stack) do
    {:noreply, new_stack}
  end
end
