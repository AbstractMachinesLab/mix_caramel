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

  def compile(files, opts \\ [])
  def compile([], _opts), do: :ok
  def compile(files, opts) do
    bin = Path.expand(@caramel_bin)
    Mix.Shell.cmd(
      "#{bin} compile " <> Enum.join(files, " "),
      opts,
      fn res -> IO.puts(res) end
    )

    target_dir = Path.join(opts[:cd] || ".", "src")

    if not File.dir?(target_dir) do
      Mix.raise "caramel: target dir `#{target_dir}` is not a diretory"
    end


    # move the given files to target directory
    basedir = Path.dirname(target_dir)
    erlfiles =
      for file <- files do
        Path.join(basedir, Path.basename(file, Path.extname(file)) <> ".erl")
      end

    Mix.Shell.cmd(
      "mv #{Enum.join(erlfiles, " ")} #{target_dir}",
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
