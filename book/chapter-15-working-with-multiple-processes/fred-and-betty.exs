defmodule FredBetty do
  def send_message(pid, name) do
    send(pid, name)
  end

  def run do
    spawn(FredBetty, :send_message, [self(), "Fred"])
    spawn(FredBetty, :send_message, [self(), "Betty"])

    listen()
  end

  defp listen() do
    receive do
      name ->
        IO.puts(name)
        listen()
    after
      1000 ->
        IO.puts("Fred and Betty are gone.")
    end
  end
end
