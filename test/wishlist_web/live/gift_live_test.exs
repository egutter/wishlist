defmodule WishlistWeb.GiftLiveTest do
  use WishlistWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Wishlist.Wishlists

  @create_attrs %{image: "some image", link: "some link", name: "some name", price: "120.5"}
  @update_attrs %{image: "some updated image", link: "some updated link", name: "some updated name", price: "456.7"}
  @invalid_attrs %{image: nil, link: nil, name: nil, price: nil}

  defp fixture(:gift) do
    {:ok, gift} = Wishlists.create_gift(@create_attrs)
    gift
  end

  defp create_gift(_) do
    gift = fixture(:gift)
    %{gift: gift}
  end

  describe "Index" do
    setup [:create_gift]

    test "lists all gifts", %{conn: conn, gift: gift} do
      {:ok, _index_live, html} = live(conn, Routes.gift_index_path(conn, :index))

      assert html =~ "Listing Gifts"
      assert html =~ gift.image
    end

    test "saves new gift", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.gift_index_path(conn, :index))

      assert index_live |> element("a", "New Gift") |> render_click() =~
               "New Gift"

      assert_patch(index_live, Routes.gift_index_path(conn, :new))

      assert index_live
             |> form("#gift-form", gift: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#gift-form", gift: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.gift_index_path(conn, :index))

      assert html =~ "Gift created successfully"
      assert html =~ "some image"
    end

    test "updates gift in listing", %{conn: conn, gift: gift} do
      {:ok, index_live, _html} = live(conn, Routes.gift_index_path(conn, :index))

      assert index_live |> element("#gift-#{gift.id} a", "Edit") |> render_click() =~
               "Edit Gift"

      assert_patch(index_live, Routes.gift_index_path(conn, :edit, gift))

      assert index_live
             |> form("#gift-form", gift: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#gift-form", gift: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.gift_index_path(conn, :index))

      assert html =~ "Gift updated successfully"
      assert html =~ "some updated image"
    end

    test "deletes gift in listing", %{conn: conn, gift: gift} do
      {:ok, index_live, _html} = live(conn, Routes.gift_index_path(conn, :index))

      assert index_live |> element("#gift-#{gift.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#gift-#{gift.id}")
    end
  end

  describe "Show" do
    setup [:create_gift]

    test "displays gift", %{conn: conn, gift: gift} do
      {:ok, _show_live, html} = live(conn, Routes.gift_show_path(conn, :show, gift))

      assert html =~ "Show Gift"
      assert html =~ gift.image
    end

    test "updates gift within modal", %{conn: conn, gift: gift} do
      {:ok, show_live, _html} = live(conn, Routes.gift_show_path(conn, :show, gift))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Gift"

      assert_patch(show_live, Routes.gift_show_path(conn, :edit, gift))

      assert show_live
             |> form("#gift-form", gift: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#gift-form", gift: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.gift_show_path(conn, :show, gift))

      assert html =~ "Gift updated successfully"
      assert html =~ "some updated image"
    end
  end
end
