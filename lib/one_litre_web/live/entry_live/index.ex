defmodule OneLitreWeb.EntryLive.Index do
  use OneLitreWeb, :live_view

  alias OneLitre.Games
  alias OneLitre.Games.Entry

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :entries, list_entries())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Entry")
    |> assign(:entry, Games.get_entry!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Entry")
    |> assign(:entry, %Entry{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Entries")
    |> assign(:entry, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    entry = Games.get_entry!(id)
    {:ok, _} = Games.delete_entry(entry)

    {:noreply, assign(socket, :entries, list_entries())}
  end

  defp list_entries do
    Games.list_entries()
  end
end
