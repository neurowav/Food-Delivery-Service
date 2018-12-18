defmodule FoodServiceWeb.PageView do
  use FoodServiceWeb, :view

  def render("index.json", _) do
    %{
        status: :ok
    }
  end
end
