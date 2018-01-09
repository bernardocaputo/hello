defmodule Hello.HelloController do
  use Hello.Web, :controller

  def world(conn, %{"email" => name}) do
    render conn, "world.html", name: name
  end

end
