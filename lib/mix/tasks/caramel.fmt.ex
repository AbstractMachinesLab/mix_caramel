defmodule Mix.Tasks.Caramel.Fmt do
  use Mix.Task

  @shortdoc "Format all Caramel files in this project"

  @moduledoc """
  Formats all of the files in this project using the Caramel formatter.
  """

  def run(_) do
    project = Mix.Project.config()
    source_paths = project[:caramel_paths]
    files = Mix.Utils.extract_files(source_paths, [:ml, :mli, :re, :rei])
    :ok = Caramel.format(files)
    IO.puts("💅🏽 formatted #{Enum.count(files)} files (.ml, .mli, .re, .rei)")
  end

end
