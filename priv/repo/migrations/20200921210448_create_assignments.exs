defmodule Wishlist.Repo.Migrations.CreateAssignments do
  use Ecto.Migration

  def change do
    create table(:assignments) do
      add :buyer, :string
      add :gift_id, references(:gifts, on_delete: :nothing)

      timestamps()
    end

    create index(:assignments, [:gift_id])
  end
end
