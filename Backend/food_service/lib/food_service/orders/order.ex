defmodule FoodService.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  alias FoodService.Orders

  @required [:user_id, :status]
  @optional []

  schema "orders" do
    many_to_many :inventories, Orders.Inventory, on_replace: :delete, join_through: Orders.OrderInventory
    belongs_to :user, FoodService.Accounts.User
    field :status, OrdersEnum, default: 0

    timestamps()
  end

  @doc false
  def changeset(%Orders.Order{} = order, attrs) do
    order
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
    |> assoc_constraint(:user)
    |> cast_assoc(:inventories)
  end
end
