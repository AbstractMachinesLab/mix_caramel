defmodule Mix.Tasks.Compile.Caramel do
  use Mix.Task.Compiler

  def run(_) do
    project = Mix.Project.config()
    source_paths = project[:caramelc_paths]
    Mix.Compilers.Erlang.assert_valid_erlc_paths(source_paths)
    files = Mix.Utils.extract_files(source_paths, [:ml, :mli])
    run_caramel(files)
    :ok
  end

  def run_caramel(files) do
    Mix.Shell.cmd(
      "caramel compile " <> Enum.join(files, " "),
      [],
      (fn res -> IO.puts(res) end)
    )
    Mix.Shell.cmd(
      "mv *.erl src",
      [],
      (fn _ -> :ok  end)
    )
  end
end
