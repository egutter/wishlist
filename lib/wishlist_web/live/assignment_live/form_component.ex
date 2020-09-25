defmodule WishlistWeb.AssignmentLive.FormComponent do
  use WishlistWeb, :live_component

  alias Wishlist.Wishlists
  alias Wishlist.Wishlists.Assignment
  alias Phoenix.PubSub

  @impl true
  def update(%{assignment: assignment} = assigns, socket) do
    changeset = Wishlists.change_assignment(assignment)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"assignment" => assignment_params}, socket) do
    changeset =
      socket.assigns.assignment
      |> Wishlists.change_assignment(assignment_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"assignment" => assignment_params}, socket) do
    save_assignment(socket, socket.assigns.action, assignment_params)
  end

  defp save_assignment(socket, :edit, assignment_params) do
    case Wishlists.update_assignment(socket.assigns.assignment, assignment_params) do
      {:ok, _assignment} ->
        {:noreply,
         socket
         |> put_flash(:info, "Assignment updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_assignment(socket, :new, assignment_params) do
    case Wishlists.create_assignment(assignment_params) do
      {:ok, assignment} ->
        gift = Wishlists.get_gift!(assignment.gift_id)

        PubSub.broadcast(Wishlist.PubSub, Assignment.topic(), {:assignament, gift.event_id})

        {:noreply,
         socket
         |> put_flash(:info, "El regalo #{gift.name} fue asignado a #{assignment.buyer}")
         |> push_redirect(to: "#{socket.assigns.return_to}?event_id=#{gift.event_id}" )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
