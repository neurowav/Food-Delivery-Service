defmodule FoodServiceWeb.PhotoView do
  use FoodServiceWeb, :view

  def render("photo.json", %{photo: photo}) do
    %{
      id: photo.id,
      files: FoodService.Images.full_urls({photo.file, photo}),
      inserted_at: photo.inserted_at
    }
  end
end
