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
	Calculates the coefficients of regression.

	B1 = sum((x(i) - mean(x)) * (y(i) - mean(y))) / sum( (x(i) - mean(x))^2 )
	B0 = mean(y) - B1 * mean(x)
	###Examples
	iex>Statisaur.Bivariate.simple_linear_regression([118,484,664,1004,1231,1372],[30,58,87,115,120,142])
	{2, {21.244330227661493, 0.08711964265011925}}
	"""
	def simple_linear_regression(list1,list2) do
		m1 = Statisaur.mean(list1)
		m2 = Statisaur.mean(list2)
		b1_num_p1 = Statisaur.powered_error(list1, m1, 1)
		b1_num_p2 = Statisaur.powered_error(list2, m2, 1)
		b1_num = Statisaur.sum(Enum.map(Enum.zip(b1_num_p1, b1_num_p2), fn({x, y})-> x*y end))
		b1_denom = Statisaur.sum( Statisaur.powered_error(list1, m1, 2))
		b1 = b1_num/b1_denom
		b0 = Statisaur.mean(list2) - b1 * Statisaur.mean(list1)
		b1 = b1
		{2, {b0, b1}}
	end

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

  ### Examples
  iex> Statisaur.Bivariate.pearson_correlation( [1,2,3,4], [3,4,5,6] ) |> Float.round(4)
  1.0000

  iex> Statisaur.Bivariate.pearson_correlation( [4,3,2,1], [3,4,5,6] ) |> Float.round(4)
  -1.0000

  iex> Statisaur.Bivariate.pearson_correlation( [1,2,-1,-2], [1,2,3,4] )  |> Float.round(4)
  -0.8485

  iex> Statisaur.Bivariate.pearson_correlation( [],[] )
  ** (ArgumentError) arguments must be non-zero length lists

  ie> Statisaur.Bivariate.pearson_correlation( [1,2,3], [4,5] )
  ** (ArgumentError) arguments must be identical length lists

  ie> Statisaur.Bivariate.pearson_correlation( [1,1], [1,3] )
  ** (ArithmeticError) std. deviation of one or both inputs is 0
  """
  def pearson_correlation(list1, list2) when is_list(list1) and is_list(list2) and (length(list1) == 0 or length(list2) == 0 ) do
    raise ArgumentError, "arguments must be non-zero length lists"
  end
  def pearson_correlation(list1, list2) when is_list(list1) and is_list(list2) and length(list1) != length(list2) do
    raise ArgumentError, "arguments must be identical length lists"
  end
  def pearson_correlation(list1, list2) when is_list(list1) and is_list(list2) and length(list1) != 0 and length(list2)!=0 and length(list1) == length(list2) do
    covXY = covariance(list1, list2)
    sigmaX = Statisaur.stddev(list1)
    sigmaY = Statisaur.stddev(list2)

    # check that the std. deviations are nonzero

    case sigmaX*sigmaY do
      0 -> raise ArithmeticError, "std. deviation of one or both inputs is 0"
      _ -> covXY / (sigmaX * sigmaY)
    end
  end
end
