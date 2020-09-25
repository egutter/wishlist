defmodule Wishlist.Wishlists.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :event_date, :date
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :event_date])
    |> validate_required([:name, :event_date])
  end

  def pretty_name(event) do
    "#{Timex.format!(event.event_date, "{D}/{M}/{YYYY}")} - #{event.name}"
  end
end
