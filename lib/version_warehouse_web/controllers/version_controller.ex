defmodule VersionWarehouseWeb.VersionController do
  use VersionWarehouseWeb, :controller

  alias VersionWarehouse.Versions
  alias VersionWarehouse.Versions.Version

  action_fallback VersionWarehouseWeb.FallbackController

  def index(conn, %{"item_type" => item_type, "item_id" => item_id}) do
    versions = Versions.list_versions(item_type, item_id)
    render(conn, "index.json", versions: versions)
  end

  def create(conn, %{"version" => version_params}) do
    with {:ok, %Version{} = version} <- Versions.create_version(version_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.version_path(conn, :show, version))
      |> render("show.json", version: version)
    end
  end

  def show(conn, %{"id" => id}) do
    version = Versions.get_version!(id)
    render(conn, "show.json", version: version)
  end

  def delete(conn, %{"id" => id}) do
    version = Versions.get_version!(id)

    with {:ok, %Version{}} <- Versions.delete_version(version) do
      send_resp(conn, :no_content, "")
    end
  end
end
