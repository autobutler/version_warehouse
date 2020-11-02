defmodule VersionWarehouse.VersionsTest do
  use VersionWarehouse.DataCase

  alias VersionWarehouse.Versions

  describe "versions" do
    alias VersionWarehouse.Versions.Version

    @valid_attrs %{admin_id: 42, created_at: "some created_at", event: "some event", ip: "some ip", item_id: 42, item_type: "some item_type", object: "some object", object_changes: "some object_changes", request_id: "some request_id", whodunnit: "some whodunnit"}
    @update_attrs %{admin_id: 43, created_at: "some updated created_at", event: "some updated event", ip: "some updated ip", item_id: 43, item_type: "some updated item_type", object: "some updated object", object_changes: "some updated object_changes", request_id: "some updated request_id", whodunnit: "some updated whodunnit"}
    @invalid_attrs %{admin_id: nil, created_at: nil, event: nil, ip: nil, item_id: nil, item_type: nil, object: nil, object_changes: nil, request_id: nil, whodunnit: nil}

    def version_fixture(attrs \\ %{}) do
      {:ok, version} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Versions.create_version()

      version
    end

    test "list_versions/0 returns all versions" do
      version = version_fixture()
      assert Versions.list_versions("some item_type", 42) == [version]
    end

    test "get_version!/1 returns the version with given id" do
      version = version_fixture()
      assert Versions.get_version!(version.id) == version
    end

    test "create_version/1 with valid data creates a version" do
      assert {:ok, %Version{} = version} = Versions.create_version(@valid_attrs)
      assert version.admin_id == 42
      assert version.created_at == "some created_at"
      assert version.event == "some event"
      assert version.ip == "some ip"
      assert version.item_id == 42
      assert version.item_type == "some item_type"
      assert version.object == "some object"
      assert version.object_changes == "some object_changes"
      assert version.request_id == "some request_id"
      assert version.whodunnit == "some whodunnit"
    end

    test "create_version/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Versions.create_version(@invalid_attrs)
    end

    test "update_version/2 with valid data updates the version" do
      version = version_fixture()
      assert {:ok, %Version{} = version} = Versions.update_version(version, @update_attrs)
      assert version.admin_id == 43
      assert version.created_at == "some updated created_at"
      assert version.event == "some updated event"
      assert version.ip == "some updated ip"
      assert version.item_id == 43
      assert version.item_type == "some updated item_type"
      assert version.object == "some updated object"
      assert version.object_changes == "some updated object_changes"
      assert version.request_id == "some updated request_id"
      assert version.whodunnit == "some updated whodunnit"
    end

    test "update_version/2 with invalid data returns error changeset" do
      version = version_fixture()
      assert {:error, %Ecto.Changeset{}} = Versions.update_version(version, @invalid_attrs)
      assert version == Versions.get_version!(version.id)
    end

    test "delete_version/1 deletes the version" do
      version = version_fixture()
      assert {:ok, %Version{}} = Versions.delete_version(version)
      assert_raise Ecto.NoResultsError, fn -> Versions.get_version!(version.id) end
    end

    test "change_version/1 returns a version changeset" do
      version = version_fixture()
      assert %Ecto.Changeset{} = Versions.change_version(version)
    end
  end
end
