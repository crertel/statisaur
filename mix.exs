defmodule Statisaur.Mixfile do
  use Mix.Project

  def project do
    [ app: :statisaur,
      version: "0.0.1",
      elixir: "~> 1.0",
      elixirc_paths: elixirc_paths(Mix.env),
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      package: package(),
      docs: &docs/0,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      description: description() ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/helpers"]
  defp elixirc_paths(_),     do: ["lib" ]


  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application() do
    []
  end

  defp package() do
    [
      contributors: ["Neeraj Tandon", "Chris Ertel"],
      licenses: ["Public Domain (unlicense)"],
      links: %{"GitHub" => "https://github.com/hawthornehaus/statisaur"}
    ]
  end

  defp description() do
    """
    Statisaur is a simple library for doing univariate and descriptive statistics.

    It also does various tests, regressions, and models.
    """
  end

  defp deps() do
    [
        {:earmark, "~> 1.3.1", only: :dev },
        {:ex_doc, "~> 0.19.3", only: [:dev, :docs]},
        {:excoveralls, "~> 0.10.0", only: [:test, :dev] },
        {:inch_ex, "~> 2.0.0",  only: :docs},
        {:dialyxir, "~> 1.0.0-rc.6", only: [:dev], runtime: false}
    ]
  end

  defp docs() do
    {ref, 0} = System.cmd("git", ["rev-parse", "--verify", "--quiet", "HEAD"])
    [ source_ref: ref,
     main: "overview"]
  end
end
