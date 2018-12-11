defmodule FoodServiceWeb.OrderController do
  use FoodServiceWeb, :controller

  alias FoodService.Orders

  def index(conn, _) do
    orders = Orders.order_list()

    render(conn, "index.json", %{orders: orders})
  end

  def create(conn, params) do
    case Orders.create_order(params) do
      {:ok, order} ->
        conn
        |> render("order.json", %{order: order})

      {:error, reason} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json", reason: reason)
    end
  end

  def update(conn, %{
        "id" => id,
        "params" => params
      }) do
    case Orders.update_order(id, params) do
      {:ok, order} ->
        conn
        |> render("order.json", %{order: order})

      {:error, reason} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json", reason: reason)
    end
  end
end
