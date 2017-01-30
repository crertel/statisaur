defmodule Statisaur.Mixfile do
  use Mix.Project

  def project do
    [ app: :statisaur,
      version: "0.0.1",
      elixir: "~> 1.0",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      package: package,
      docs: &docs/0,
      deps: deps,
      test_coverage: [tool: ExCoveralls],
      description: description ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    []
  end

  defp package do
    [
      contributors: ["Neeraj Tandon", "Chris Ertel"],
      licenses: ["Public Domain (unlicense)"],
      links: %{"GitHub" => "https://github.com/hawthornehaus/statisaur"}
    ]
  end
  
  defp description do
    """
    Statisaur is a simple library for doing univariate and descriptive statistics.

    It also does various tests, regressions, and models.
    """
  end

  defp deps do
    [
        {:earmark, "~> 0.1", only: :dev },
        {:ex_doc, "~> 0.6", only: :dev},
        {:excoveralls, "~> 0.6", only: :dev},
        {:inch_ex, "~> 0.2",  only: :docs}
    ]
  end

  defp docs do
    {ref, 0} = System.cmd("git", ["rev-parse", "--verify", "--quiet", "HEAD"])
    [ source_ref: ref,
     main: "overview"]
  end
end
