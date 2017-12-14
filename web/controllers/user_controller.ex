defmodule Hello.UserController do
  use Hello.Web, :controller
  alias Hello.Repo
  alias Hello.User

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => params}) do
    changeset = User.registration_changeset(%User{}, params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: user_path(conn, :index))
      {:error, _} ->
        conn
        |> put_flash(:info, "problemas na criação!")
        |> redirect(to: user_path(conn, :new))
    end
  end

  def index(conn, _params) do
    users = Repo.all(User)
    render conn, "index.html", users: users

  end

end
