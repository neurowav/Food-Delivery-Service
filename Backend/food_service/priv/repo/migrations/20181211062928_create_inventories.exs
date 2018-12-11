defmodule FoodService.Repo.Migrations.CreateInventories do
  use Ecto.Migration

  def change do
    create table(:inventories) do
      add :name, :string, null: false
      add :amount, :float, null: false, default: 0.0
      add :description, :text
      timestamps()
    end
  end
end
