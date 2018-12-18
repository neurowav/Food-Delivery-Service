defmodule FoodServiceWeb.Router do
  use FoodServiceWeb, :router
  use Plug.ErrorHandler

#  pipeline :browser do
#    plug :accepts, ["html"]
#    plug :fetch_session
#    plug :fetch_flash
#    plug :protect_from_forgery
#    plug :put_secure_browser_headers
#  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :user_api do
    plug :accepts, ["json"]
  end

  pipeline :user_auth do
    plug FoodService.Accounts.Guardian.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FoodServiceWeb do
    pipe_through [:api] #, :user_auth, :ensure_auth]

    resources "/provider", ProviderController, only: [] do
      resources "/comment", CommentController, only: [:index, :create]
    end
    resources "/inventory", InventoryController, only: [:index]
    post "/orders/delete", OrderController, :delete
    resources "/orders", OrderController, only: [:index, :create, :update, :show]
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", FoodServiceWeb do
  #   pipe_through :api
  # end
end
