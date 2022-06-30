defmodule Stack.Server do
  use GenServer
  require Logger
  alias Stack.Impl

  @vsn "1"

  defmodule State do
    defstruct(stack: [], multiplier: 1)
  end

  def code_change("0", old_state = stack, _extra) do
    new_state = %State{
      stack: stack,
      multiplier: 1
    }

    Logger.info("Changing code from 0 to 1")
    Logger.info(inspect(old_state))
    Logger.info(inspect(new_state))

    {:ok, new_state}
  end

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

  def set_multiplier(multiplier) do
    GenServer.cast(__MODULE__, {:set_multiplier, multiplier})
  end

  ## GenServer implementation

  def init(_) do
    state = %State{stack: Stack.Stash.get()}

    {:ok, state}
  end

  def handle_call(:pop, _from, state = %{stack: stack}) do
    {element, new_stack} = Impl.pop(stack)

    {:reply, element, %{state | stack: new_stack}}
  end

  def handle_cast({:push, new_element}, state = %{stack: stack, multiplier: multiplier}) do
    new_stack = Impl.push(stack, new_element, multiplier)

    {:noreply, %{state | stack: new_stack}}
  end

  def handle_cast({:set_multiplier, multiplier}, state) do
    {:noreply, %{state | multiplier: multiplier}}
  end

  def terminate(_reason, stack) do
    Stack.Stash.update(stack)
  end
end
