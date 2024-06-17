defmodule Blake3.Native do
  @moduledoc """
  Blake3.Native is the rustler module that will be replaced with the nif rust functions.
  This module doesn't need to be called direcly.
  """
  config = Mix.Project.config()
  version = config[:version]

  force_build = Application.compile_env(:rustler_precompiled, :force_build, [])
  source_url = Application.compile_env(:blake3, :source_url, config[:source_url])

  use RustlerPrecompiled,
    otp_app: :blake3,
    crate: "blake3",
    base_url: "#{source_url}/releases/download/v#{version}",
    force_build: System.get_env("BLAKE3_BUILD") in ["1", "true"] or force_build[:blake3],
    nif_versions: ["2.15"],
    targets: [
      "aarch64-apple-darwin",
      "aarch64-unknown-linux-gnu",
      "aarch64-unknown-linux-musl",
      "arm-unknown-linux-gnueabihf",
      "x86_64-apple-darwin",
      "x86_64-pc-windows-gnu",
      "x86_64-pc-windows-msvc",
      "x86_64-unknown-linux-gnu",
      "x86_64-unknown-linux-musl"
    ],
    version: version

  def hash(_str), do: error()
  def new(), do: error()
  def update(_state, _str), do: error()
  def update_rayon(_state, _str), do: error()
  def finalize(_state), do: error()
  def derive_key(_context, _key), do: error()
  def keyed_hash(_key, _str), do: error()
  def new_keyed(_key), do: error()
  def reset(_state), do: error()

  defp error, do: :erlang.nif_error(:nif_not_loaded)
end
