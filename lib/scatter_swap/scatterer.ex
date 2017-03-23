defmodule ScatterSwap.Scatterer do
  use Bitwise

  alias ScatterSwap.Util

  # Rearrange the order of each digit in a reversable way by using the
  # sum of the digits (which doesn't change regardless of order)
  # as a key to record how they were scattered
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
