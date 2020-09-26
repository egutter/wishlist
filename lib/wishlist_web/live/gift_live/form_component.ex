defmodule WishlistWeb.GiftLive.FormComponent do
  use WishlistWeb, :live_component

  alias Wishlist.Wishlists
  alias Phoenix.PubSub
  alias Wishlist.Wishlists.Assignment

  @impl true
  def update(%{gift: gift} = assigns, socket) do
    changeset = Wishlists.change_gift(gift)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"gift" => gift_params}, socket) do
    changeset =
      socket.assigns.gift
      |> Wishlists.change_gift(gift_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"gift" => gift_params}, socket) do
    save_gift(socket, socket.assigns.action, gift_params)
  end

  defp save_gift(socket, :edit, gift_params) do
    case Wishlists.update_gift(socket.assigns.gift, gift_params) do
      {:ok, gift} ->

        PubSub.broadcast(Wishlist.PubSub, Assignment.topic(), {:assignament, gift.event_id})

        {:noreply,
         socket
         |> put_flash(:info, "Gift updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_gift(socket, :new, gift_params) do
    case Wishlists.create_gift(gift_params) do
      {:ok, gift} ->

        PubSub.broadcast(Wishlist.PubSub, Assignment.topic(), {:assignament, gift.event_id})

        {:noreply,
         socket
         |> put_flash(:info, "Gift created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
