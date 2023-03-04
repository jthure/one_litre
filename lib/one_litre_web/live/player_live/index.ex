defmodule OneLitreWeb.PlayerLive.Index do
  use OneLitreWeb, :live_view

  alias OneLitre.Games
  alias OneLitre.Games.Player

  @impl true
  def mount(%{"game_id" => game_id}, _session, socket) do
    {
      :ok,
      socket
      |> assign(:players, list_players())
      |> assign(:game, Games.get_game!(game_id))
      |>IO.inspect()
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Player")
    |> assign(:player, Games.get_player!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Player")
    |> assign(:player, %Player{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Players")
    |> assign(:player, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    player = Games.get_player!(id)
    {:ok, _} = Games.delete_player(player)

    {:noreply, assign(socket, :players, list_players())}
  end

  defp list_players do
    Games.list_players()
  end
end
