defmodule Wishlist.Wishlists.Assignment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Wishlist.Wishlists.Gift

  @topic "assignment"

  schema "assignments" do
    field :buyer, :string
    belongs_to :gift, Gift

    timestamps()
  end

  @doc false
  def changeset(assignment, attrs) do
    assignment
    |> cast(attrs, [:buyer, :gift_id])
    |> validate_required([:buyer, :gift_id])
  end

  def topic do
    @topic
  end

end
