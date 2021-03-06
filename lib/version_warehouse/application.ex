defmodule VersionWarehouse.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      VersionWarehouse.Repo,
      # Start the Telemetry supervisor
      VersionWarehouseWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: VersionWarehouse.PubSub},
      # Start the Endpoint (http/https)
      VersionWarehouseWeb.Endpoint,
      # Start a worker by calling: VersionWarehouse.Worker.start_link(arg)
      # {VersionWarehouse.Worker, arg}
      # {VersionWarehouse.Versions.PurgeWorker, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: VersionWarehouse.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    VersionWarehouseWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
