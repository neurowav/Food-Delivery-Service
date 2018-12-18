defmodule FoodService.Orders do
  import Ecto.Query, warn: false
  alias FoodService.Repo

  alias FoodService.Orders.{
    Inventory,
    Order,
    OrderInventory
  }

  def inventory_list do
    Inventory
    |> Repo.all()
    |> Repo.preload(:photo)
  end

  def order_list do
    Order
    |> Repo.all()
    |> Repo.preload([:user, :inventories])
  end

  def get_inventory(id), do: Inventory |> Repo.get(id) |> Repo.preload(:photo)

  def get_order(id), do: Order |> Repo.get(id) |> Repo.preload(inventories: :photo)

  def get_last_order do
    q = from p in Order,
        limit: 1,
        order_by: [desc: :inserted_at],
        preload: [inventories: :photo]
    Repo.one q
  end

  def delete_order_inv(order, inventory_id) do
     inventory_ids = order.inventories |> Enum.map(fn inv -> inv.id end)
     inventory_ids = inventory_ids -- [inventory_id]
     case upd_inventory_with_order(inventory_ids, order) do
       {_count, nil} -> {:ok, get_last_order()}
       error -> error
     end
  end

  def create_inventory(attrs \\ %{}) do
    %Inventory{}
    |> Inventory.changeset(attrs)
    |> Repo.insert()
  end

  def create_order(inventory_ids \\ []) do
    user = FoodService.Accounts.get_last_user

    with {:ok, order} <- %Order{}
                        |> Order.changeset(%{"user_id" => user.id})
                        |> Repo.insert()
                        |> Repo.preload(:inventories),
      {:ok, order_inventory} <- upd_inventory_with_order(inventory_ids, order) do
      order = get_order(order.id)
      {:ok, order}
    else
      error -> error
    end
  end

  def update_last_order(inventory_id) do
    order = get_last_order()
    inventory_ids = order.inventories |> Enum.map(fn inv -> inv.id end)
    if Enum.member?(inventory_ids, inventory_id) do
      {:ok, get_last_order()}
    else
      case %OrderInventory{}
          |> OrderInventory.changeset(%{inventory_id: inventory_id, order_id: order.id})
          |> Repo.insert() do
        {:ok, _inv} -> {:ok, get_last_order()}
        error -> error
      end
    end
  end

  def delete_from_last_order(inventory_id) do
    order = get_last_order()
    delete_order_inv(order, inventory_id)
  end

  def update_order(id, inventory_ids) do
    order = get_order(id)
     case upd_inventory_with_order(inventory_ids, order) do
       {_count, nil} -> order = get_order(id)
                       {:ok, order}
       error -> error
     end
  end

  defp upd_inventory_with_order(inventory_ids, order) do
    order_inventories = OrderInventory |> where(order_id: ^order.id) |> Repo.delete_all
    changeset = inventory_ids
                |> Enum.map(fn inventory_id ->
                    %{inventory_id: inventory_id, order_id: order.id}
                 end)
    Repo.insert_all(OrderInventory, changeset, on_conflict: :nothing)
  end
end
