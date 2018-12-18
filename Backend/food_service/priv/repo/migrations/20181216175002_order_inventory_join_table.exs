defmodule FoodService.Repo.Migrations.OrderInventoryJoinTable do
  use Ecto.Migration

  def change do
    create table(:inventories_orders, primary_key: false) do
      add :inventory_id, references(:inventories, on_delete: :delete_all)
      add :order_id, references(:orders, on_delete: :delete_all)
    end

    alter table(:orders) do
      remove :inventory_id
    end
  end
end
