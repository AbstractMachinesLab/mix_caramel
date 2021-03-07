defmodule MixCaramel.MixProject do
  use Mix.Project

  def project do
    [
      app: :mix_caramel,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "mix_caramel",
      description: "Use Caramel code in your Elixir projects"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
    ]
  end
end
