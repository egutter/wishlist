defmodule WishlistWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers
  alias Number.Currency
  alias Wishlist.Wishlists.Gift
  alias Phoenix.HTML.Tag
  import Phoenix.HTML

  @doc """
  Renders a component inside the `WishlistWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, WishlistWeb.EventLive.FormComponent,
        id: @event.id || :new,
        action: @live_action,
        event: @event,
        return_to: Routes.event_index_path(@socket, :index) %>
  """
  def live_modal(socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(socket, WishlistWeb.ModalComponent, modal_opts)
  end

  def gift_assigned?(a_gift) do
    Gift.assigned? a_gift
  end

  def number_to_currency(number) do
    Currency.number_to_currency(number)
  end

  def shop_link_sites_header(nil) do
    ""
  end

  def shop_link_sites_header(link) do
    ~E"""
    Opciones para comprar el regalo:
    <br />
    """
  end

  def shop_link_sites(nil, _number, _prefix) do
    ""
  end

  def shop_link_sites(link, number, prefix) do
    ~E"""
    <%= prefix %> <%= Tag.content_tag(:a, "Opción #{number}", target: "_blank", href: link) %>
    """
  end

end
