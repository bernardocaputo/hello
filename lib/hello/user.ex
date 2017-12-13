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
    |> cast(attrs, [:name, :password])
    |> validate_required([:name, :password])
    |> validate_length(:name, min: 3, max: 20)
    # |> Repo.insert()
  end
end
