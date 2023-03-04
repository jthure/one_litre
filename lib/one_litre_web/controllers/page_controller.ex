defmodule OneLitreWeb.PageController do
  use OneLitreWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def login(conn, %{"player_id" => player_id, "return_to" => return_to}) do
    conn
    |> put_session(:user, player_id)
    |> redirect(to: return_to)
  end
end
