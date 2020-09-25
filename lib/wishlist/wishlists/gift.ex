defmodule Wishlist.Wishlists.Gift do
  use Ecto.Schema
  import Ecto.Changeset
  alias Wishlist.Wishlists.Event
  alias Wishlist.Wishlists.Assignment

  schema "gifts" do
    field :image, :string
    field :link, :string
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
    |> cast(attrs, [:name, :price, :image, :link, :description, :event_id])
    |> validate_required([:name, :price, :image, :link, :description, :event_id])
  end

  def assigned?(a_gift) do
    a_gift.assignment != nil
  end
end
