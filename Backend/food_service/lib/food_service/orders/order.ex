defmodule FoodService.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  alias FoodService.Orders

  @required [:inventory_id, :user_id, :status]
  @optional []

  schema "orders" do
    belongs_to :inventory, Orders.Inventory
    belongs_to :user, FoodService.Accounts.User
    field :status, OrdersEnum, default: 0

    timestamps()
  end

  @doc false
  def changeset(%Orders.Order{} = order, attrs) do
    order
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
    |> assoc_constraint(:inventory)
    |> assoc_constraint(:user)
  end
end
