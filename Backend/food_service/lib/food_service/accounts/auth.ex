defmodule FoodService.Accounts.Auth do
  alias Comeonin.Argon2
  alias FoodService.Repo
  alias FoodService.Accounts.User

  def authenticate(email, plain_text_password) do
    case User |> Repo.get_by(email: email) do
      nil ->
        Argon2.dummy_checkpw()
        {:error, :wrong_username}

      user ->
        if Argon2.checkpw(plain_text_password, user.password_hash) do
          {:ok, user}
        else
          {:error, :wrong_password}
        end
    end
  end
end
