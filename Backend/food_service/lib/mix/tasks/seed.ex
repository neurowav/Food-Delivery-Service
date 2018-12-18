defmodule Mix.Tasks.Seed do
  use Mix.Task

  alias FoodService.Repo
  alias FoodService.Accounts.User
  alias FoodService.Accounts
  alias FoodService.Company
  alias FoodService.Company.Provider
  alias FoodService.Orders
  alias FoodService.Orders.Order
  alias FoodService.Files.Photo

  def run(_) do
    Mix.Task.run("app.start", [])

    if Mix.env() in [:dev, :prod], do: seed()
  end

  def seed() do
    Repo.delete_all(User)
    Repo.delete_all(Provider)
    Repo.delete_all(Orders.Order)
    Repo.delete_all(Orders.Inventory)

    {:ok, user} =
      Accounts.create_user(%{
        "email" => "example@food.ru",
        "password" => "qwerty123"
      })

    {:ok, provider} =
      Company.create_provider(%{
        "name" => "MegaFood",
        "email" => "example@food.ru",
        "phone" => "+79009004545",
        "site" => "megafood.ru"
      })

    {:ok, _comment1} =
      Company.create_comment(%{
        "provider_id" => provider.id,
        "info" => "Good provider, the pizza was awesome. Wait for another order",
      })

    {:ok, _comment2} =
      Company.create_comment(%{
        "provider_id" => provider.id,
        "info" => "Awesome",
      })

    {:ok, _comment3} =
      Company.create_comment(%{
        "provider_id" => provider.id,
        "info" => "The best",
      })

    {:ok, _inventory1} =
      Orders.create_inventory(%{
        name: "Pizza Margherita",
        type: 2,
        hotcold: true,
        detail: "Features tomatoes, sliced mozzarella, basil, and extra virgin olive oil.",
        amount: 39.99,
        photo: %{file: %Plug.Upload{ filename: "pizza1.jpg", path: Path.expand("./public/pizza1.jpg")}, owner_type: :inventory}
      })


    {:ok, _inventory2} =
      Orders.create_inventory(%{
        name: "Bacon cheese fry",
        type: 0,
        hotcold: true,
        detail: "Features tomatoes, bacon, cheese, basil and oil",
        amount: 29.99,
        photo: %{file: %Plug.Upload{ filename: "bacon1.jpg", path: Path.expand("./public/bacon1.jpg")}, owner_type: :inventory}
      })

    {:ok, _order} =
      %Order{}
      |> Order.changeset(%{"user_id" => user.id})
      |> Repo.insert()
  end
end
