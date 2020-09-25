defmodule WishlistWeb.AssignmentLiveTest do
  use WishlistWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Wishlist.Wishlists

  @create_attrs %{buyer: "some buyer"}
  @update_attrs %{buyer: "some updated buyer"}
  @invalid_attrs %{buyer: nil}

  defp fixture(:assignment) do
    {:ok, assignment} = Wishlists.create_assignment(@create_attrs)
    assignment
  end

  defp create_assignment(_) do
    assignment = fixture(:assignment)
    %{assignment: assignment}
  end

  describe "Index" do
    setup [:create_assignment]

    test "lists all assignments", %{conn: conn, assignment: assignment} do
      {:ok, _index_live, html} = live(conn, Routes.assignment_index_path(conn, :index))

      assert html =~ "Listing Assignments"
      assert html =~ assignment.buyer
    end

    test "saves new assignment", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.assignment_index_path(conn, :index))

      assert index_live |> element("a", "New Assignment") |> render_click() =~
               "New Assignment"

      assert_patch(index_live, Routes.assignment_index_path(conn, :new))

      assert index_live
             |> form("#assignment-form", assignment: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#assignment-form", assignment: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.assignment_index_path(conn, :index))

      assert html =~ "Assignment created successfully"
      assert html =~ "some buyer"
    end

    test "updates assignment in listing", %{conn: conn, assignment: assignment} do
      {:ok, index_live, _html} = live(conn, Routes.assignment_index_path(conn, :index))

      assert index_live |> element("#assignment-#{assignment.id} a", "Edit") |> render_click() =~
               "Edit Assignment"

      assert_patch(index_live, Routes.assignment_index_path(conn, :edit, assignment))

      assert index_live
             |> form("#assignment-form", assignment: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#assignment-form", assignment: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.assignment_index_path(conn, :index))

      assert html =~ "Assignment updated successfully"
      assert html =~ "some updated buyer"
    end

    test "deletes assignment in listing", %{conn: conn, assignment: assignment} do
      {:ok, index_live, _html} = live(conn, Routes.assignment_index_path(conn, :index))

      assert index_live |> element("#assignment-#{assignment.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#assignment-#{assignment.id}")
    end
  end

  describe "Show" do
    setup [:create_assignment]

    test "displays assignment", %{conn: conn, assignment: assignment} do
      {:ok, _show_live, html} = live(conn, Routes.assignment_show_path(conn, :show, assignment))

      assert html =~ "Show Assignment"
      assert html =~ assignment.buyer
    end

    test "updates assignment within modal", %{conn: conn, assignment: assignment} do
      {:ok, show_live, _html} = live(conn, Routes.assignment_show_path(conn, :show, assignment))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Assignment"

      assert_patch(show_live, Routes.assignment_show_path(conn, :edit, assignment))

      assert show_live
             |> form("#assignment-form", assignment: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#assignment-form", assignment: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.assignment_show_path(conn, :show, assignment))

      assert html =~ "Assignment updated successfully"
      assert html =~ "some updated buyer"
    end
  end
end
