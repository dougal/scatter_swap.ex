defmodule ScatterSwap.Mixfile do
  use Mix.Project

  def project do
    [
      app:         :scatter_swap,
      name:        :scatter_swap,
      version:     "0.1.0",
      elixir:      "~> 1.3",
      source_url:  "https://github.com/dougal/scatter_swap.ex",
      description: "An integer hash function designed to have zero collisions, achieve avalanche, and be reversible.",
      package:     package(),
      deps:        deps(),
      docs:        docs()
   ]
  end

  def application do
    [applications: []]
  end

  defp deps do
    [
      {:credo, "~> 0.7",   only: :dev},
      {:ex_doc, "~> 0.13", only: :dev}
    ]
  end

  defp docs do
    [
      main:       "readme",
      extras:     ["README.md"]
    ]
  end

  defp package do
    [
      licenses:    ["MIT"],
      maintainers: ["Douglas F Shearer"],
      links:       %{"GitHub" => "https://github.com/dougal/scatter_swap.ex"},
      files:       ~w(mix.exs README.md CHANGELOG.md LICENCE.txt lib)
    ]
  end
end
