# Use spawn_link to start a process, and have that process send a message
# to the parent and then exit immediately. Meanwhile, sleep for 500 ms in
# the parent, then receive as many messages as are waiting. Trace what
# you receive. Does it matter that you weren’t waiting for the notification
# from the child when it exited?

defmodule Child do
  def process(parent_pid) do
    IO.puts("[Child] Spawned")
    send(parent_pid, :message)
    exit(:boom)
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
