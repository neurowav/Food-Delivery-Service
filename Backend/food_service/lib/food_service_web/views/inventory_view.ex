defmodule FoodServiceWeb.InventoryView do
  use FoodServiceWeb, :view
  alias FoodServiceWeb.{InventoryView, PhotoView}

  def render("index.json", %{inventories: inventories}) do
    %{
      data: render_many(inventories, InventoryView, "inventory.json")
    }
  end

  def render("inventory.json", %{inventory: inventory}) do
    %{
      id: inventory.id,
      name: inventory.name,
      amount: inventory.amount,
      description: inventory.description,
      photo: render_one(inventory.photo, PhotoView, "photo.json")
    }
  end
end
