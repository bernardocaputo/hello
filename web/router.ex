defmodule Hello.Router do
  use Hello.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Hello.Auth, repo: Hello.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Hello do
    pipe_through :browser # Use the default browser stack

    get "/hello/:email", HelloController, :world
    get "/", PageController, :index
    resources "/users", UserController, only: [:index, :new, :create, :delete, :update, :edit]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Hello do
  #   pipe_through :api
  # end
end
