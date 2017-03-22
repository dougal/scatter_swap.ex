defmodule ScatterSwap.Swapper do
  use Bitwise

  alias ScatterSwap.Util

  # Using a unique map for each of the digits in the list.
  # we swap out one number for another
  def swap(list, spin \\ 0) do
    do_swap(list, 0, spin)
  end

  defp do_swap([], _, _) do
    []
  end
  defp do_swap(list, index, spin) do
    [ digit | tail ] = list
    map              = swapper_map(index, spin)

    [Enum.at(map, digit) | do_swap(tail, index + 1, spin)]
  end

  def unswap(list, spin \\ 0) do
    do_unswap(list, 0, spin)
  end

  defp do_unswap([], _, _) do
    []
  end
  defp do_unswap(list, index, spin) do
    [ digit | tail ] = list
    map              = swapper_map(index, spin)

    [Enum.find_index(map, fn(el) -> el == digit end) | do_unswap(tail, index + 1, spin)]
  end

  # We want a unique map for each place in the original number
  defp swapper_map(seed, spin) do
    input_list = Enum.to_list(9..0)

    do_swapper_map(seed, spin, input_list, 0)
  end

  defp do_swapper_map(_, _, [], _) do
    []
  end
  defp do_swapper_map(seed, spin, list, index) do
    rotate_by               = -1 * bxor(seed + index, spin)
    [ popped_digit | tail ] = Util.rotate_list(list, rotate_by)
    [ popped_digit | do_swapper_map(seed, spin, tail, index + 1) ]
  end

end
