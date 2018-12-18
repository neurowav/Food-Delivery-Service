defmodule FoodService.Company do
  import Ecto.{Query, Changeset}, warn: false
  alias FoodService.Repo

  alias FoodService.Company.{Comment, Provider}

  def get_provider(id), do: Repo.get!(Provider, id)

  def get_last_provider do
    q = from p in Provider,
        limit: 1,
        order_by: [desc: :inserted_at],
        preload: :comments
    Repo.one q
  end

  def create_provider(attrs \\ %{}) do
    %Provider{}
    |> Provider.changeset(attrs)
    |> Repo.insert()
  end

  def create_comment(attrs \\ %{}) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end

  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end
end
