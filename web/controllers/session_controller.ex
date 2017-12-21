defmodule Hello.SessionController do
  use Hello.Web, :controller

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"name" => name, "password" => password}) do
    require IEx
    IEx.pry()
  end


end
