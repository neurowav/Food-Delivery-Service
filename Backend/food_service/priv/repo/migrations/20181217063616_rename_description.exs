defmodule FoodService.Repo.Migrations.RenameDescription do
  use Ecto.Migration

  def change do
    alter table(:inventories) do
      remove :description
      add :detail, :text
    end
  end
end
