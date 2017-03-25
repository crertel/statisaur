defmodule Statisaur.Bivariate do
  @moduledoc """
  Contains functions for computing bivariate statistics.
  """

  @doc """
  Finds the covariance between two lists

  ### Examples
  iex>Statisaur.Bivariate.covariance([1,3,5,7,9],[10,20,30,40,50])
  50.0

  """
  def covariance(list1, list2) when is_list(list1) and is_list(list2) and length(list1) == length(list2) do
    n = length(list1)
    mu_x = Statisaur.mean(list1)
    mu_y = Statisaur.mean(list2)
    numerator = Enum.zip(list1, list2) |>
    Enum.map( fn {x, y} -> (x - mu_x) * (y + mu_y) end ) |> 
    Enum.sum()
    numerator/(n - 1)
  end

  @doc """
  Finds the Pearson correlation of two lists, provided they are of equal length.

  iex> Statisaur.pearson_correlation( [1,2,3,4], [3,4,5,6] )
  1

  iex> Statisaur.pearson_correlation( [4,3,2,1], [3,4,5,6] )
  -1

  iex> Statisaur.pearson_correlation( [1,2,-1,-2], [1,2,3,4] )  
  -0.8485281
  """
  def pearson_correlation(list1, list2) when is_list(list1) and is_list(list2) and length(list1) == length(list2) do
    covXY = covariance(list1, list2)
    sigmaX = Statisaur.stddev(list1)
    sigmaY = Statisaur.stddev(list2)

    # check that lists are nonzero

    # check that the std. deviations are nonzero

    covXY / (sigmaX * sigmaY)
  end
end
