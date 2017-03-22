defmodule ScatterSwapTest do
  use ExUnit.Case
  doctest ScatterSwap

  test ".hash() output is always ten or less digits" do
    for x <- Enum.to_list(1..100) do
      length = x
      |> ScatterSwap.hash
      |> Integer.to_string
      |> String.length

      assert length <= 10
    end
  end

  test ".hash() output is not sequential" do
    first  = ScatterSwap.hash(1)
    second = ScatterSwap.hash(2)
    assert second != first + 1
  end

  test ".hash() output should match that of reference implementation" do
    examples = [
      {1, 4517239960},
      {2, 7023641925},
      {3, 2057964173},
      {4, 5613409027},
      {5, 0657513294},
      {6, 3217430596},
      {7, 9452013746},
      {8, 1623475690},
      {9, 6149150327},
      {10, 2056964183},
      {100, 1823475490},
      {1000, 0687213294},
      {9_999_999_999, 1662749546}
    ]

    for example <- examples do
      { original, hashed } = example
      assert ScatterSwap.hash(original) == hashed
    end
  end

  test ".hash() output, where a salt is provided, should match that of reference implementation" do
    examples = [
      {1, 4957064368},
      {2, 3704576869},
      {3, 6367684950},
      {4, 7903586164},
      {5, 6659870438},
      {6, 0047358696},
      {7, 9354067683},
      {8, 6507649382},
      {9, 9495607836},
      {10, 7903586524},
      {100, 6507646385},
      {1000, 3524576869},
      {9_999_999_999, 9631081790}
    ]

    for example <- examples do
      { original, hashed } = example
      assert ScatterSwap.hash(original, 12345) == hashed
    end
  end

  test "it should be reversible" do
    for x <- Enum.to_list(1..100) do
      hashed   = ScatterSwap.hash(x)
      unhashed = ScatterSwap.reverse_hash(hashed)
      assert unhashed == x
    end
  end

    test ".reverse_hash() output should match that of reference implementation" do
    examples = [
      {1, 1084815579},
      {2, 1084515574},
      {3, 1088815574},
      {4, 1084315574},
      {5, 1034815574},
      {6, 1064815574},
      {7, 1084815504},
      {8, 5084815574},
      {9, 1084814574},
      {10, 1084815564},
      {100, 1084815674},
      {1000, 1084812574},
      {9_999_999_999, 0393634321}
    ]

    for example <- examples do
      { original, hashed } = example
      assert ScatterSwap.reverse_hash(original) == hashed
    end
  end

  test ".reverse_hash() output, where a salt is provided, should match that of reference implementation" do
    examples = [
      {1, 4972419936},
      {2, 4978410936},
      {3, 4972412936},
      {4, 4272410936},
      {5, 4972450936},
      {6, 4902410936},
      {7, 4972110936},
      {8, 3972410936},
      {9, 4972418936},
      {10, 4952410936},
      {100, 4972430936},
      {1000, 4972410934},
      {9_999_999_999, 1725348099}
    ]

    for example <- examples do
      { original, hashed } = example
      assert ScatterSwap.reverse_hash(original, 12345) == hashed
    end
  end

end
