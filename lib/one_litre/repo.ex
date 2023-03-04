defmodule OneLitre.Repo do
  use Ecto.Repo,
    otp_app: :one_litre,
    adapter: Ecto.Adapters.Postgres
end
