defmodule ScatterSwap.SwapperTest do
  use ExUnit.Case
  doctest ScatterSwap.Swapper

  alias ScatterSwap.Swapper

  test "swap() uses a unique map to swap out one number for another" do
    assert Swapper.swap([0, 0, 0, 0, 0, 0, 0, 0, 0, 1]) == [9, 0, 1, 2, 3, 4, 5, 6, 7, 9]
    assert Swapper.swap([0, 0, 0, 0, 0, 0, 0, 0, 0, 2]) == [9, 0, 1, 2, 3, 4, 5, 6, 7, 2]
  end

  test "swap() with a salt scrambles the results" do
    assert Swapper.swap([0, 0, 0, 0, 0, 0, 0, 0, 0, 1], 14) == [3, 4, 1, 2, 9, 0, 7, 8, 5, 0]
    assert Swapper.swap([0, 0, 0, 0, 0, 0, 0, 0, 0, 2], 26) == [5, 6, 3, 4, 9, 0, 7, 8, 7, 6]
  end

  test "unswap() uses the map to return the original list" do
    assert Swapper.unswap([9, 0, 1, 2, 3, 4, 5, 6, 7, 9]) == [0, 0, 0, 0, 0, 0, 0, 0, 0, 1]
    assert Swapper.unswap([9, 0, 1, 2, 3, 4, 5, 6, 7, 2]) == [0, 0, 0, 0, 0, 0, 0, 0, 0, 2]
  end

  test "unswap() with a salt returns the original list" do
    assert Swapper.unswap([3, 4, 1, 2, 9, 0, 7, 8, 5, 0], 14) == [0, 0, 0, 0, 0, 0, 0, 0, 0, 1]
    assert Swapper.unswap([5, 6, 3, 4, 9, 0, 7, 8, 7, 6], 26) == [0, 0, 0, 0, 0, 0, 0, 0, 0, 2]
  end

  test "unswap() reverses the actions of swap()" do
    original = [0, 0, 0, 0, 0, 0, 0, 0, 0, 1]
    output = original
             |> Swapper.swap(84)
             |> Swapper.unswap(84)

    assert output == original
  end

end
