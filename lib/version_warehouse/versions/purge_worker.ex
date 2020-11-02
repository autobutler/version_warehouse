defmodule VersionWarehouse.Versions.PurgeWorker do
  @max_id 108_000_000
  @batch_size 1_000

  use Agent

  alias VersionWarehouse.Versions

  def start_link(_) do
    if Mix.env() == :prod do
      Agent.start_link(&run/0, [])
    else
      Agent.start_link(fn -> :ok end, [])
    end
  end

  def run(start_id \\ 1) do
    # start_id =
    #   if start_id == 1 do
    #     VersionWarehouse.Versions.get_first_id || 1
    #   else
    #     start_id
    #   end

    ids = (start_id..(start_id + @batch_size)) |> Enum.to_list()
    Versions.purge_versions_by_ids(ids, @max_id)

    if start_id < @max_id do
      run(start_id + @batch_size)
    else
      :ok
    end
  end
end
