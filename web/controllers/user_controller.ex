defmodule Hello.UserController do
  use Hello.Web, :controller
  alias Hello.Repo
  alias Hello.User

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => params}) do
    changeset = User.changeset(%User{}, params)
    |> Repo.insert()
    users = Repo.all(User)
    redirect conn, to: "/users"
  end

  def index(conn, _params) do
    users = Repo.all(User)
    render conn, "index.html", users: users

  end

end
