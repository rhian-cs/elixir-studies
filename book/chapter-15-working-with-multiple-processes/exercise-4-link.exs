defmodule Child do
  def process(parent_pid) do
    IO.puts("[Child] Spawned")
    send(parent_pid, :message)
    raise "Boom!"
  end
end

defmodule Parent do
  def run() do
    spawn_link(Child, :process, [self()])

    :timer.sleep(500)

    receive do
      message ->
        IO.puts("[Parent] Received message #{message}")
    after
      500 ->
        IO.puts("[Parent] No more messages were received")
    end
  end
end
