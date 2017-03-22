defmodule ScatterSwap.Scatterer do
  use Bitwise

  alias ScatterSwap.Util

  # Rearrange the order of each digit in a reversable way by using the
  # sum of the digits (which doesn't change regardless of order)
  # as a key to record how they were scattered
  def scatter(list, spin \\ 0) do
    sum_of_digits = sum_digits(list)
    rotate_by     = bxor(spin, sum_of_digits)

    do_scatter(list, rotate_by, 0)
  end

  defp do_scatter([], _, _) do
    []
  end
  defp do_scatter(list, rotate_by, index) do
    spun_list = Util.rotate_list(list, rotate_by)
    { popped_digit, tail } = List.pop_at(spun_list, -1)
    [popped_digit] ++ do_scatter(tail, rotate_by, index + 1)
  end

  def unscatter(list, spin \\ 0) do
    sum_of_digits = sum_digits(list)
    rotate_by     = bxor(sum_of_digits, spin) * -1

    { _, output_list } = Enum.reduce(Enum.to_list(0..9), {list, []}, fn(_, {list, output_list}) ->
      { popped_digit, list } = List.pop_at(list, -1)
      output_list = output_list ++ [popped_digit]
      spun_list = Util.rotate_list(output_list, rotate_by)
      { list, spun_list }
    end)

    output_list
  end

  defp sum_digits([]) do
    0
  end
  defp sum_digits([ head | tail ]) do
    head + sum_digits(tail)
  end

end
