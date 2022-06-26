defmodule Stack.MixProject do
  use Mix.Project

  def project do
    [
      app: :stack,
      version: "0.2.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      env: [initial_stack: [4, 5, 6]],
      registered: [Stack.Server],
      mod: {Stack.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      {:distillery, "~> 1.5", runtime: false},
    ]
  end
end