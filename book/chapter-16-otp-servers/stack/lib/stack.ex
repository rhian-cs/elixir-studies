defmodule Stack do
  @server Stack.Server

  def start_link(initial_stack \\ []) do
    GenServer.start_link(@server, initial_stack, name: @server)
  end

  def pop do
    GenServer.call(@server, :pop)
  end

  def push(new_element) do
    GenServer.cast(@server, {:push, new_element})
  end

  def stop(reason \\ :normal) do
    GenServer.stop(@server, reason)
  end
end
