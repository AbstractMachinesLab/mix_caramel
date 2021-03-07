defmodule Caramel do
  require Logger

  @root "_build/caramel"
  @caramel_bin "#{@root}/bin/caramel"

  def ensure_version(version) do
    if !File.exists?(@caramel_bin) do
      Caramel.Installer.install(version)
    end

    IO.puts("🍬 Using Caramel #{version}")
  end

  def compile([]), do: :ok
  def compile(files) do
    Mix.Shell.cmd(
      "#{@caramel_bin} compile " <> Enum.join(files, " "),
      [],
      fn res -> IO.puts(res) end
    )

    Mix.Shell.cmd(
      "mv *.erl src",
      [],
      fn _ -> :ok end
    )

    :ok
  end

  def format(files) do
    Mix.Shell.cmd(
      "#{@caramel_bin} fmt " <> Enum.join(files, " "),
      [],
      fn res -> IO.puts(res) end
    )

    :ok
  end
end
