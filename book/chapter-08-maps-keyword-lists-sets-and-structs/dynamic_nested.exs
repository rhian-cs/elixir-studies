nested = %{
  buttercup: %{
    actor: %{
      first: "Robin",
      last: "Wright"
    },
    role: "princess"
  },
  westley: %{
    actor: %{
      first: "Cary",
      last: "Elwes"
    },
    role: "farm boy"
  }
}

IO.inspect(get_in(nested, [:buttercup, :actor, :first]))
