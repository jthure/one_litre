defmodule OneLitreWeb.Router do
  use OneLitreWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {OneLitreWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", OneLitreWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/login", PageController, :login

    live "/games", GameLive.Index, :index
    live "/games/new", GameLive.Index, :new
    live "/games/:game_id/edit", GameLive.Index, :edit

    live "/games/:game_id", GameLive.Show, :show
    live "/games/:game_id/show/edit", GameLive.Show, :edit

    live "/games/:game_id/players", PlayerLive.Index, :index
    live "/games/:game_id/players/new", GameLive.Show, :new_player
    live "/games/:game_id/players/:player_id/edit", GameLive.Show, :edit_player

    live "/games/:game_id/players/:player_id", PlayerLive.Show, :show
    live "/games/:game_id/players/:player_id/show/edit", PlayerLive.Show, :edit

    live "/games/:game_id/players/:player_id/entries", EntryLive.Index, :index
    live "/games/:game_id/players/:player_id/entries/new", EntryLive.Index, :new
    live "/games/:game_id/players/:player_id/entries/:entry_id/edit", EntryLive.Index, :edit

    live "/games/:game_id/players/:player_id/entries/:entry_id", EntryLive.Show, :show
    live "/games/:game_id/players/:player_id/entries/:entry_id/show/edit", EntryLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", OneLitreWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: OneLitreWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
