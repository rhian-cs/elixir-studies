## Find the library functions to do the following, and then use each in IEx.
## (If the word Elixir or Erlang appears at the end of the challenge, then you’ll find the answer in that set of libraries.)

# Convert a float to a string with two decimal digits. (Erlang)
# -> https://www.erlang.org/doc/man/io.html#type-format
:io.fwrite("~.2f~n", [23.14159265]) # => 23.14

# Get the value of an operating-system environment variable. (Elixir)
# -> https://stackoverflow.com/questions/38132936/how-to-get-the-value-of-an-environment-variable-in-elixir-on-windows
IO.puts System.get_env("LC_NAME") # => "pt_BR.UTF-8"

# Return the extension component of a file name (so return .exs if given "dave/test.exs" ). (Elixir)
# -> https://hexdocs.pm/elixir/1.12/Regex.html
captures = Regex.named_captures(~r/.*(?<extension>\..*)/, "dave/test.exs")
IO.puts captures["extension"] # => ".exs"

# Return the process’s current working directory. (Elixir)
# -> https://hexdocs.pm/elixir/1.12/Process.html
# IO.puts self() # => #PID<0.109.0>

# Convert a string containing JSON into Elixir data structures. (Just find; don’t install.)
# -> https://gist.github.com/cromwellryan/6349503

# Execute a command in your operating system’s shell.
# -> https://hexdocs.pm/elixir/1.12/System.html#cmd/3
System.cmd("ls", ["-a"]) # => {".\n..\n7.exs\n.7.exs.swp\n", 0}

