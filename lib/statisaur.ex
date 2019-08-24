defmodule Statisaur do
  @moduledoc """
  Statisaur - Statistics functions
  This module currently contains the functions for
  summary statistics.
  """

  @doc """
  Calculate the smallest value from a list of numbers.

  ### Examples
    iex> Statisaur.min([1,2,3])
    1

    iex> Statisaur.min([5,0.5,2,3])
    0.5

    iex> Statisaur.min([])
    ** (ArgumentError) argument must be non-zero length list
  """
  def min(list) when is_list(list) and length(list) > 1 do
    Enum.min(list)
  end

  def min(_list), do: raise(ArgumentError, "argument must be non-zero length list")

  @doc """
  Calculate the largest value from a list of numbers.
  ### Examples
    iex> Statisaur.max([1,2,3])
    3

    iex> Statisaur.max([5.1,0.5,2,3])
    5.1

    iex> Statisaur.max([])
    ** (ArgumentError) argument must be non-zero length list

  """
  def max(list) when is_list(list) and length(list) > 1 do
    Enum.max(list)
  end

  def max(_list), do: raise(ArgumentError, "argument must be non-zero length list")

  @doc """
  Calculate the sum from a list of numbers

  ### Examples
    iex> Statisaur.sum([1,3,5,7,9])
    25

    iex> Statisaur.sum([1,1])
    2

    iex> Statisaur.sum([0.5,0.5])
    1.0

    iex> Statisaur.sum([])
    ** (ArgumentError) argument must be non-zero length list
  """
  def sum(list) when is_list(list) and length(list) > 0, do: Enum.sum(list)
  def sum(_list), do: raise(ArgumentError, "argument must be non-zero length list")

  @doc """
  Calculate the mean from a list of numbers

  ### Examples
    iex> Statisaur.mean([1,3,5,7,9])
    5.0

    iex> Statisaur.mean([0.1,0.2,0.6])
    0.3

    iex> Statisaur.mean([])
    ** (ArgumentError) argument must be non-zero length list
  """
  def mean(list) when is_list(list) and length(list) > 1, do: sum(list) / length(list)
  def mean(_list), do: raise(ArgumentError, "argument must be non-zero length list")

  @doc """
  Calculate the median from a list of numbers

  ### Examples
    iex> Statisaur.median([1,3,5,7,9])
    5

    iex> Statisaur.median([1,1])
    1.0

    iex> Statisaur.median([0.1,0.4,0.6,0.9])
    0.5

    iex> Statisaur.median([])
    ** (ArgumentError) argument must be non-zero length list
  """
  def median([]), do: raise(ArgumentError, "argument must be non-zero length list")

  def median(list) when is_list(list) do
    n = length(list)
    sorted = list |> Enum.sort()
    pivot = round(n / 2)

    case rem(n, 2) do
      0 ->
        a = sorted |> Enum.at(pivot)
        b = sorted |> Enum.at(pivot - 1)
        # median for an even-sized set is the mean of the middle numbers
        (a + b) / 2

      # this seems weird, but Float floor yields float not int :()
      _ ->
        sorted |> Enum.at(round(Float.floor(n / 2)))
    end
  end

  @doc """
  Calculate the frequency counts of distinct elements.

  ### Examples
    iex> Statisaur.frequencies([1])
    [{1,1}]

    iex> Statisaur.frequencies([1,2,2,3])
    [{1,1},{2,2},{3,1}]

    iex> Statisaur.frequencies([])
    ** (ArgumentError) argument must be non-zero length list

  """
  def frequencies(list) when is_list(list) and length(list) > 0 do
    sorted = list |> Enum.sort()
    vals = sorted |> Enum.uniq()
    freqs = vals |> Enum.map(fn v -> Enum.count(sorted, fn x -> x == v end) end)
    Enum.zip(vals, freqs)
  end

  def frequencies(_list), do: raise(ArgumentError, "argument must be non-zero length list")

  @doc """
  Calculate most commonly occurring number from a list of numbers

  ### Examples
    iex> Statisaur.mode([1,1,2,3])
    [1]

    iex> Statisaur.mode([1.0,2.0,2.0,3.0,3.0])
    [2.0,3.0]

    iex> Statisaur.mode([])
    ** (ArgumentError) argument must be non-zero length list
  """
  def mode([]), do: raise(ArgumentError, "argument must be non-zero length list")

  def mode(list) when is_list(list) do
    freqs = frequencies(list)
    sorted_freqs = freqs |> Enum.sort_by(fn {_, f} -> f end, &>=/2)
    {_, mode_guess} = sorted_freqs |> Enum.at(0)
    sorted_freqs |> Enum.filter(fn {_, f} -> f >= mode_guess end) |> Enum.map(fn {v, _} -> v end)
  end

  @doc """
  Create an element-wise kth-power of a list compared to a reference value.

  ### Examples
    iex> Statisaur.powered_error( [1,2,3], 2, 1)
    [-1.0,0.0,1.0]

    iex> Statisaur.powered_error([],2,1)
    ** (ArgumentError) must be supplied a non-zero length list
  """
  def powered_error([], _, _), do: raise(ArgumentError, "must be supplied a non-zero length list")

  def powered_error(list, reference, k) when is_list(list) and length(list) > 1 do
    list |> Enum.map(fn x -> :math.pow(x - reference, k) end)
  end

  @doc """
  Calculate the variance from a list of numbers

  ### Examples
    iex>Statisaur.variance([1,3,5,7,9])
    10.0

    iex>Statisaur.variance([0.1,0.2,0.6])
    0.06999999999999999

    iex>Statisaur.variance([])
    ** (ArgumentError) argument must be non-zero length list
  """
  def variance([]), do: raise(ArgumentError, "argument must be non-zero length list")

  def variance(list) when is_list(list) and length(list) > 1 do
    mu = mean(list)
    diffmeans = list |> powered_error(mu, 2) |> Enum.sum()
    df = length(list) - 1
    diffmeans / df
  end

  @doc """
  Calculates the standard deviation from a list of numbers.

  ### Examples
    iex> Statisaur.stddev([1,3,5,7,9]) |> Float.round(6)
    3.162278

    iex> Statisaur.stddev([0.1,0.2,0.6]) |> Float.round(6)
    0.264575

    iex> Statisaur.stddev([])
    ** (ArgumentError) argument must be non-zero length list
  """
  def stddev(list) when is_list(list) and length(list) > 1 do
    list |> variance |> :math.sqrt()
  end

  def stddev(_list), do: raise(ArgumentError, "argument must be non-zero length list")

  @doc """
  Calculate the kth moment with respect to the origin of a list of numbers.

  ###Examples
    iex> Statisaur.raw_moment([1,2,3,4],1)
    2.5

    iex> Statisaur.raw_moment([1,2,3,4],2)
    7.5

    iex> Statisaur.raw_moment([1,2,3,4],3)
    25.0

    iex> Statisaur.raw_moment([1,2,3,4],4)
    88.5

    iex> Statisaur.raw_moment([],4)
    ** (ArgumentError) must be supplied a non-zero length list
  """
  def raw_moment([], _), do: raise(ArgumentError, "must be supplied a non-zero length list")

  def raw_moment(list, k) when is_list(list) and length(list) > 1 do
    count = length(list)
    (list |> Enum.map(fn x -> :math.pow(x, k) end) |> Enum.sum()) / count
  end

  @doc """
  Calculate the kth central moment of a list of numbers.

  ###Examples
    iex> Statisaur.central_moment([1,2,3,4],1)
    0.0

    iex> Statisaur.central_moment([1,2,3,4],2)
    1.25

    iex> Statisaur.central_moment([1,2,3,4],3)
    0.0

    iex> Statisaur.central_moment([1,2,3,4],4) |> Float.round(4)
    2.5625

    iex> Statisaur.central_moment([], 5)
    ** (ArgumentError) must be supplied a non-zero length list
  """
  def central_moment([], _), do: raise(ArgumentError, "must be supplied a non-zero length list")

  def central_moment(list, k) when is_list(list) and length(list) > 1 do
    count = length(list)
    mu = mean(list)
    (list |> powered_error(mu, k) |> Enum.sum()) / count
  end

  @doc """
  Calculate the kth standardized moment of a list of numbers. See [here](https://en.wikipedia.org/wiki/Standardized_moment) for definition.

  ###Examples
    iex> Statisaur.standardized_moment([1,2,3,4],1)
    0.0

    iex> Statisaur.standardized_moment([1,2,3,4],2)
    1.0

    iex> Statisaur.standardized_moment([1,2,3,4],3)
    0.0

    iex> Statisaur.standardized_moment([1,2,3,4],4)
    1.64

    iex> Statisaur.standardized_moment([], 4)
    ** (ArgumentError) must be supplied a non-zero length list
  """
  def standardized_moment([], _),
    do: raise(ArgumentError, "must be supplied a non-zero length list")

  def standardized_moment(list, k) when is_list(list) and length(list) > 1 do
    m1 = raw_moment(list, 1)
    num = (powered_error(list, m1, k) |> Enum.sum()) / length(list)
    denom = :math.pow((powered_error(list, m1, 2) |> Enum.sum()) / length(list), k / 2)
    num / denom
  end

  @doc """
  Calculates the skewness (3rd standardized moment) of a list of numbers.

  ###Examples
    iex> Statisaur.skewness([1,2,3,4])
    0.0

    iex> Statisaur.skewness([])
    ** (ArgumentError) argument must be non-zero length list
  """
  def skewness([]), do: raise(ArgumentError, "argument must be non-zero length list")

  def skewness(list) when is_list(list) and length(list) > 1 do
    standardized_moment(list, 3)
  end

  @doc """
  Calculates the kurtosis (4th standardized moment) of a list of numbers.

  ###Examples
    iex> Statisaur.kurtosis([1,2,3,4])
    1.64

    iex> Statisaur.kurtosis([])
    ** (ArgumentError) argument must be non-zero length list
  """
  def kurtosis([]), do: raise(ArgumentError, "argument must be non-zero length list")

  def kurtosis(list) when is_list(list) and length(list) > 1 do
    standardized_moment(list, 4)
  end

  @doc """
  Calculates the coefficient of variation for a list of numbers.

  ###Examples
    iex> Statisaur.coefficient_of_variation([1,2,3,4]) |> Float.round(4)
    0.5164

    iex> Statisaur.coefficient_of_variation([])
    ** (ArgumentError) argument must be non-zero length list
  """
  def coefficient_of_variation([]),
    do: raise(ArgumentError, "argument must be non-zero length list")

  def coefficient_of_variation(list) when is_list(list) and length(list) > 1 do
    stddev(list) / mean(list)
  end
end
