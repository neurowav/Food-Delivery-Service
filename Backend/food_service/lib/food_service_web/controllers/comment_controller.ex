defmodule FoodServiceWeb.CommentController do
  use FoodServiceWeb, :controller

  alias FoodService.Company

  def index(conn, _) do
    provider = Company.get_last_provider

    render(conn, "index.json", %{comments: provider.comments})
  end

  def create(conn, params) do
    provider = Company.get_last_provider
    case Company.create_comment(params |> Map.put("provider_id", provider.id)) do
      {:ok, comment} ->
        conn
        |> render("comment.json", %{comment: comment})

      {:error, reason} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json", reason: reason)
    end
  end
end
