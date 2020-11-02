defmodule VersionWarehouse.Versions do
  @moduledoc """
  The Versions context.
  """

  import Ecto.Query, warn: false
  alias VersionWarehouse.Repo

  alias VersionWarehouse.Versions.Version

  @doc """
  Returns the list of versions for item_type and item_id.

  ## Examples

      iex> list_versions("User", 1)
      [%Version{}, ...]

  """
  def list_versions(item_type, item_id) do
    Version
    |> where([v], v.item_type == ^item_type)
    |> where([v], v.item_id == ^item_id)
    |> order_by([v], [v.created_at, v.id])
    |> Repo.all
  end

  def purge_versions_by_ids(ids, max_id) do
    from(
      v in Version,
      where: v.id in ^ids,
      where: v.id < ^max_id
    )
    |> Repo.delete_all()
  end

  def get_first_id do
    Repo.one(from v in Version, select: min(v.id))
  end

  @doc """
  Gets a single version.

  Raises `Ecto.NoResultsError` if the Version does not exist.

  ## Examples

      iex> get_version!(123)
      %Version{}

      iex> get_version!(456)
      ** (Ecto.NoResultsError)

  """
  def get_version!(id), do: Repo.get!(Version, id)

  @doc """
  Creates a version.

  ## Examples

      iex> create_version(%{field: value})
      {:ok, %Version{}}

      iex> create_version(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_version(attrs \\ %{}) do
    %Version{}
    |> Version.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a version.

  ## Examples

      iex> update_version(version, %{field: new_value})
      {:ok, %Version{}}

      iex> update_version(version, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_version(%Version{} = version, attrs) do
    version
    |> Version.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a version.

  ## Examples

      iex> delete_version(version)
      {:ok, %Version{}}

      iex> delete_version(version)
      {:error, %Ecto.Changeset{}}

  """
  def delete_version(%Version{} = version) do
    Repo.delete(version)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking version changes.

  ## Examples

      iex> change_version(version)
      %Ecto.Changeset{data: %Version{}}

  """
  def change_version(%Version{} = version, attrs \\ %{}) do
    Version.changeset(version, attrs)
  end
end
