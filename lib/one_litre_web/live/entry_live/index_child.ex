defmodule OneLitreWeb.EntryLive.IndexChild do
  use OneLitreWeb, :live_view

  alias OneLitre.Games
  alias OneLitre.Games.Entry

  @impl true
  def mount(params, _session, socket) do
    IO.inspect params
    IO.inspect socket
    IO.inspect _session
    {
      :ok,
      socket
      |>assign(:entries, list_entries())
      |>assign(:entries, list_entries())
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
