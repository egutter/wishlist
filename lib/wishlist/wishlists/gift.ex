defmodule Wishlist.Wishlists.Gift do
  use Ecto.Schema
  import Ecto.Changeset
  alias Wishlist.Wishlists.Event
  alias Wishlist.Wishlists.Assignment

  schema "gifts" do
    field :image, :string
    field :link, :string
    field :link_2, :string
    field :link_3, :string
    field :name, :string
    field :description, :string
    field :price, :decimal
    belongs_to :event, Event
    has_one :assignment, Assignment

    timestamps()
  end

  @doc false
  def changeset(gift, attrs) do
    gift
    |> cast(attrs, [:name, :price, :image, :link, :link_2, :link_3, :description, :event_id])
    |> validate_required([:name, :price, :image, :description, :event_id])
  end

  def assigned?(a_gift) do
    a_gift.assignment != nil
  end
end
