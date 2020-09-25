defmodule WishlistWeb.AssignmentLive.Index do
  use WishlistWeb, :live_view

  alias Phoenix.PubSub
  alias Wishlist.Wishlists
  alias Wishlist.Wishlists.Assignment
  alias Wishlist.Wishlists.Event

  @topic "assignment"

  @impl true
  def mount(_params, _session, socket) do
    PubSub.subscribe(Wishlist.PubSub, Assignment.topic())

    {:ok, assign(socket, :assignments, events: list_events(), gifts: [])}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Assignment")
    |> assign(:assignment, Wishlists.get_assignment!(id))
  end

  defp apply_action(socket, :new, %{"gift_id" => gift_id} = params) do
    gift = Wishlists.get_gift!(gift_id)
    socket
    |> assign(:page_title, "Asignar el regalo")
    |> assign(:assignment, %Assignment{gift_id: gift.id})
    |> assign(:event_id, gift.event_id)
  end

  defp apply_action(socket, :index, params) do
    socket
    |> assign(:page_title, "Listing Assignments")
    |> assign(:assignment, nil)
    |> assign(:event, Wishlists.change_event(%Event{id: params["event_id"]}))
    |> assign(:events, list_events())
    |> assign(:gifts, list_gifts(params["event_id"]))
  end

  @impl true
  def handle_event("pick_event", %{"event" => event_params}, socket) do
    {:noreply, assign(socket, gifts: list_gifts(event_params["id"]))
               |> assign(:event, Wishlists.change_event(%Event{id: event_params["id"]}))
    }
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    assignment = Wishlists.get_assignment!(id)
    event_id = assignment.gift.event_id
    {:ok, _} = Wishlists.delete_assignment(assignment)

    PubSub.broadcast(Wishlist.PubSub, Assignment.topic(), {:assignament, event_id})

    {:noreply, assign(socket, :gifts, list_gifts(event_id))}
  end

  def handle_info({:assignament, event_id}, socket) do
    {:noreply, assign(socket, gifts: list_gifts(event_id))}
  end

  defp list_assignments do
    Wishlists.list_assignments()
  end

  defp list_events() do
    Wishlists.list_events()
  end

  defp list_gifts(nil) do
    []
  end

  defp list_gifts("") do
    []
  end

  defp list_gifts(event_id) do
    Wishlists.find_gifts(event_id)
  end
end
