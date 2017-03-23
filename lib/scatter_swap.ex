defmodule ScatterSwap do
  @moduledoc """

  ScatterSwap implements an integer hash function designed to have zero collisions, achieve avalanche, and be reversible.

  """

  alias ScatterSwap.Swapper
  alias ScatterSwap.Scatterer
  alias ScatterSwap.Util

  @doc """

  Hashes the passed integer, return the result as an integer.

      iex> ScatterSwap.hash(3)
      2057964173

  A second argument can be provided as a seed value to affect the hash result.

      iex> ScatterSwap.hash(3, 123)
      635149624

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

  Reverses the result of `ScatterSwap.hash/2`, returning the original integer.

      iex> ScatterSwap.reverse_hash(2057964173)
      3

  Any second argument passed to `ScatterSwap.hash/2` can also be provided as a
  second argument, to reliably return the original integer.

      iex> ScatterSwap.reverse_hash(635149624, 123)
      3

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
