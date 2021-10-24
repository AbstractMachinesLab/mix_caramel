defmodule Mix.Tasks.Compile.Caramel do
  use Mix.Task.Compiler

  require Logger

  def run(_) do
    project = Mix.Project.config()
    version = project[:caramel_release] || current_version

    # If we're running in an umbrella project we need to specify exactly
    # where each source file it within apps path. This has the sideeffect
    # of compiling all files accross all umbrella projects instead of
    # compiling one by one
    if Mix.Project.umbrella?(project) do
      for {_app, path} <- Mix.Project.apps_paths(project) do
        compile(version, sources: project[:caramel_paths], path: path)
      end
      :ok
    else
      :ok = compile(version, sources: project[:caramel_paths])
    end
  end

  defp compile(version, opts \\ []) do
    source_paths = opts[:source] || ["src"]

    if nil == source_paths do
      Mix.raise("Caramel configuration error: `caramel_paths` not set in mix.config")
    end

    if nil == version do
      Mix.raise("Caramel configuration error: `caramel_release` not set in mix.config")
    end


    Mix.Compilers.Erlang.assert_valid_erlc_paths(source_paths)

    if opts[:path] do
      len = byte_size(opts[:path])
      source_paths = for s <- source_paths, do: Path.join(opts[:path], s)
      files = Mix.Utils.extract_files(source_paths, [:ml, :mli, :re, :rei])

      if files != source_paths do
        files =
          for f <- files do
            <<_ :: binary-size(len), "/", file :: binary()>> = f
            file
          end

        if files != [] do
          :ok = Caramel.ensure_version(version)
        end

        Caramel.compile(files, cd: opts[:path])
      end
    else
      files = Mix.Utils.extract_files(source_paths, [:ml, :mli, :re, :rei])

      if files != [] do
        :ok = Caramel.ensure_version(version)
      end

      Caramel.compile(files)
    end


  end

  defp current_version() do
    case System.shell("command -v caramel > /dev/null && caramel version") do
      {"v" <> _ = buf, 0} -> List.last(String.split(buf))
      _ -> nil
    end
  end
end
