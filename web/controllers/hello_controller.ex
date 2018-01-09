defmodule Hello.HelloController do
  use Hello.Web, :controller

  def world(conn, %{"email" => email}) do
    render conn, "world.html", email: email
  end

end
