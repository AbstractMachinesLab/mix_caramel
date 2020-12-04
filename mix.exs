defmodule MixCaramel.MixProject do
  use Mix.Project

  def project do
    [
      app: :mix_caramel,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "mix_caramel",
      description: "Compile OCaml code with mix using Caramel",
      package: [
        maintainers: ["Calin Capitanu","James Russo"],
        licenses: ["Apache-2.0"],
        links: %{"GitHub" => "https://github.com/AbstractMachinesLab/mix_caramel"}
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
