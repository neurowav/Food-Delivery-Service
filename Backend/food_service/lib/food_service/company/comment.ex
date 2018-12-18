defmodule FoodService.Company.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias FoodService.Company.Comment

  @required [:info, :provider_id]
  @optional []

  schema "comments" do
    belongs_to :provider, FoodService.Company.Provider
    field :info, :string
    timestamps()
  end

  @doc false
  def changeset(%Comment{} = comment, attrs) do
    comment
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
    |> assoc_constraint(:provider)
  end
end