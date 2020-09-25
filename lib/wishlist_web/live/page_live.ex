defmodule WishlistWeb.PageLive do
  use WishlistWeb, :live_view
  alias Wishlist.Wishlists
  alias Wishlist.Wishlists.Assignment

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: "", events: list_events(), gifts: [])}
  end

  @impl true
  def handle_event("suggest", %{"event" => event_params}, socket) do
    {:noreply, assign(socket, gifts: list_gifts(event_params["event_id"]))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    IO.puts socket.assigns.live_action
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :new_assignment, _params) do
    socket
    |> assign(:page_title, "New Assignment")
    |> assign(:assignment, %Assignment{})
  end

  defp apply_action(socket, _any, _params) do
    socket
  end

  @impl true
#  def handle_event("search", %{"q" => query}, socket) do
#    case search(query) do
#      %{^query => vsn} ->
#        {:noreply, redirect(socket, external: "https://hexdocs.pm/#{query}/#{vsn}")}
#
#      _ ->
#        {:noreply,
#         socket
#         |> put_flash(:error, "No dependencies found matching \"#{query}\"")
#         |> assign(results: %{}, query: query)}
#    end
#  end

  defp list_events() do
    Wishlists.list_events()
  end

  defp list_gifts(event_id) do
    Wishlists.find_gifts(event_id)
#    for {app, desc, vsn} <- Application.started_applications(),
#        app = to_string(app),
#        String.starts_with?(app, query) and not List.starts_with?(desc, ~c"ERTS"),
#        into: %{},
#        do: {app, vsn}
  end
end
