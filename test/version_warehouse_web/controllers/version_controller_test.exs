defmodule VersionWarehouseWeb.VersionControllerTest do
  use VersionWarehouseWeb.ConnCase

  alias VersionWarehouse.Versions

  @create_attrs %{
    admin_id: 42,
    created_at: "some created_at",
    event: "some event",
    ip: "some ip",
    item_id: 42,
    item_type: "some item_type",
    object: "some object",
    object_changes: "some object_changes",
    request_id: "some request_id",
    whodunnit: "some whodunnit"
  }
  @invalid_attrs %{
    admin_id: nil,
    created_at: nil,
    event: nil,
    ip: nil,
    item_id: nil,
    item_type: nil,
    object: nil,
    object_changes: nil,
    request_id: nil,
    whodunnit: nil
  }

  def fixture(:version) do
    {:ok, version} = Versions.create_version(@create_attrs)
    version
  end

  setup %{conn: conn} do
    {
      :ok,
      conn:
        conn
        |> put_req_header("accept", "application/json")
        |> put_req_header("token", "AB12345")
    }
  end

  describe "index" do
    test "lists all versions", %{conn: conn} do
      conn = get(conn, Routes.version_path(conn, :index, %{"item_type" => "User", "item_id" => 1}))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create version" do
    test "renders version when data is valid", %{conn: conn} do
      request = post(conn, Routes.version_path(conn, :create), version: @create_attrs)
      assert %{"id" => id} = json_response(request, 201)["data"]

      conn = get(conn, Routes.version_path(conn, :show, id))

      assert %{
               "id" => id,
               "admin_id" => 42,
               "created_at" => "some created_at",
               "event" => "some event",
               "ip" => "some ip",
               "item_id" => 42,
               "item_type" => "some item_type",
               "object" => "some object",
               "object_changes" => "some object_changes",
               "request_id" => "some request_id",
               "whodunnit" => "some whodunnit"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.version_path(conn, :create), version: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete version" do
    test "deletes chosen resource", %{conn: conn} do
      version = fixture(:version)
      conn = delete(conn, Routes.version_path(conn, :delete, version))
      assert response(conn, 204)
    end
  end
end
