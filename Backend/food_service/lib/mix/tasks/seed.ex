defmodule Mix.Tasks.Seed do
  use Mix.Task

  alias FoodService.Repo
  alias FoodService.Accounts.User
  alias FoodService.Accounts
  alias FoodService.Orders
  alias FoodService.Files.Photo

  def run(_) do
    Mix.Task.run("app.start", [])

    if Mix.env() in [:dev, :prod], do: seed()
  end

  def seed() do
    Repo.delete_all(User)
    Repo.delete_all(Orders.Order)
    Repo.delete_all(Orders.Inventory)

    {:ok, user} =
      Accounts.create_user(%{
        "email" => "example@food.ru",
        "password" => "qwerty123"
      })

    {:ok, _inventory1} =
      Orders.create_inventory(%{
        name: "Pizza Margherita",
        description: "Features tomatoes, sliced mozzarella, basil, and extra virgin olive oil.",
        amount: 39.99,
        photo: %{file: %Plug.Upload{ filename: "pizza1.jpg", path: Path.expand("./public/pizza1.jpg")}, owner_type: :inventory}
      })


    {:ok, _inventory2} =
      Orders.create_inventory(%{
        name: "Bacon cheese fry",
        description: "Features tomatoes, bacon, cheese, basil and oil",
        amount: 29.99,
        photo: %{file: %Plug.Upload{ filename: "bacon1.jpg", path: Path.expand("./public/bacon1.jpg")}, owner_type: :inventory}
      })
  end
end
