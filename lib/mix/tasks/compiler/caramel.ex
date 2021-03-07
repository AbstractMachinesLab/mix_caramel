defmodule Mix.Tasks.Compile.Caramel do
  use Mix.Task.Compiler

  def run(_) do
    project = Mix.Project.config()
    source_paths = project[:caramel_paths]
    version = project[:caramel_release]
    :ok = Caramel.ensure_version(version)
    Mix.Compilers.Erlang.assert_valid_erlc_paths(source_paths)
    files = Mix.Utils.extract_files(source_paths, [:ml, :mli, :re, :rei])
    :ok = Caramel.compile(files)
  end
end
