defmodule VersionWarehouse.Repo.Migrations.DropUnusedIndex do
  use Ecto.Migration
  @disable_ddl_transaction true
  @disable_migration_lock true

  def change do
    drop index(:versions, [:item_type, :event, :created_at], concurrently: true)
  end
end
