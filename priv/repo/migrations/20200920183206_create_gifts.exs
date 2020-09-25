defmodule Wishlist.Repo.Migrations.CreateGifts do
  use Ecto.Migration

  def change do
    create table(:gifts) do
      add :name, :string
      add :price, :decimal
      add :image, :string
      add :link, :string
      add :event_id, references(:events, on_delete: :nothing)

      timestamps()
    end

    create index(:gifts, [:event_id])
  end
end
