defmodule Hello.Auth do
  import Plug.Conn
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  def login_by_name_and_pass(conn, name_given, password_given, opts) do
    repo = Keyword.fetch!(opts, :repo)
    user = repo.get_by(Hello.User, name: name_given)
    cond do
      user && checkpw(password_given, user.password_hash) ->
        {:ok, login(conn, user)}
      user ->
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw()
        {:error, :not_found, conn}
    end
  end

  def init(opts) do #opts é o argumento seguido do plug Hello.Auth no router.ex (repo: Hello.Repo)
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    user_id = get_session(conn, :user_id)
    user = user_id && repo.get(Hello.User, user_id)
    assign(conn, :current_user, user)
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id) #adiciona user_id: user.id na conn em plug_session
    |> configure_session(renew: true)
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end
end
