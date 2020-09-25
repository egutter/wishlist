defmodule Wishlist.Repo.Migrations.GiftsAddAuthorDescription do
  use Ecto.Migration

  def change do
    alter table("gifts") do
      add :description, :text
    end
  end
end
