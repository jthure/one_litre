defmodule OneLitreWeb.PlayerLive.Show do
  use OneLitreWeb, :live_view

  alias OneLitre.Games

  @impl true
  def mount(%{"game_id" => game_id}, _session, socket) do
    {:ok, socket |> assign(:game, Games.get_game!(game_id))}
  end

  @impl true
  def handle_params(%{"player_id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:player, Games.get_player!(id))}
  end

  defp page_title(:show), do: "Show Player"
  defp page_title(:edit), do: "Edit Player"
end
