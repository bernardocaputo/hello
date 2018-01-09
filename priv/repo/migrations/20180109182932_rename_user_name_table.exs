defmodule Hello.Repo.Migrations.RenameUserEmailTable do
  use Ecto.Migration

  def change do
    rename table(:users), :email, to: :email
  end
end
