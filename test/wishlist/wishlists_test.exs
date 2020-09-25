defmodule Wishlist.WishlistsTest do
  use Wishlist.DataCase

  alias Wishlist.Wishlists

  describe "events" do
    alias Wishlist.Wishlists.Event

    @valid_attrs %{event_date: ~D[2010-04-17], name: "some name"}
    @update_attrs %{event_date: ~D[2011-05-18], name: "some updated name"}
    @invalid_attrs %{event_date: nil, name: nil}

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Wishlists.create_event()

      event
    end

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Wishlists.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Wishlists.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = Wishlists.create_event(@valid_attrs)
      assert event.event_date == ~D[2010-04-17]
      assert event.name == "some name"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Wishlists.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      assert {:ok, %Event{} = event} = Wishlists.update_event(event, @update_attrs)
      assert event.event_date == ~D[2011-05-18]
      assert event.name == "some updated name"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Wishlists.update_event(event, @invalid_attrs)
      assert event == Wishlists.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Wishlists.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Wishlists.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Wishlists.change_event(event)
    end
  end
  

  describe "gifts" do
    alias Wishlist.Wishlists.Gift

    @valid_attrs %{image: "some image", link: "some link", name: "some name", price: "120.5"}
    @update_attrs %{image: "some updated image", link: "some updated link", name: "some updated name", price: "456.7"}
    @invalid_attrs %{image: nil, link: nil, name: nil, price: nil}

    def gift_fixture(attrs \\ %{}) do
      {:ok, gift} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Wishlists.create_gift()

      gift
    end

    test "list_gifts/0 returns all gifts" do
      gift = gift_fixture()
      assert Wishlists.list_gifts() == [gift]
    end

    test "get_gift!/1 returns the gift with given id" do
      gift = gift_fixture()
      assert Wishlists.get_gift!(gift.id) == gift
    end

    test "create_gift/1 with valid data creates a gift" do
      assert {:ok, %Gift{} = gift} = Wishlists.create_gift(@valid_attrs)
      assert gift.image == "some image"
      assert gift.link == "some link"
      assert gift.name == "some name"
      assert gift.price == Decimal.new("120.5")
    end

    test "create_gift/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Wishlists.create_gift(@invalid_attrs)
    end

    test "update_gift/2 with valid data updates the gift" do
      gift = gift_fixture()
      assert {:ok, %Gift{} = gift} = Wishlists.update_gift(gift, @update_attrs)
      assert gift.image == "some updated image"
      assert gift.link == "some updated link"
      assert gift.name == "some updated name"
      assert gift.price == Decimal.new("456.7")
    end

    test "update_gift/2 with invalid data returns error changeset" do
      gift = gift_fixture()
      assert {:error, %Ecto.Changeset{}} = Wishlists.update_gift(gift, @invalid_attrs)
      assert gift == Wishlists.get_gift!(gift.id)
    end

    test "delete_gift/1 deletes the gift" do
      gift = gift_fixture()
      assert {:ok, %Gift{}} = Wishlists.delete_gift(gift)
      assert_raise Ecto.NoResultsError, fn -> Wishlists.get_gift!(gift.id) end
    end

    test "change_gift/1 returns a gift changeset" do
      gift = gift_fixture()
      assert %Ecto.Changeset{} = Wishlists.change_gift(gift)
    end
  end

  describe "assignments" do
    alias Wishlist.Wishlists.Assignment

    @valid_attrs %{buyer: "some buyer"}
    @update_attrs %{buyer: "some updated buyer"}
    @invalid_attrs %{buyer: nil}

    def assignment_fixture(attrs \\ %{}) do
      {:ok, assignment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Wishlists.create_assignment()

      assignment
    end

    test "list_assignments/0 returns all assignments" do
      assignment = assignment_fixture()
      assert Wishlists.list_assignments() == [assignment]
    end

    test "get_assignment!/1 returns the assignment with given id" do
      assignment = assignment_fixture()
      assert Wishlists.get_assignment!(assignment.id) == assignment
    end

    test "create_assignment/1 with valid data creates a assignment" do
      assert {:ok, %Assignment{} = assignment} = Wishlists.create_assignment(@valid_attrs)
      assert assignment.buyer == "some buyer"
    end

    test "create_assignment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Wishlists.create_assignment(@invalid_attrs)
    end

    test "update_assignment/2 with valid data updates the assignment" do
      assignment = assignment_fixture()
      assert {:ok, %Assignment{} = assignment} = Wishlists.update_assignment(assignment, @update_attrs)
      assert assignment.buyer == "some updated buyer"
    end

    test "update_assignment/2 with invalid data returns error changeset" do
      assignment = assignment_fixture()
      assert {:error, %Ecto.Changeset{}} = Wishlists.update_assignment(assignment, @invalid_attrs)
      assert assignment == Wishlists.get_assignment!(assignment.id)
    end

    test "delete_assignment/1 deletes the assignment" do
      assignment = assignment_fixture()
      assert {:ok, %Assignment{}} = Wishlists.delete_assignment(assignment)
      assert_raise Ecto.NoResultsError, fn -> Wishlists.get_assignment!(assignment.id) end
    end

    test "change_assignment/1 returns a assignment changeset" do
      assignment = assignment_fixture()
      assert %Ecto.Changeset{} = Wishlists.change_assignment(assignment)
    end
  end
end
