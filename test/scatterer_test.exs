defmodule ScatterSwap.ScattererTest do
  use ExUnit.Case
  doctest ScatterSwap.Scatterer

  alias ScatterSwap.Scatterer

  test "scatter() rearranges the digits" do
    assert Scatterer.scatter([0, 0, 0, 0, 0, 0, 0, 0, 0, 1]) == [0, 0, 0, 0, 0, 0, 0, 0, 0, 1]
    assert Scatterer.scatter([0, 0, 0, 0, 0, 0, 0, 0, 0, 2]) == [0, 0, 0, 0, 2, 0, 0, 0, 0, 0]
  end

  test "scatter() with a salt scrambles the results" do
    assert Scatterer.scatter([0, 0, 0, 0, 0, 0, 0, 0, 0, 1], 14) == [0, 0, 0, 1, 0, 0, 0, 0, 0, 0]
    assert Scatterer.scatter([0, 0, 0, 0, 0, 0, 0, 0, 0, 2], 26) == [0, 2, 0, 0, 0, 0, 0, 0, 0, 0]
  end

  test "unscatter() uses the sum of the digits to return the original list" do
    assert Scatterer.unscatter([0, 0, 0, 0, 0, 0, 0, 0, 0, 1]) == [0, 0, 0, 0, 0, 0, 0, 0, 0, 1]
    assert Scatterer.unscatter([0, 0, 0, 0, 2, 0, 0, 0, 0, 0]) == [0, 0, 0, 0, 0, 0, 0, 0, 0, 2]
  end

  test "unscatter() with a salt returns the original list" do
    assert Scatterer.unscatter([0, 0, 0, 1, 0, 0, 0, 0, 0, 0], 14) == [0, 0, 0, 0, 0, 0, 0, 0, 0, 1]
    assert Scatterer.unscatter([0, 2, 0, 0, 0, 0, 0, 0, 0, 0], 26) == [0, 0, 0, 0, 0, 0, 0, 0, 0, 2]
  end

  test "unscatter() reverses the actions of scatter()" do
    original = [0, 0, 0, 0, 0, 0, 0, 0, 0, 1]
    output = original
             |> Scatterer.scatter(84)
             |> Scatterer.unscatter(84)

    assert output == original
  end

end
