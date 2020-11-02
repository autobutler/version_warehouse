# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :version_warehouse,
  ecto_repos: [VersionWarehouse.Repo]

# Configures the endpoint
config :version_warehouse, VersionWarehouseWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "jJmE7jo82enbp3k2lilWouxe7FOE2Id4534LT0JTYLehI4+VET5SS11lIlR4z2ql",
  render_errors: [view: VersionWarehouseWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: VersionWarehouse.PubSub,
  live_view: [signing_salt: "MDcj5d7Q"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :version_warehouse, :auth,
  auth_token: System.get_env("AUTH_TOKEN") || "AB12345"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
