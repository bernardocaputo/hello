defmodule Hello.UserController do
  use Hello.Web, :controller
  plug :authenticate when action in [:index]
  alias Hello.Repo
  alias Hello.User

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def edit(conn, %{"id" => user_id}) do
    user = Repo.get!(User, user_id)
    changeset = User.changeset(user)
    render conn, "edit.html", changeset: changeset, user: user
  end

  def update(conn, %{"usser" => user_params, "id" => user_id}) do
    require IEx
    IEx.pry()
    user = Repo.get!(User, user_id)
    changeset = User.changeset(user, user_params)
    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "#{user.name} edited!")
        |> redirect(to: user_path(conn, :index))
      {:error, _} ->
        conn
        |> put_flash(:error, "problemas na edição!")
        |> redirect(to: user_path(conn, :new))
    end
  end

  def create(conn, %{"user" => params}) do
    changeset = User.registration_changeset(%User{}, params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> Hello.Auth.login(user)
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: user_path(conn, :index))
      {:error, _} ->
        conn
        |> put_flash(:error, "problemas na criação!")
        |> redirect(to: user_path(conn, :new))
    end
  end

  def index(conn, _params) do
    users = Repo.all(User)
    render conn, "index.html", users: users
  end

  defp authenticate(conn, _params) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in")
      |> redirect(to: page_path(conn, :index))
      |> halt()
    end
  end
end
