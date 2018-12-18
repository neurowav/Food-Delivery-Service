defmodule FoodService.Accounts do
  import Ecto.{Query, Changeset}, warn: false
  alias FoodService.Repo

  alias FoodService.Accounts.User

  def list_users do
    Repo.all(User)
  end

  def get_last_user do
    q = from p in User,
        limit: 1,
        order_by: [desc: :inserted_at]
    Repo.one q
  end

  def current_user(conn),
    do: conn |> Guardian.Plug.current_resource() |> Repo.preload(preload_list())

  def get_user(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.create_changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    created_user =
      user
      |> User.changeset(attrs)
      |> Repo.update()

    case created_user do
      {:ok, user} ->
        user =
          user
          |> Repo.preload(preload_list())

        {:ok, user}

      error ->
        error
    end
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def preload_list() do
    [:orders]
  end
end
