defmodule FoodService.Orders.Inventory do
  use Ecto.Schema
  import Ecto.Changeset

  alias FoodService.Orders.Inventory

  @required [:name, :amount]
  @optional [:description]

  schema "inventories" do
    has_one :photo, FoodService.Files.Photo, foreign_key: :owner_id
    field :name, :string
    field :amount, :float
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(%Inventory{} = inventory, attrs) do
    inventory
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
    |> cast_assoc(:photo)
  end
end
