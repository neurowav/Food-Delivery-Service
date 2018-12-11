defmodule FoodServiceWeb.InventoryController do
  use FoodServiceWeb, :controller

  alias FoodService.Orders

  def index(conn, _) do
    inventories = Orders.inventory_list()

    render(conn, "index.json", %{inventories: inventories})
  end
end
