import Config

config :blake3, source_url: "https://github.com/royal-markets/blake3"

config :blake3, Blake3.Native,
  mode: :release,
  features: MixBlake3.Project.config_features()

import_config("#{Mix.env()}.exs")
