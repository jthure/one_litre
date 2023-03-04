defmodule OneLitre.Games.Entry do
  use Ecto.Schema
  import Ecto.Changeset
  alias OneLitre.Games.Player

  schema "entries" do
    field :amount, :integer
    belongs_to :player, Player

    timestamps()
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [:amount])
    |> validate_required([:amount])
  end
end
