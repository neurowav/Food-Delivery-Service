defmodule FoodService.Repo.Migrations.CreateProvider do
  use Ecto.Migration

  def change do
    create table(:providers) do
      add :email, :string
      add :name, :string, null: false
      add :phone, :string
      add :site, :string

      timestamps()
    end
  end
end
