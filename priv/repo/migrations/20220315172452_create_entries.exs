defmodule OneLitre.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :amount, :integer
      add :player_id, references(:players, on_delete: :nothing)

      timestamps()
    end

    create index(:entries, [:player_id])
  end
end
