defmodule Chop do
  def guess(actual, range) do
    do_guess(actual, calculate_current(range), range)
  end

  defp calculate_current(range_start..range_end) do
    div(range_end + range_start, 2)
  end

  defp do_guess(actual, current, _) when actual == current, do: actual

  defp do_guess(actual, current, _..range_end) when actual > current do
    reattempt_guess(actual, current, current..range_end)
  end

  defp do_guess(actual, current, range_start.._) when actual < current do
    reattempt_guess(actual, current, range_start..current)
  end

  defp reattempt_guess(actual, current, range_start..range_end = new_range) do
    IO.puts("[#{range_start}..#{range_end}] Is it #{current}? Lower!")
    do_guess(actual, calculate_current(new_range), new_range)
  end
end
