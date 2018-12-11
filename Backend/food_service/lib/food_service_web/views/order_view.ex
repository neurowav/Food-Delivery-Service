defmodule FoodServiceWeb.OrderView do
  use FoodServiceWeb, :view
  alias FoodServiceWeb.OrderView

  def render("index.json", %{orders: orders}) do
    %{
      data: render_many(orders, OrderView, "order.json")
    }
  end

  def render("order.json", %{order: order}) do
    %{
      id: order.id,
      user_id: order.user_id,
      inventory_id: order.inventory_id,
      status: order.status
    }
  end
end
