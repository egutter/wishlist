defmodule Wishlist.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :event_date, :date

      timestamps()
    end

  end
end
