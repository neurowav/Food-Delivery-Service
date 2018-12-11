defmodule FoodService.Files.Photo do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  @required [
    :file,
    :owner_id,
    :owner_type
  ]

  @optional [
    :delete
  ]

  schema "photos" do
    field :file, FoodService.Images.Type
    field :owner_id, :integer
    field :owner_type, PhotoOwnerTypeEnum
    field :delete, :boolean, virtual: true

    timestamps()
  end

  def changeset(%FoodService.Files.Photo{} = photo, attrs) do
    photo
    |> cast(attrs, @required ++ @optional)
    |> mark_for_deletion
  end

  defp mark_for_deletion(changeset) do
    if get_change(changeset, :delete) do
      %{changeset | action: :delete}
    else
      changeset
    end
  end
end
