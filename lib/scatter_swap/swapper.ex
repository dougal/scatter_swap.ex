defmodule ScatterSwap.Swapper do
  @moduledoc """

  Functions to reversibly swap each of the digits in a list for another using a generated
  map.

  """

  use Bitwise

  alias ScatterSwap.Util

  @initial_swapper_map_list Enum.to_list(9..0)

  @doc """

  Using a unique map for each of the digits in `list`, which is swapped out for
  another number.

      iex> ScatterSwap.Swapper.swap([1, 2, 3, 4, 5, 6, 7, 8, 9, 0])
      [0, 5, 5, 0, 2, 7, 3, 8, 4, 8]

  A second argument `spin` can be used as a seed to alter the resulting swaps.

      iex> ScatterSwap.Swapper.swap([1, 2, 3, 4, 5, 6, 7, 8, 9, 0], 711)
      [8, 1, 5, 3, 8, 1, 8, 9, 9, 7]

  """
  def swap(list, spin \\ 0) do
    do_swap(list, 0, spin)
  end

  defp do_swap([], _, _) do
    []
  end
  defp do_swap(list, index, spin) do
    [ digit | tail ] = list
    map              = swapper_map(index, spin)

    [ Enum.at(map, digit) | do_swap(tail, index + 1, spin) ]
  end


  @doc """

  Reverses the result of `ScatterSwap.Swapper.swap/2`, returning the original
  list.

      iex> ScatterSwap.Swapper.unswap([0, 5, 5, 0, 2, 7, 3, 8, 4, 8])
      [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]

  A second argument `spin` can be used as a seed to correctly reverse the
  swaps.

      iex> ScatterSwap.Swapper.unswap([8, 1, 5, 3, 8, 1, 8, 9, 9, 7], 711)
      [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]

  """
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

  # Generate a unique map given a `digit` and a `spin`.
  defp swapper_map(digit, spin) do
    do_swapper_map(digit, spin, @initial_swapper_map_list, 0)
  end

  defp do_swapper_map(_, _, [], _) do
    []
  end
  defp do_swapper_map(digit, spin, list, index) do
    rotate_by               = -1 * bxor(digit + index, spin)
    [ popped_digit | tail ] = Util.rotate_list(list, rotate_by)
    [ popped_digit | do_swapper_map(digit, spin, tail, index + 1) ]
  end

end
