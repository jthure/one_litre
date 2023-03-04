defmodule OneLitreWeb.GameLive.Show do
  use OneLitreWeb, :live_view

  alias OneLitre.Games
  alias OneLitre.Games.Player

  @impl true
  def mount(%{"game_id" => id}, _session, socket) do
    {
      :ok,
      socket
      |> assign(:players, Games.list_players_by_game(id))
    }
  end

  @impl true
  def handle_params(%{"game_id" => id} = params, _, socket) do
    {
      :noreply,
      socket
      |> assign(:page_title, page_title(socket.assigns.live_action))
      |> assign(:game, Games.get_game!(id))
      |> apply_action(socket.assigns.live_action, params)
    }
  end

  @impl true
  def handle_event("delete-player", %{"id" => id}, socket) do
    player = Games.get_player!(id)
    {:ok, _} = Games.delete_player(player)

    {:noreply,
     socket
     |> assign(:players, Games.list_players())}
  end

  defp apply_action(socket, :edit_player, %{"player_id" => player_id}) do
    socket
    |> assign(:player, Games.get_player!(player_id))
  end

  defp apply_action(socket, :new_player, %{"game_id" => game_id}=params) do
    IO.inspect(params)

    socket
    |> assign(:player, %Player{game_id: game_id})
  end

  defp apply_action(socket, _action, _params) do
    # IO.inspect(_params)
    socket
  end

  defp page_title(:show), do: "Show Game"
  defp page_title(:edit), do: "Edit Game"
  defp page_title(:edit_player), do: "Edit Player"
  defp page_title(:new_player), do: "New Player"
end
