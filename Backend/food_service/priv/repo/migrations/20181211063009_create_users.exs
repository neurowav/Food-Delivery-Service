defmodule FoodService.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :password_hash, :string
      add :sessions, {:map, :integer}, default: "{}"
      timestamps()
    end
    create unique_index :users, [:email]

    alter table(:orders) do
      add :user_id, :integer
    end
    create index(:orders, [:user_id])
  end
end
