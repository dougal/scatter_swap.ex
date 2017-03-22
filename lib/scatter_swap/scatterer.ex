defmodule ScatterSwap.Scatterer do
  use Bitwise

  alias ScatterSwap.Util

  # Rearrange the order of each digit in a reversable way by using the
  # sum of the digits (which doesn't change regardless of order)
  # as a key to record how they were scattered
  def scatter(list, spin \\ 0) do
    sum_of_digits = sum_digits(list)
    { _, output_list } = Enum.reduce(Enum.to_list(0..9), {list, []}, fn(_, {list, output_list}) ->
      spun_list = Util.rotate_list(list, bxor(spin, sum_of_digits))
      { popped_digit, list } = List.pop_at(spun_list, -1)
      { list, output_list ++ [popped_digit] }
    end)

    output_list
  end

  def unscatter(list, spin \\ 0) do
    sum_of_digits = sum_digits(list)
    { _, output_list } = Enum.reduce(Enum.to_list(0..9), {list, []}, fn(_, {list, output_list}) ->
      { popped_digit, list } = List.pop_at(list, -1)
      output_list = output_list ++ [popped_digit]
      spun_list = Util.rotate_list(output_list, bxor(sum_of_digits, spin) * -1)
      { list, spun_list }
    end)

    output_list
  end

  defp sum_digits(list) do
    Enum.reduce(list, 0, fn(digit, accum) -> accum + digit end)
  end

end
