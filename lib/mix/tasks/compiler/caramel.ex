defmodule Mix.Tasks.Compile.Caramel do
  use Mix.Task.Compiler



  def check_if_already_unpacked() do
    false
  end

  def get_host_triplet() do
    case :os.type() do
      {:unix, :linux } -> "x86_64-unknown-linux-gnu"
      {:unix, _ } -> "x86_64-apple-darwin"
    end
  end

  def release_url(version, tarball_name) do
    "https://github.com/AbstractMachinesLab/caramel/releases/download/" <> version <> "/" <> tarball_name
  end

  def tarball_name(version, host_triplet) do
    "caramel-" <> version <> "-" <> host_triplet <> ".tar.gz"
  end
  
  def unpack(caramel_tarball) do
    Mix.Shell.cmd("tar -xzf " <> caramel_tarball, [], (fn _ -> :ok  end))
  end

  def remove_tarball(caramel_tarball) do
    Mix.Shell.cmd("rm " <> caramel_tarball, [], (fn _ -> :ok  end))
  end
  
  def download_caramel(release_url) do
    Mix.Shell.cmd("wget " <> release_url, [], (fn _ -> :ok  end))
  end
  
  def ensure_caramel_exists(version) do
    if check_if_already_unpacked() do
      :ok
    else
      host_triplet = get_host_triplet()
      tarball_name = tarball_name(version, host_triplet)
      release_url = release_url(version, tarball_name)
      download_caramel(release_url)
      unpack(tarball_name)
      remove_tarball(tarball_name)
      :ok
    end
  end

  
  def run(_) do
    project = Mix.Project.config()
    source_paths = project[:caramel_paths]
    version = project[:caramel_release]
    ensure_caramel_exists(version)
    Mix.Compilers.Erlang.assert_valid_erlc_paths(source_paths)
    files = Mix.Utils.extract_files(source_paths, [:ml, :mli])
    run_caramel(files)
    :ok
  end

  def run_caramel(files) do
    Mix.Shell.cmd(
      "caramel/bin/caramel compile " <> Enum.join(files, " "),
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
