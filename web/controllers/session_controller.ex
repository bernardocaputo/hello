defmodule Hello.SessionController do
  use Hello.Web, :controller
  alias Hello.Repo
  alias Hello.User

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"name" => name, "password" => password}}) do
    case Hello.Auth.login_by_name_and_pass(conn, name, password, repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome to our app!")
        |> redirect(to: user_path(conn, :index))
      {:error, conn} ->
        conn
        |> put_flash(:error, "Invalid name/password combination")
        |> redirect(to: session_path(conn, :new))
    end

  end

  def delete(conn, _) do
    conn
    |> Hello.Auth.logout()
    |> redirect(to: page_path(conn, :index))
  end

end
