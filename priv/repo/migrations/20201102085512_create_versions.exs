defmodule VersionWarehouse.Repo.Migrations.CreateVersions do
  use Ecto.Migration

  def change do
    if Mix.env() == :dev || Mix.env() == :test do
      create table(:versions) do
        add :item_type, :string
        add :item_id, :integer
        add :event, :string
        add :whodunnit, :string
        add :object, :string
        add :ip, :string
        add :request_id, :string
        add :admin_id, :integer
        add :object_changes, :string
        add :created_at, :string

        timestamps()
      end

      create index(:versions, [:item_type, :item_id])
      create index(:versions, [:item_type, :event, :created_at])
    end
  end
end
