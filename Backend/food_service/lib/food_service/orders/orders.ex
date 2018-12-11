defmodule FoodService.Orders do
  import Ecto.Query, warn: false
  alias FoodService.Repo

  alias FoodService.Orders.{
    Inventory,
    Order
  }

  def inventory_list do
    Inventory
    |> Repo.all()
    |> Repo.preload(:photo)
  end

  def order_list do
    Order
    |> Repo.all()
    |> Repo.preload([:user, :inventory])
  end

  def get_inventory(id), do: Inventory |> Repo.get(id) |> Repo.preload(:photo)

  def get_order(id), do: Order |> Repo.get(id) |> Repo.preload([:user, :inventory])

  def create_inventory(attrs \\ %{}) do
    %Inventory{}
    |> Inventory.changeset(attrs)
    |> Repo.insert()
  end

  def create_order(attrs \\ %{}) do
    %Order{}
    |> Order.changeset(attrs)
    |> Repo.insert()
  end

  def update_order(id, attrs) do
    order = get_order(id)

    with {:ok, order} <- order |> Order.changeset(attrs) |> Repo.update() do
      order = Repo.preload(order, [:user, :inventory])

      {:ok, order}
    else
      error -> error
    end
  end
end
