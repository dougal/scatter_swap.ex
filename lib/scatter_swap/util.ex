defmodule ScatterSwap.Util do
  @moduledoc """

  Utility functions used to implement `ScatterSwap`.

  """

  @doc """

  Returns a new list by rotating `list` so that the element at index
  `rotate_by` is the first element of the new list.

      iex> ScatterSwap.Util.rotate_list([1, 2, 3, 4, 5], 1)
      [2, 3, 4, 5, 1]
      iex> ScatterSwap.Util.rotate_list([1, 2, 3, 4, 5], 2)
      [3, 4, 5, 1, 2]

  Negative `rotate_by` rotates `list` in the opposite direction.

      iex> ScatterSwap.Util.rotate_list([1, 2, 3, 4, 5], -1)
      [5, 1, 2, 3, 4]
      iex> ScatterSwap.Util.rotate_list([1, 2, 3, 4, 5], -2)
      [4, 5, 1, 2, 3]

  """
  def rotate_list([], _) do
    []
  end
  def rotate_list(list, 0) do
    list
  end
  def rotate_list([x], _) do
    [x]
  end
  def rotate_list(list, rotate_by) do
    do_rotate_list(list, rotate_by)
  end

  defp do_rotate_list(list, rotate_by) do
    split_position     = rem(rotate_by, length(list))
    { prefix, suffix } = Enum.split(list, split_position)

    suffix ++ prefix
  end

  @doc """

  Returns `integer` as a list of single digits, padded with 0s to `target_len`.
  Default `target_len` is 10.

      iex> ScatterSwap.Util.integer_to_padded_digits(12345)
      [0, 0, 0, 0, 0, 1, 2, 3, 4, 5]
      iex> ScatterSwap.Util.integer_to_padded_digits(12345, 8)
      [0, 0, 0, 1, 2, 3, 4, 5]

  If `target_len` is smaller than or equal to the length of the passed integer,
  the returned list is the same as the length of the integer.

      iex> ScatterSwap.Util.integer_to_padded_digits(12345, 3)
      [1, 2, 3, 4, 5]

  """
  def integer_to_padded_digits(integer, target_len \\ 10) do
    tail_digits    = Integer.digits(integer)

    zero_pad(tail_digits, target_len)
  end

  defp zero_pad(tail_digits, target_len) when length(tail_digits) >= target_len do
    tail_digits
  end
  defp zero_pad(tail_digits, target_len) do
    [0 | zero_pad(tail_digits, target_len - 1)]
  end

end
