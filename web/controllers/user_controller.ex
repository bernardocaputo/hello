defmodule Hello.UserController do
  use Hello.Web, :controller
  # plug :authenticate when action in [:index]
  alias Hello.Repo
  alias Hello.User

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def edit(conn, %{"id" => user_id}) do
    edituser = Repo.get!(User, user_id)
    changeset = User.changeset(%User{})
    render conn, "edit.html", changeset: changeset, edituser: edituser
  end

  def update(conn, %{"user" => user_params}, user_id) do
    user = Repo.get!(User, user_id)
    case Repo.update(user, user_params) do
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
