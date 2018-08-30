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
      {:ok, 120}

    The factorial of 0 is 1, according to the convention for an empty product.

      iex(2)> Statisaur.Combinatorics.factorial(0)
      {:ok, 1}

    Statisaur will return an error tuple in the case of negative integers.
    iex(3)> Statisaur.Combinatorics.factorial(-5)
    {:error, "argument must be positive integer"}
  """
  @spec factorial(non_neg_integer) :: {:ok, non_neg_integer} | {:error, String.t}
  def factorial(n) when is_integer(n) and n >= 0 do
    response = do_factorial(n)
    {:ok, response}
  end

  def factorial(_term) do
    {:error, "argument must be positive integer"}
  end

  @doc """
  Same as `factorial/1` but returns the integer directly, or 
  throws `ArgumentError` if an error is returned.
  """
  @spec factorial(non_neg_integer) :: non_neg_integer | no_return
  def factorial!(n) do
    case factorial(n) do
      {:ok, integer} ->
        integer
      {:error, reason} ->
        raise ArgumentError, "#{reason}"
    end
  end

  defp do_factorial(0) do
    1
  end

  defp do_factorial(n) when is_integer(n) and n > 0  do
    Enum.reduce((1..n), 1, fn(x, acc) -> x * acc end)
  end

  @doc ~S"""
  Finds the binomial coefficient of two integers.
  The binomial coefficient (n; k) is the number of ways of picking k unordered outcomes from n \
  possibilities, also known as a combination or combinatorial number.

  ### Examples
    The number of outcomes of two from five possibilities is ten.
      iex(1)> Statisaur.Combinatorics.n_choose_k(5, 2)
      {:ok, 10}

    The number of outcomes of eight from twenty possibilities is 125970.
      iex(2)> Statisaur.Combinatorics.n_choose_k(20, 8)
      {:ok, 125970}
  """
  @spec n_choose_k(non_neg_integer, non_neg_integer) :: {:ok, non_neg_integer} | {:error, String.t}
  def n_choose_k(n, k) when (n >= k) and (k >= 0) and is_integer(n) and is_integer(k) do
    with {:ok, fact_k} <- factorial(k),
         {:ok, fallen_fact} <- falling_factorial(n, k),
         response <- div(fallen_fact, fact_k)
      do
        {:ok, response}
      else
        {:error, reason} ->
          {:error, reason}
    end
  end

  def n_choose_k(_n, _k) do
    {:error, "arguments must be positive integers"}
  end


  @doc """
  Same as `n_choose_k/1` but returns the integer directly, or 
  throws `ArgumentError` if an error is returned.
  """
  @spec n_choose_k(non_neg_integer, non_neg_integer) :: non_neg_integer  | no_return
  def n_choose_k!(n, k) do
    case n_choose_k(n, k) do
      {:ok, response} -> 
        response
      {:error, reason} ->
        raise ArgumentError, "#{reason}"
    end
  end

  @doc ~S"""
  The falling factorial, or falling sequential product, is defined as:
  `x * (x - 1) * (x - 2) * ... (x - n - 1)`

  Compare also to `rising_factorial/2`.

  ### Examples
    The falling factorial of (5, 4) would be `5 * 4 * 3 * 2`
      iex(1)> Statisaur.Combinatorics.falling_factorial(5, 4)
      {:ok, 120}

    The falling factorial of (5, 3) would be `5 * 4 * 3`
      iex(2)> Statisaur.Combinatorics.falling_factorial(5, 3)
      {:ok, 60}

    The falling factorial of (5, 2) would be `5 * 4`
      iex(3)> Statisaur.Combinatorics.falling_factorial(5, 2)
      {:ok, 20}

    With a second argument of `1`, the return value is simply the first argument
      iex(4)> Statisaur.Combinatorics.falling_factorial(5, 1)
      {:ok, 5}

    Listing the second input as `0` returns 1
      iex(5)> Statisaur.Combinatorics.falling_factorial(5, 0)
      {:ok, 1}

    The return value is `0` when the second argument is larger than the first, and
    both arguments are positive
      iex(6)> Statisaur.Combinatorics.falling_factorial(5, 7)
      {:ok, 0}
    
    When the second argument is negative, the function returns positive values between 1 and 0
      iex(7)> Statisaur.Combinatorics.falling_factorial(1, -2)
      {:ok, 0.16666666666666666}
    
    When the both arguments are negative, the function returns an error.       
  """
  @spec falling_factorial(integer, integer) :: {:ok, integer} | {:ok, float} | {:error, String.t}
  def falling_factorial(n, k) when is_integer(n) and is_integer(k) do
    response = do_falling_factorial(n,k)
    {:ok, response}
  end

  def falling_factorial(_n, _k) do
    {:error, "arguments must be integers"}
  end


  @doc """
  Same as `falling_factorial/2` but returns the response directly, or 
  throws `ArgumentError` if an error is returned.
  """
  @spec falling_factorial!(integer, integer) :: integer | float | no_return
  def falling_factorial!(n, k) do
    case falling_factorial(n, k) do
      {:ok, response} -> 
        response
      {:error, reason} -> 
        raise ArgumentError, "#{reason}"
    end
  end


  @spec do_falling_factorial(integer, integer) :: integer | float
  defp do_falling_factorial(n, 0) when is_integer(n) do
    1
  end

  defp do_falling_factorial(n, k) when is_integer(n) and is_integer(k) and k < 0 do
    m = abs(k)
    1 / do_falling_factorial((n+m), m)
  end

  defp do_falling_factorial(n, k) when is_integer(n) and is_integer(k) do
    Enum.reduce(n..(n-(k-1)), 1, fn(x, acc) -> x * acc end)
  end

  @doc ~S"""
  The rising factorial, also known as the 'rising sequential product' or 'Pochhammer polynomial',
  is defined as: `x * (x + 1) * (x + 2) ... (x + n - 1)`

  Compare also to `falling_factorial/2`.

  ### Examples
    `rising_factorial(5, 4)` is equivalent to `5 * (5 + 1) * (5 + 2) * (5 + 3)`
      iex(1)> Statisaur.Combinatorics.rising_factorial(5, 4)
      {:ok, 1680}

    The return value is always `1` when the second argument is `0`
      iex(2)> Statisaur.Combinatorics.rising_factorial(5, 0)
      {:ok, 1}
      """
  @spec rising_factorial(integer, integer) :: {:ok, integer} | {:error, String.t}
  def rising_factorial(n, k) when is_integer(n) and is_integer(k) and k < 0 do
    {:error, "bad argument in arithmetic expression"}
  end

  def rising_factorial(n, k) when is_integer(n) and is_integer(k) do
    response = do_rising_factorial(n, k)
    {:ok, response}
  end

  def rising_factorial(_n, _k) do
    {:error, "arguments must be integers"}
  end



  @doc """
  Same as `rising_factorial/2` but returns the response directly, or 
  throws `ArgumentError` if an error is returned.
  """
  @spec rising_factorial!(integer, integer) :: integer | no_return
  def rising_factorial!(n, k) do
    case rising_factorial(n, k) do
    {:ok, response} ->
      response
    {:error, reason} ->
      raise ArgumentError, "#{reason}"
    end
  end

  @spec do_rising_factorial(integer, integer) :: integer
  defp do_rising_factorial(n, 0) when is_integer(n) do
    1
  end

  defp do_rising_factorial(n, k) when is_integer(n) and is_integer(k) do
    Enum.reduce(n..(n+(k-1)), 1, fn(x, acc) -> x * acc end)
  end
end