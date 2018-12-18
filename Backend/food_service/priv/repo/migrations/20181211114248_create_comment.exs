defmodule FoodService.Repo.Migrations.CreateComment do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :info, :string, null: false
      add :provider_id, :integer
      timestamps()
    end

    create index(:comments, [:provider_id])
  end
end
