# `mix_caramel`

Drop-in plugin to start writing [Caramel](https://caramel.run) code in your
Elixir projects.

## Features

* Handles per-project installation of the Caramel compiler
* Integrates into the existing compilation flows: `mix compile`
* Type-check directly from `iex` when running `recompile`
* Easy autoformatting of sources: `mix caramel.fmt`
* Fast manual-type checking with `mix caramel.check`

```sh
λ mix compile
==> mix_caramel
Compiling 1 file (.ex)
📦 Installing Caramel v0.1.1...
🍬 Using Caramel v0.1.1
Compiling todo.erl      OK

==> hello_world
Compiling 1 file (.erl)
Compiling 14 files (.ex)
λ mix caramel

Available tasks:

mix caramel.check # Type-check all Caramel modules in this project
mix caramel.fmt   # Format all Caramel files in this project
λ mix caramel.check
Compiling todo.erl      OK

λ mix caramel.fmt
💅🏽 formatted 1 files (.ml, .mli, .re, .rei)
```

## Installation

The package can be added to your project through the dependency list in
`mix.exs`, and you need to tell it what version of Caramel you want to run and
where to look for the Caramel sources.

```elixir
def deps do
  [{:mix_caramel, git: "https://github.com/AbstractMachinesLab/mix_caramel", branch: :main}]
end

def project do
  [
    app: :test_project,
    version: "0.1.0",
    elixir: "~> 1.11",
    start_permanent: Mix.env() == :prod,
    deps: deps(),
    compilers: [:caramel] ++ Mix.compilers(),
    caramel_paths: ["src"],
    caramel_release: "v0.1.1"
  ]
end
```
