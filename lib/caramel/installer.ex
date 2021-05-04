defmodule Caramel.Installer do
  def get_host_triplet() do
    case :os.type() do
      {:unix, :linux} -> "x86_64-unknown-linux-gnu"
      {:unix, _} -> "x86_64-apple-darwin"
    end
  end

  def release_url(version, tarball_name) do
    "https://github.com/AbstractMachinesLab/caramel/releases/download/" <>
      version <> "/" <> tarball_name
  end

  def tarball_name(version, host_triplet) do
    "caramel-" <> version <> "-" <> host_triplet <> ".tar.gz"
  end

  def download_caramel(version, tarball_name, release_url) do
    IO.puts("📦 Installing Caramel #{version}...")
    Mix.Shell.cmd("wget " <> release_url, [], fn _ -> :ok end)
    Mix.Shell.cmd("tar -xzf " <> tarball_name, [], fn _ -> :ok end)
    Mix.Shell.cmd("rm " <> tarball_name, [], fn _ -> :ok end)
    Mix.Shell.cmd("mv caramel _build/", [], fn _ -> :ok end)
  end

  defp verify_prereqs(prereqs) do
    Enum.each(prereqs, fn prereq ->
      if Mix.Shell.Quiet.cmd("which " <> prereq) != 0 do
        Mix.raise(prereq <> " is requred to install caramel.")
      end
    end)
  end

  def install(version) do
    host_triplet = get_host_triplet()
    tarball_name = tarball_name(version, host_triplet)
    release_url = release_url(version, tarball_name)
    verify_prereqs(["wget", "tar"])
    download_caramel(version, tarball_name, release_url)
  end
end
