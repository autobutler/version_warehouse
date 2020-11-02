defmodule VersionWarehouse.Versions.PurgeWorker do
  @max_id 108_000_000
  @batch_size 1_000

  use Agent

  alias VersionWarehouse.Versions

  def start_link do
    Agent.start_link(run(1))
  end

  def run(start_id \\ 1) do
    ids = (start_id..(start_id + @batch_size)) |> Enum.to_list()
    Versions.purge_versions_by_ids(ids, @max_id)

    if start_id < @max_id do
      run(start_id + @batch_size)
    else
      :ok
    end
  end
end
