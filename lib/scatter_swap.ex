# https://github.com/namick/scatter_swap/blob/master/lib/scatter_swap/hasher.rb

defmodule ScatterSwap do
  @moduledoc """
  TODO
  """

  alias ScatterSwap.Swapper
  alias ScatterSwap.Scatterer
  alias ScatterSwap.Util

  @doc """
  TODO.
  """
  def hash(original_integer, spin \\ 0) do
    output_string = original_integer
                    |> Util.integer_to_padded_digits
                    |> Swapper.swap(spin)
                    |> Scatterer.scatter(spin)
                    |> Enum.join

    {int, _} = Integer.parse(output_string)
    int
  end

  @doc """
  TODO.
  """
  def reverse_hash(original_integer, spin \\ 0) do
    output_string = original_integer
                    |> Util.integer_to_padded_digits
                    |> Scatterer.unscatter(spin)
                    |> Swapper.unswap(spin)
                    |> Enum.join

    {int, _} = Integer.parse(output_string)
    int
  end

end
