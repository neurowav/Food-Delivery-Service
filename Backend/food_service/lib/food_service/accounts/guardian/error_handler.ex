defmodule FoodService.Accounts.Guardian.ErrorHandler do
  use FoodServiceWeb, :controller

  alias FoodServiceWeb.ErrorView
  alias FoodService.Changeset.Error

  def auth_error(conn, {type, _reason}, _opts) do
    error = type |> to_string() |> Error.auth_error()

    conn
    |> put_status(401)
    |> render(ErrorView, "401.json", error: error)
  end
end
