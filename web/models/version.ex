defmodule VersionWarehouse.Version do
  use VersionWarehouse.Web, :model
  use Calecto.Model, usec: true

  schema "versions" do
    field :item_type, :string
    field :item_id, :integer
    field :event, :string
    field :whodunnit, :string
    field :object, :string
    field :ip, :string
    field :request_id, :string
    field :admin_id, :integer
    field :object_changes, :string
    field :created_at, :string

    timestamps
  end

  @required_fields ~w(item_type item_id event)
  @optional_fields ~w(whodunnit object ip request_id admin_id object_changes created_at)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
