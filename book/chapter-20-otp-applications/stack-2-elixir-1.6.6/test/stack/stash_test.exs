defmodule StashTest do
  use ExUnit.Case
  alias Stack.Stash
  doctest Stash

  describe "start_link/1" do
    @tag :skip
    test "accepts an initial stack on start" do
      initial_stack = [1, 2, 3]

      assert {:ok, _pid} = Stash.start_link(initial_stack)
    end
  end

  describe "get/0" do
    @tag :skip
    test "gets current stash" do
      assert Stash.get() == [4, 5, 6]
    end
  end

  describe "update/1" do
    @tag :skip
    test "replaces current stash" do
      Stash.update([9, 8, 7])

      assert Stash.get() == [9, 8, 7]
    end
  end
end
