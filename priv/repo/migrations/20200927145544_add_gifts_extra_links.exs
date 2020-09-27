defmodule Wishlist.Repo.Migrations.AddGiftsExtraLinks do
  use Ecto.Migration

  def change do
    alter table("gifts") do
      add :link_2, :text
      add :link_3, :text
    end
  end
end
