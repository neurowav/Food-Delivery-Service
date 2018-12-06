defmodule FoodService.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias FoodService.Accounts.User

  @required [:email, :password]
  @optional []

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string
    field :sessions, {:map, :integer}, default: %{}

    # User fields

    has_many :orders, FoodService.Orders.Order

    timestamps()
  end

  @required_fields ~w(email)a
  @optional_fields ~w()a

  def changeset(
        %User{} = user,
        %{"password" => _password, "password_confirmation" => _password_confirmation} = attrs
      ) do
    user
    |> cast(attrs, [:password, :password_confirmation])
    |> validate_required([:password, :password_confirmation])
    |> validate_password(:password)
    |> validate_password_confirmation(:password, :password_confirmation)
    |> put_pass_hash
  end

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_email
  end

  def create_changeset(%User{} = user, attrs) do
    attrs =
      if Map.has_key?(attrs, "password") do
        attrs
      else
        length = 8

        password =
          length
          |> :crypto.strong_rand_bytes()
          |> Base.encode64()
          |> binary_part(0, length)

        Map.merge(attrs, %{"password" => password})
      end

    user
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
    |> cast_assoc(:photo)
    |> assoc_constraint(:city)
    |> unique_email
    |> unique_constraint(:id, name: :users_pkey)
    |> validate_password(:password)
    |> put_pass_hash
  end

  defp unique_email(changeset) do
    changeset
    |> validate_format(:email, ~r/@/)
    |> validate_length(:email, max: 254)
    |> unique_constraint(:email)
  end

  defp validate_password(changeset, field, options \\ []) do
    changeset
    |> validate_change(field, fn _, password ->
      case strong_password?(password) do
        {:ok, _} -> []
        {:error, msg} -> [{field, options[:message] || msg}]
      end
    end)
  end

  defp put_pass_hash(
         %Ecto.Changeset{
           valid?: true,
           changes: %{password: password, password_confirmation: _password_confirmation}
         } = changeset
       ) do
    put_change(changeset, :password_hash, Comeonin.Argon2.add_hash(password))
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Comeonin.Argon2.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset

  defp strong_password?(password) when byte_size(password) > 7 do
    {:ok, password}
  end

  defp strong_password?(_), do: {:error, "The password is too short"}

  defp validate_password_confirmation(changeset, pass_field, conf_field, options \\ []) do
    pwd = get_change(changeset, pass_field)

    changeset
    |> validate_change(conf_field, fn _, password_confirmation ->
      case password_confirmation do
        ^pwd ->
          []

        _ ->
          [
            {password_confirmation,
             options[:message] || "The password is not equal password confirmation"}
          ]
      end
    end)
  end
end
