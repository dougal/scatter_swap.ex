defmodule ScatterSwap.Util do

  # Returns a new list by rotating `list` so that the element at `rotate_by` is
  # the first element of the new list.
  def rotate_list([], _) do
    []
  end
  def rotate_list(list, 0) do
    list
  end
  def rotate_list(list, rotate_by) when rotate_by < 0 do
    do_rotate_list(list, length(list) + rotate_by)
  end
  def rotate_list(list, rotate_by) do
    do_rotate_list(list, rotate_by)
  end

  defp do_rotate_list(list, rotate_by) do
    split_position     = rem(rotate_by, length(list))
    { prefix, suffix } = Enum.split(list, split_position)

    suffix ++ prefix
  end

  # Returns `integer` as a list of digits, padded with 0s to `target_len`. Default 10.
  def integer_to_padded_digits(integer, target_len \\ 10) do
    tail_digits    = Integer.digits(integer)
    missing_digits = target_len - length(tail_digits)

    list_of_zeros(missing_digits) ++ tail_digits
  end

  defp list_of_zeros(len) when len < 0 do
    []
  end
  defp list_of_zeros(0) do
    []
  end
  defp list_of_zeros(len) do
    [0 | list_of_zeros(len - 1)]
  end

end
