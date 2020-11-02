defmodule VersionWarehouse.Repo do
  use Ecto.Repo,
    otp_app: :version_warehouse,
    adapter: Ecto.Adapters.Postgres
end
