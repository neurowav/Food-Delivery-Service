defmodule FoodService.Accounts.Guardian do
  use Guardian, otp_app: :domian_api

  alias FoodService.Accounts
  alias FoodService.Accounts.User
  alias FoodService.Changeset.Error

  def subject_for_token(%User{id: id} = _user, _claims) do
    {:ok, "User:#{id}"}
  end

  def subject_for_token(_, _), do: {:error, Error.auth_error("Unknown resource type")}

  def resource_from_claims(%{"sub" => "User:" <> id}) do
    case Accounts.get_user(id) do
      nil -> {:error, :user_not_found}
      user -> {:ok, user}
    end
  end

  def resource_from_claims(_), do: {:error, Error.auth_error("Unhandled resource type")}
end
