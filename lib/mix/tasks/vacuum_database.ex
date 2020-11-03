defmodule Mix.Tasks.VacuumDatabase do
  use Mix.Task

  alias VersionWarehouse.Repo

  def run(_) do
    Mix.Task.run("app.start", [])

    query = """
    VACUUM FULL
    """

    Ecto.Adapters.SQL.query!(Repo, query, [])
  end
end
