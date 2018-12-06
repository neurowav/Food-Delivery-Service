defmodule FoodService.Accounts.Guardian.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :food_service,
    error_handler: FoodService.Accounts.Guardian.ErrorHandler,
    module: FoodService.Accounts.Guardian

  plug(Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"})
  # Load the user if either of the verifications worked
  plug(Guardian.Plug.LoadResource, allow_blank: true)
end
