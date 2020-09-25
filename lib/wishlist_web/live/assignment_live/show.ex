defmodule WishlistWeb.AssignmentLive.Show do
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
     |> assign(:assignment, Wishlists.get_assignment!(id))}
  end

  defp page_title(:show), do: "Show Assignment"
  defp page_title(:edit), do: "Edit Assignment"
end
