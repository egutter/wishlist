defmodule WishlistWeb.Router do
  use WishlistWeb, :router
  import Plug.BasicAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {WishlistWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admin do
    plug :basic_auth, Application.compile_env(:wishlist, :basic_auth)
  end

  scope "/admin", WishlistWeb do
    pipe_through [:browser, :admin]

    get "/", AdminController, :index

    live "/events", EventLive.Index, :index
    live "/events/new", EventLive.Index, :new
    live "/events/:id/edit", EventLive.Index, :edit

    live "/events/:id", EventLive.Show, :show
    live "/events/:id/show/edit", EventLive.Show, :edit

    live "/gifts", GiftLive.Index, :index
    live "/gifts/new", GiftLive.Index, :new
    live "/gifts/:id/edit", GiftLive.Index, :edit

    live "/gifts/:id", GiftLive.Show, :show
    live "/gifts/:id/show/edit", GiftLive.Show, :edit
  end

  scope "/", WishlistWeb do
    pipe_through :browser

    live "/", AssignmentLive.Index, :index
    live "/assignments/new", AssignmentLive.Index, :new
    live "/assignments/:id/edit", AssignmentLive.Index, :edit
    live "/assignments/:id", AssignmentLive.Show, :show
    live "/assignments/:id/show/edit", AssignmentLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", WishlistWeb do
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
      live_dashboard "/dashboard", metrics: WishlistWeb.Telemetry
    end
  end
end
