defmodule Ok do
  def ok!({:ok, data}), do: data

  def ok!({code, data}) do
    raise "Unexpected response '#{code}', data: #{IO.inspect(data)}"
  end
end
