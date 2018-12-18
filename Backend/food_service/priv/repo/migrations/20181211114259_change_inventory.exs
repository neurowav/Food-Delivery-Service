defmodule FoodService.Repo.Migrations.ChangeInventory do
  use Ecto.Migration

  def change do
    alter table(:inventories) do
      add :type, :integer, null: false, default: 0
      add :hotcold, :boolean
      add :provider_id, :integer
    end

    create index(:inventories, [:provider_id])
  end
end
