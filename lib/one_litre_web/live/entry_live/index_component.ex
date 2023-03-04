defmodule OneLitreWeb.EntryLive.IndexComponent do
  use OneLitreWeb, :live_component

  alias OneLitre.Games
  alias OneLitre.Games.Entry

  @impl true
  def update(assigns, socket) do
    entries = Games.list_entries()
    {
      :ok,
      socket
      |> assign(assigns)
      |> assign(:entries, entries)
      |> IO.inspect
    }
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
