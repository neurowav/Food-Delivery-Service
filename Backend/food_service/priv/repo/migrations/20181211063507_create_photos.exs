defmodule FoodService.Repo.Migrations.CreatePhotos do
  use Ecto.Migration

  def change do
    create table(:photos) do
      add :file, :string
      add :owner_id, :integer
      add :owner_type, :integer
      timestamps()
    end
    create index(:photos, [:owner_id])
  end
end
