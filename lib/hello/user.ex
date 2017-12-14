defmodule Hello.User do
  use Hello.Web, :model

  alias Hello.User
  alias Hello.Repo

  schema "users" do
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> validate_length(:name, min: 3, max: 20)
    # |> put_pass_hash()
  end

  def registration_changeset(model, params) do
      model
      |> changeset(params)
      |> cast(params, ~w(password), [])
      |> validate_length(:password, min: 6, max: 100)
      |> put_pass_hash()
    end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset {valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
        _ ->
        changeset
    end
  end
end
