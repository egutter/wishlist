defmodule WishlistWeb.GiftLive.Show do
  use WishlistWeb, :live_view

  alias Wishlist.Wishlists

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:gift, Wishlists.get_gift!(id))
     |> assign(:events, Wishlists.list_events())}
  end

  defp page_title(:show), do: "Show Gift"
  defp page_title(:edit), do: "Edit Gift"
end
