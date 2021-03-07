defmodule Mix.Tasks.Caramel do
  use Mix.Task

  @shortdoc "Prints Caramel help information"

  @moduledoc """
  Prints Caramel tasks and their information.
      mix caramel
  """

  @doc false
  def run(args) do
    case args do
      [] -> general()
      _ -> Mix.raise "Invalid arguments, expected: mix caramel"
    end
  end

  defp general() do
    Mix.shell().info "\nAvailable tasks:\n"
    Mix.Tasks.Help.run(["--search", "caramel."])
  end
end
