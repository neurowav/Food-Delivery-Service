defmodule FoodServiceWeb.PageController do
  use FoodServiceWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
