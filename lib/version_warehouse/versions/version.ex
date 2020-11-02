defmodule VersionWarehouse.Versions.Version do
  use Ecto.Schema
  import Ecto.Changeset

  schema "versions" do
    field :admin_id, :integer
    field :created_at, :string
    field :event, :string
    field :ip, :string
    field :item_id, :integer
    field :item_type, :string
    field :object, :string
    field :object_changes, :string
    field :request_id, :string
    field :whodunnit, :string

    timestamps()
  end

  @doc false
  def changeset(version, attrs) do
    version
    |> cast(attrs, [:item_type, :item_id, :event, :whodunnit, :object, :ip, :request_id, :admin_id, :object_changes, :created_at])
    |> validate_required([:item_type, :item_id, :event])
  end
end
