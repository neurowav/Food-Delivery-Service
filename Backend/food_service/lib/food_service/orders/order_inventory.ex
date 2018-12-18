defmodule FoodService.Orders.OrderInventory do
  use Ecto.Schema
  alias FoodService.Orders

  @primary_key false
  schema "inventories_orders" do
    belongs_to :inventory, Orders.Inventory
    belongs_to :order, Orders.Order
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> Ecto.Changeset.cast(params, [:inventory_id, :order_id])
    |> Ecto.Changeset.validate_required([:inventory_id, :order_id])
  end
end