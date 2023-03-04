defmodule OneLitre.GamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `OneLitre.Games` context.
  """

  @doc """
  Generate a game.
  """
  def game_fixture(attrs \\ %{}) do
    {:ok, game} =
      attrs
      |> Enum.into(%{
        code: "some code"
      })
      |> OneLitre.Games.create_game()

    game
  end

  @doc """
  Generate a player.
  """
  def player_fixture(attrs \\ %{}) do
    {:ok, player} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> OneLitre.Games.create_player()

    player
  end

  @doc """
  Generate a entry.
  """
  def entry_fixture(attrs \\ %{}) do
    {:ok, entry} =
      attrs
      |> Enum.into(%{
        amount: 42
      })
      |> OneLitre.Games.create_entry()

    entry
  end
end
