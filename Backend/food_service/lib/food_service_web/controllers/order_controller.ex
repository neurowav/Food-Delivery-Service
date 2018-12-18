defmodule FoodServiceWeb.OrderController do
  use FoodServiceWeb, :controller

  alias FoodService.Orders

  def index(conn, _) do
    orders = Orders.order_list()

    render(conn, "index.json", %{orders: orders})
  end

  def show(conn, %{"id" => _id}) do
    case Orders.get_last_order() do
      nil ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json", message: "not found")

      order ->
        conn
        |> render("order.json", order: order)
    end
  end

  def create(conn, params) do
    case Orders.update_last_order(params["inventory_id"]) do
      {:ok, order} ->
        conn
        |> render("order.json", %{order: order})

      {:error, reason} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json", reason: reason)
    end
  end

  def delete(conn, params) do
    case Orders.delete_from_last_order(params["inventory_id"]) do
      {:ok, _order} ->
        orders = Orders.order_list()
        conn
        |> render("index.json", %{orders: orders})

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
