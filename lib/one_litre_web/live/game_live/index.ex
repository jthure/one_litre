defmodule OneLitreWeb.GameLive.Index do
  use OneLitreWeb, :live_view

  alias OneLitre.Games
  alias OneLitre.Games.Game

  @impl true
  def mount(_params, _session, socket) do
    IO.inspect("Seeeesion")
    IO.inspect(_session)
    {:ok, assign(socket, :game_collection, list_game())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"game_id" => id}) do
    socket
    |> assign(:page_title, "Edit Game")
    |> assign(:game, Games.get_game!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Game")
    |> assign(:game, %Game{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Game")
    |> assign(:game, nil)
  end

  @impl true
  def handle_event("delete", %{"game_id" => id}, socket) do
    game = Games.get_game!(id)
    {:ok, _} = Games.delete_game(game)

    {:noreply, assign(socket, :game_collection, list_game())}
  end

  defp list_game do
    Games.list_game()
  end
end
