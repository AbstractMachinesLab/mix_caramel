defmodule Mix.Tasks.Compile.Caramel do
  @moduledoc """
  This module is responsible for compiling caramel code

  It looks for code in the src/ directory and then will compile all the code
  and move it to the gen/src/ directory so it is available in your mix project.
  """

  use Mix.Task.Compiler

  def run(_args) do
    compiler = find_compiler()
    case Mix.shell().cmd(compiler <> " compile *.ml", [cd: "src/"]) do
      0 ->
        move_erl_files()
        delete_artifacts()
        {:ok, []}

      status ->
        exit(status)
    end
  end

  defp move_erl_files() do
    File.mkdir_p!(Path.dirname("gen/src/"))

    "src/*.erl"
    |> Path.wildcard()
    |> Enum.each(fn generated_file ->
      File.rename!(generated_file, "gen/src/#{Path.basename(generated_file)}")
    end)
  end

  defp delete_artifacts() do
    "src/*.cmo"
    |> Path.wildcard()
    |> Enum.each(fn generated_file ->
      File.rm!(generated_file)
    end)
  end

  defp find_compiler() do
    case System.find_executable("caramelc") do
      false ->
        raise CompileError, "no version of caramel compiler installed"

      exec ->
        exec
    end
  end
end
