defmodule FileCatFinder do
  def find(scheduler) do
    send(scheduler, {:ready, self()})

    receive do
      {:find, filename, client} ->
        send(client, {:answer, filename, search_for_cat(filename), self()})
        find(scheduler)

      {:shutdown} ->
        exit(:normal)
    end
  end

  defp search_for_cat(filename) do
    string = File.read!(filename)

    if String.contains?(string, "cat") do
      IO.puts("#{filename} has cat in it!")
    else
      IO.puts("#{filename} doesn't have cat in it!")
    end
  end
end

defmodule Scheduler do
  def run(num_processes, module, func, to_calculate) do
    1..num_processes
    |> Enum.map(fn _ -> spawn(module, func, [self()]) end)
    |> schedule_processes(to_calculate, [])
  end

  defp schedule_processes(processes, queue, results) do
    receive do
      {:ready, pid} when length(queue) > 0 ->
        [next | tail] = queue
        send(pid, {:find, next, self()})
        schedule_processes(processes, tail, results)

      {:ready, pid} ->
        send(pid, {:shutdown})

        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn {n1, _}, {n2, _} -> n1 <= n2 end)
        end

      {:answer, number, result, _pid} ->
        schedule_processes(processes, queue, [{number, result} | results])
    end
  end
end

filenames = File.ls!() |> Enum.reject(&File.dir?/1)

Enum.each(1..10, fn num_processes ->
  {time, result} =
    :timer.tc(
      Scheduler,
      :run,
      [num_processes, FileCatFinder, :find, filenames]
    )

  if num_processes == 1 do
    IO.puts(inspect(result))
    IO.puts("\n #   time (s)")
  end

  :io.format("~2B     ~.2f~n", [num_processes, time / 1_000_000.0])
end)
