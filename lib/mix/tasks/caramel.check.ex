defmodule Mix.Tasks.Caramel.Check do
  use Mix.Task

  @shortdoc "Type-check all Caramel modules in this project"

  @moduledoc """
  Type-checks all of the files in this project.
  """

  def run(_) do
    project = Mix.Project.config()
    source_paths = project[:caramel_paths]
    files = Mix.Utils.extract_files(source_paths, [:ml, :mli, :re, :rei])
    :ok = Caramel.compile(files)
  end
end
