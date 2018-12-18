defmodule FoodService.Company.Provider do
  use Ecto.Schema
  import Ecto.Changeset

  alias FoodService.Company.Provider

  @required [:name, :phone, :email]
  @optional [:site]

  schema "providers" do
    has_one :photo, FoodService.Files.Photo, foreign_key: :owner_id
    has_many :comments, FoodService.Company.Comment
    field :name, :string
    field :phone, :string
    field :email, :string
    field :site, :string
    timestamps()
  end

  @doc false
  def changeset(%Provider{} = provider, attrs) do
    provider
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
    |> cast_assoc(:photo)
  end
end
