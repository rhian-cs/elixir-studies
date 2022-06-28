defmodule Stack.ImplTest do
  use ExUnit.Case
  alias Stack.Impl

  describe "push/2" do
    test "adds element when stack is empty" do
      assert Impl.push([], 1) == [1]
    end

    test "adds element when stack is not empty" do
      assert Impl.push([1], 2) == [2, 1]
    end
  end

  describe "pop/1" do
    test "returns top element and new stack when stack is not empty" do
      assert Impl.pop([1, 2]) == {1, [2]}
    end

    test "returns top element and an empty stack when stack has only one element" do
      assert Impl.pop([1]) == {1, []}
    end

    test "raises an error when stack is empty" do
      assert_raise FunctionClauseError, fn -> Impl.pop([]) end
    end
  end
end
