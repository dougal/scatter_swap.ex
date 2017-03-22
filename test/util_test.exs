defmodule ScatterSwap.UtilTest do
  use ExUnit.Case
  doctest ScatterSwap.Util

  alias ScatterSwap.Util

  test "returns an empty list when attempting to rotate an empty list" do
    assert Util.rotate_list([], 0) == []
    assert Util.rotate_list([], 1) == []
    assert Util.rotate_list([], 3) == []
    assert Util.rotate_list([], 4) == []
    assert Util.rotate_list([], 5) == []
  end

  test "returns the list unmodified when the rotation value is zero" do
    assert Util.rotate_list([1,2,3,4,5], 0) == [1,2,3,4,5]
  end

  test "rotates the list by the given amount" do
    assert Util.rotate_list([1,2,3,4,5], 1) == [2,3,4,5,1]
    assert Util.rotate_list([1,2,3,4,5], 2) == [3,4,5,1,2]
    assert Util.rotate_list([1,2,3,4,5], 3) == [4,5,1,2,3]
    assert Util.rotate_list([1,2,3,4,5], 4) == [5,1,2,3,4]
  end

  test "keeps rotatating the list when the rotation value is larger than the array" do
    assert Util.rotate_list([1,2,3,4,5], 5) == [1,2,3,4,5]
    assert Util.rotate_list([1,2,3,4,5], 6) == [2,3,4,5,1]
    assert Util.rotate_list([1,2,3,4,5], 7) == [3,4,5,1,2]
    assert Util.rotate_list([1,2,3,4,5], 8) == [4,5,1,2,3]
    assert Util.rotate_list([1,2,3,4,5], 9) == [5,1,2,3,4]
  end

  test "rotates the list in the opposite direction when the rotation value is negative" do
    assert Util.rotate_list([1,2,3,4,5], -1) == [5,1,2,3,4]
    assert Util.rotate_list([1,2,3,4,5], -2) == [4,5,1,2,3]
    assert Util.rotate_list([1,2,3,4,5], -3) == [3,4,5,1,2]
    assert Util.rotate_list([1,2,3,4,5], -4) == [2,3,4,5,1]
  end

  test "builds a list of digits representing the passed integer" do
    assert Util.integer_to_padded_digits(1234567890) == [1,2,3,4,5,6,7,8,9,0]
    assert Util.integer_to_padded_digits(987)        == [0,0,0,0,0,0,0,9,8,7]
    assert Util.integer_to_padded_digits(6789, 5)    == [0,6,7,8,9]
  end

end
