# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :medium_api,
  ecto_repos: [MediumApi.Repo]

# Configures the endpoint
config :medium_api, MediumApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "791scFWSVpp51QtLnlZPNJgd5F/6ro+SGCN212v67VVQILOvtwbfme+zgrseVUKy",
  render_errors: [view: MediumApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: MediumApi.PubSub,
  live_view: [signing_salt: "V3I6/Ptm"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :medium_api, MediumApi.Guardian,
       issuer: "medium_api",
       secret_key: "HVCiv/BWKYzaozC1VYIKR8eZkWodAPuSiL/hbzjrwAxOk1ZFk6YykXHi+pUYdy1x"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
