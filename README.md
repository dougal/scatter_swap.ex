# ScatterSwap

Elixir implementation of Nathan and David Amick's [Scatter Swap](https://github.com/namick/scatter_swap).

ScatterSwap implements an integer hash function designed to have zero collisions, achieve avalanche, and be reversible.

The goal is to transform an integer into another random looking integer and then reliably tranform it back.

It will turn the number `3` into `2356513904`, and it can then reliably reverse that scrambled `2356513904` number back into `3`

We also want sequential integers to become non-sequential.

So for example it will turn `7001`, `7002`, `7003` into `5270192353`, `7107163820`, `3296163828`, and back again.

Please note, this is not encryption or related to security in any way. It lightly obfuscates an integer in a reversable way.


## Hashing

    iex> ScatterSwap.hash(3)
    2057964173
    iex> ScatterSwap.hash(7001)
    2037964193
    iex> ScatterSwap.hash(7002)
    3613429027
    iex> ScatterSwap.hash(7003)
    677313294


## Reverse Hashing

    iex> ScatterSwap.reverse_hash(2037964193)
    7001
    iex> ScatterSwap.reverse_hash(3613429027)
    7002
    iex> ScatterSwap.reverse_hash(677313294)
    7003


## Spin

A second argument `spin` can be passed to each of `ScatterSwap.hash/2` or `ScatterSwap.reverse_hash/2`, as a seed to alter the hashing process.

    iex(8)> ScatterSwap.hash(123)
    2059944173
    iex(9)> ScatterSwap.hash(123, 1)
    3480094612
    iex(10)> ScatterSwap.hash(123, 2)
    6571025309
    iex(11)> ScatterSwap.hash(123, 728283)
    9180174562

    iex> ScatterSwap.reverse_hash(2059944173)
    123
    iex> ScatterSwap.reverse_hash(3480094612, 1)
    123
    iex> ScatterSwap.reverse_hash(6571025309, 2)
    123
    iex> ScatterSwap.reverse_hash(9180174562, 728283)
    123


## Limitations

This library is built for integeres which can be expressed in 10 digits. The largest number it can deal with is 10 Billion - 1:

    9999999999


## Differences from the Ruby Implementation

Whereas the Ruby version returns zero-padded strings, this implementation returns integers.


## How it Works

Please see the README for Nathan and David Amick's Ruby implementation of [Scatter Swap](https://github.com/namick/scatter_swap) for more information on the hashing algorithm itself.


## Contributing

Source repository is at [https://github.com/dougal/scatter_swap.ex](https://github.com/dougal/scatter_swap.ex), please file issues and pull requests there.


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed by adding `scatter_swap` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:scatter_swap, "~> 0.1.0"}]
end
```

Documentation can be generated with
[ExDoc](https://github.com/elixir-lang/ex_doc) and published on
[HexDocs](https://hexdocs.pm). Once published, the docs can be found at
[https://hexdocs.pm/scatter_swap](https://hexdocs.pm/scatter_swap).

