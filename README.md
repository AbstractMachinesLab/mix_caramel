# Mix Caramel

A Mix plugin for compiling OCaml files in an existing Mix Project using [caramel](https://github.com/AbstractMachinesLab/caramel).

## Installation

The package can be added to your project through the dependency list in `mix.exs`:

```elixir
def deps do
  [
	{:mix_caramel, git: "https://github.com/AbstractMachinesLab/mix_caramel"}
  ]
end
```


Also, in your `mix.exs` file, don't forget to add it as a compiler and source the path to where your `.ml` files are.

```elixir

  def project do
    [
      app: :test_project,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      compilers: [:caramel] ++ Mix.compilers(),
      caramel_paths: ["path/to/ml_files"]
    ]
  end

```

## Usage

When running `mix compile`, caramelc will automatically run on the specified folder, but will then place all the erlang modules in a `src/`.

You can then run `iex -S mix` in the root directory of your project to have all the elixir AND caramel-built erlang modules in your interactive elixir shell.
