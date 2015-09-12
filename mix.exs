defmodule Statisaur.Mixfile do
  use Mix.Project

  def project do
    [app: :statisaur,
      version: "0.0.1",
      elixir: "~> 1.1-beta",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do: []
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    []
  end

  defp package do
    [
      contributors: ["Neeraj Tandon", "Chris Ertel"],
      licenses: ["Public Domain (unlicense)"],
      links: %{"GitHub" => "https://github.com/hawthornehaus/statisaur"}
    ]
  end
end
