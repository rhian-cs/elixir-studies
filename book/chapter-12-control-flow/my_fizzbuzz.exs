defmodule MyFizzBuzz do
  def calculate(max) when max <= 0, do: []

  def calculate(max) do
    1..max |> Enum.to_list() |> do_calculate([]) |> Enum.reverse()
  end

  def do_calculate([], fizzwords), do: fizzwords

  def do_calculate([head | tail], fizzwords) do
    do_calculate(tail, [calculate_fizzword(head) | fizzwords])
  end

  def calculate_fizzword(n) do
    case {divisible_by(n, 3), divisible_by(n, 5)} do
      {true, true} -> "FizzBuzz"
      {true, false} -> "Fizz"
      {false, true} -> "Buzz"
      _ -> n
    end
  end

  defp divisible_by(number, divisor) do
    rem(number, divisor) == 0
  end
end
