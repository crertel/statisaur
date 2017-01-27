defmodule Statisaur.Combinatorics do
  @moduledoc """
  Contains functions for analyzing finite descrete structures.
  """
  @doc ~S"""
  Finds the factorial of a given non-negative integer.

  The factorial of a non-negative integer n, is the product of all positive integers less than or equal to n.

  The value of factorial(0) is 1, according to the convention for an empty product.
  
  ### Example
    The factorial of 5 is (5 * 4 * 3 * 2 * 1), or 120.

      iex(1)> Statisaur.Combinatorics.factorial(5)
      120

    The factorial of 0 is 1, according to the convention for an empty product.

      iex(2)> Statisaur.Combinatorics.factorial(0)
      1

    Statisaur will raise an error in the case of negative integers.
      iex(3)> Statisaur.Combinatorics.factorial(-5)
      ** (ArgumentError) argument must be positive integer
  """
  @spec factorial(integer) :: integer
  def factorial(0) do
    1
  end

  def factorial(n) when is_integer(n) and n > 0  do
    Enum.reduce((1..n), 1, fn(x, acc) -> x * acc end)
  end

  def factorial(_term) do
    raise ArgumentError, "argument must be positive integer"
  end

  @doc ~S"""
  Finds the binomial coefficient of two integers.
  The binomial coefficient (n; k) is the number of ways of picking k unordered outcomes from n \
  possibilities, also known as a combination or combinatorial number.

  ### Examples
    The number of outcomes of two from five possibilities is ten.
      iex(1)> Statisaur.Combinatorics.combinations(5, 2)
      10

    The number of outcomes of eight from twenty possibilities is 125970.
      iex(2)> Statisaur.Combinatorics.combinations(20, 8)
      125970
  """
  @spec combinations(integer, integer) :: integer
  def combinations(n, k) when (n >= k) and (k >= 0) and is_integer(n) and is_integer(k) do
    div(falling_factorial(n, k), factorial(k))
  end

  def combinations(_n, _k) do
    raise ArgumentError, "arguments must be positive integers"
  end

  defp falling_factorial(n, k) do
    Enum.reduce(n..(n-(k-1)), 1, fn(x, acc) -> x * acc end)
  end

end