defmodule ScatterSwap.Swapper do
  use Bitwise

  alias ScatterSwap.Util

  # Using a unique map for each of the digits in the list.
  # we swap out one number for another
  def swap(list, spin \\ 0) do
    do_swap(list, 0, spin)
  end

  defp do_swap(list, index, _) when length(list) == index do
    []
  end
  defp do_swap(list, index, spin) do
    digit = Enum.at(list, index)
    map   = swapper_map(index, spin)

    [Enum.at(map, digit) | do_swap(list, index + 1, spin)]
  end

  def unswap(list, spin \\ 0) do
    list
    |> Enum.with_index
    |> Enum.map(fn({digit, index}) -> index |> swapper_map(spin) |> Enum.find_index(fn(el) -> el == digit end) end)
  end

  # We want a unique map for each place in the original number
  defp swapper_map(index, spin) do
    input_list = Enum.to_list(0..9)

    # We want to pop a value from the input list on each iteration, maintining
    # it's rotation also. Use accumulator on reduce() to store the remaining
    # input plus collected output.
    { _, output_list } = Enum.reduce(input_list, {input_list, []}, fn(int, {list, output_list}) ->
      rotate_by = bxor(index + int, spin)
      spun_list = Util.rotate_list(list, rotate_by)
      { popped_digit, list } = List.pop_at(spun_list, -1)
      { list, output_list ++ [popped_digit] }
    end)

    output_list
  end

end
