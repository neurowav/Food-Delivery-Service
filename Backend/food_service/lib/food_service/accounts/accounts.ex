defmodule FoodService.Accounts do
  import Ecto.{Query, Changeset}, warn: false
  alias FoodService.Repo

  alias FoodService.Accounts.User

  def list_users do
    Repo.all(User)
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

  def list_sessions(user_id) do
    with user when is_map(user) <- Repo.get(User, user_id), do: user.sessions
  end

  def add_session(%User{sessions: sessions} = user, session_id, timestamp) do
    user
    |> change(sessions: put_in(sessions, [session_id], timestamp))
    |> Repo.update()
  end

  def delete_session(%User{sessions: sessions} = user, session_id) do
    user
    |> change(sessions: Map.delete(sessions, session_id))
    |> Repo.update()
  end

  def remove_old_sessions(session_age) do
    now = System.system_time(:second)

    Enum.map(
      list_users(),
      &(&1
        |> change(
          sessions:
            :maps.filter(
              fn _, time ->
                time + session_age > now
              end,
              &1.sessions
            )
        )
        |> Repo.update())
    )
  end

  def preload_list() do
    [:orders]
  end
end
