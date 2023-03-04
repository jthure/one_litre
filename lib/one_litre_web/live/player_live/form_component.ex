defmodule OneLitreWeb.PlayerLive.FormComponent do
  use OneLitreWeb, :live_component

  alias OneLitre.Games

  @impl true
  def update(%{player: player} = assigns, socket) do
    changeset = Games.change_player(player)
    IO.inspect(player)
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"player" => player_params}, socket) do
    changeset =
      socket.assigns.player
      |> Games.change_player(player_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"player" => player_params}, socket) do
    save_player(socket, socket.assigns.action, player_params)
  end

  defp save_player(socket, :edit_player, player_params) do
    IO.inspect(player_params)
    case Games.update_player(socket.assigns.player, player_params) do
      {:ok, _player} ->
        {:noreply,
         socket
         |> put_flash(:info, "Player updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_player(socket, :new_player, player_params) do
    IO.inspect(player_params)

    case Games.create_player(player_params) do
      {:ok, player} ->
        IO.inspect(player)
        {:noreply,
         socket
         |> put_flash(:info, "Player created successfully")
         |> redirect(to:  Routes.page_path(socket, :login, return_to: socket.assigns.return_to, player_id: player.id, game_id: player.game_id))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
