defmodule OneLitre.GamesTest do
  use OneLitre.DataCase

  alias OneLitre.Games

  describe "game" do
    alias OneLitre.Games.Game

    import OneLitre.GamesFixtures

    @invalid_attrs %{code: nil}

    test "list_game/0 returns all game" do
      game = game_fixture()
      assert Games.list_game() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Games.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      valid_attrs = %{code: "some code"}

      assert {:ok, %Game{} = game} = Games.create_game(valid_attrs)
      assert game.code == "some code"
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      update_attrs = %{code: "some updated code"}

      assert {:ok, %Game{} = game} = Games.update_game(game, update_attrs)
      assert game.code == "some updated code"
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_game(game, @invalid_attrs)
      assert game == Games.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Games.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Games.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Games.change_game(game)
    end
  end

  describe "players" do
    alias OneLitre.Games.Player

    import OneLitre.GamesFixtures

    @invalid_attrs %{name: nil}

    test "list_players/0 returns all players" do
      player = player_fixture()
      assert Games.list_players() == [player]
    end

    test "get_player!/1 returns the player with given id" do
      player = player_fixture()
      assert Games.get_player!(player.id) == player
    end

    test "create_player/1 with valid data creates a player" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Player{} = player} = Games.create_player(valid_attrs)
      assert player.name == "some name"
    end

    test "create_player/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_player(@invalid_attrs)
    end

    test "update_player/2 with valid data updates the player" do
      player = player_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Player{} = player} = Games.update_player(player, update_attrs)
      assert player.name == "some updated name"
    end

    test "update_player/2 with invalid data returns error changeset" do
      player = player_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_player(player, @invalid_attrs)
      assert player == Games.get_player!(player.id)
    end

    test "delete_player/1 deletes the player" do
      player = player_fixture()
      assert {:ok, %Player{}} = Games.delete_player(player)
      assert_raise Ecto.NoResultsError, fn -> Games.get_player!(player.id) end
    end

    test "change_player/1 returns a player changeset" do
      player = player_fixture()
      assert %Ecto.Changeset{} = Games.change_player(player)
    end
  end

  describe "entries" do
    alias OneLitre.Games.Entry

    import OneLitre.GamesFixtures

    @invalid_attrs %{amount: nil}

    test "list_entries/0 returns all entries" do
      entry = entry_fixture()
      assert Games.list_entries() == [entry]
    end

    test "get_entry!/1 returns the entry with given id" do
      entry = entry_fixture()
      assert Games.get_entry!(entry.id) == entry
    end

    test "create_entry/1 with valid data creates a entry" do
      valid_attrs = %{amount: 42}

      assert {:ok, %Entry{} = entry} = Games.create_entry(valid_attrs)
      assert entry.amount == 42
    end

    test "create_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_entry(@invalid_attrs)
    end

    test "update_entry/2 with valid data updates the entry" do
      entry = entry_fixture()
      update_attrs = %{amount: 43}

      assert {:ok, %Entry{} = entry} = Games.update_entry(entry, update_attrs)
      assert entry.amount == 43
    end

    test "update_entry/2 with invalid data returns error changeset" do
      entry = entry_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_entry(entry, @invalid_attrs)
      assert entry == Games.get_entry!(entry.id)
    end

    test "delete_entry/1 deletes the entry" do
      entry = entry_fixture()
      assert {:ok, %Entry{}} = Games.delete_entry(entry)
      assert_raise Ecto.NoResultsError, fn -> Games.get_entry!(entry.id) end
    end

    test "change_entry/1 returns a entry changeset" do
      entry = entry_fixture()
      assert %Ecto.Changeset{} = Games.change_entry(entry)
    end
  end
end
