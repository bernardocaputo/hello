defmodule Hello.UserController do
  use Hello.Web, :controller
  alias Hello.Repo
  alias Hello.User
  
  def index(conn, _params) do
    users = Repo.all(User)
    render conn, "index.html", users: users

  end

end
