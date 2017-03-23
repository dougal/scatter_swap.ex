defmodule ScatterSwap.Scatterer do
  @moduledoc """

  Functions for rearranging the order of each digit in a reversable way. Uses
  the sum of the digits in the passed list (which doesn't change regardless of
  their order) as a key to record how they were scattered.

  """
  use Bitwise

  alias ScatterSwap.Util

  @doc """

  Rearranges the digits of a list using their sum as a seed.

      iex> ScatterSwap.Scatterer.scatter([1, 2, 3, 4, 5, 6, 7, 8, 9, 0])
      [5, 4, 0, 3, 8, 7, 9, 6, 1, 2]

  Optionally takes a second argument, `spin`, which alters the arrangement of
  the returned list.

      iex> ScatterSwap.Scatterer.scatter([1, 2, 3, 4, 5, 6, 7, 8, 9, 0], 421)
      [2, 7, 6, 5, 9, 1, 0, 4, 3, 8]

  """
  def scatter(list, spin \\ 0) do
    sum_of_digits = sum_digits(list)
    rotate_by     = bxor(spin, sum_of_digits) * -1

    list
    |> Enum.reverse
    |> do_scatter(rotate_by, 9)
  end

  defp do_scatter([], _, _) do
    []
  end
  defp do_scatter(list, rotate_by, index) do
    [ digit | tail ] = Util.rotate_list(list, rotate_by)

    [ digit | do_scatter(tail, rotate_by, index - 1) ]
  end


  @doc """

  Reverses the result of `ScatterSwap.Scatterer.scatter/2`, returning the
  original list.

      iex> ScatterSwap.Scatterer.unscatter([5, 4, 0, 3, 8, 7, 9, 6, 1, 2])
      [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]

  A second argument `spin` can be used as a seed to correctly reverse the
  rearrangement.

      iex> ScatterSwap.Scatterer.unscatter([2, 7, 6, 5, 9, 1, 0, 4, 3, 8], 421)
      [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]

  """
  def unscatter(list, spin \\ 0) do
    sum_of_digits = sum_digits(list)
    rotate_by     = bxor(sum_of_digits, spin)

    list
    |> do_unscatter(rotate_by)
    |> Enum.reverse
  end

  defp do_unscatter([], _) do
    []
  end
  defp do_unscatter(list, rotate_by) do
    [ digit | tail ] = list
    output_list      = [ digit | do_unscatter(tail, rotate_by) ]
    Util.rotate_list(output_list, rotate_by)
  end

  defp sum_digits([]) do
    0
  end
  defp sum_digits([ head | tail ]) do
    head + sum_digits(tail)
  end

end
