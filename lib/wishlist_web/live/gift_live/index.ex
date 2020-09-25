defmodule WishlistWeb.GiftLive.Index do
  use WishlistWeb, :live_view

  alias Wishlist.Wishlists
  alias Wishlist.Wishlists.Gift

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :gifts, list_gifts())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    events = Wishlists.list_events()

    socket
    |> assign(:page_title, "Edit Gift")
    |> assign(:gift, Wishlists.get_gift!(id))
    |> assign(:events, events)
  end

  defp apply_action(socket, :new, _params) do
    events = Wishlists.list_events()

    socket
    |> assign(:page_title, "New Gift")
    |> assign(:gift, %Gift{})
    |> assign(:events, events)
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Gifts")
    |> assign(:gift, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    gift = Wishlists.get_gift!(id)
    {:ok, _} = Wishlists.delete_gift(gift)

    {:noreply, assign(socket, :gifts, list_gifts())}
  end

  defp list_gifts do
    Wishlists.list_gifts()
  end
end
