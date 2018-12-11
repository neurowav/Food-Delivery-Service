defmodule FoodService.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :status, :integer, null: false, default: 0
      add :inventory_id, :integer
      timestamps()
    end

    create index(:orders, [:inventory_id])
  end
end
