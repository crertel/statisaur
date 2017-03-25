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
		m1 = mean(list1)
		m2 = mean(list2)
		b1_num_p1 = powered_error(list1, m1, 1)
		b1_num_p2 = powered_error(list2, m2, 1)
		b1_num = sum(Enum.map(Enum.zip(b1_num_p1, b1_num_p2), fn({x, y})-> x*y end))
		b1_denom = sum(powered_error(list1, m1, 2))
		b1 = b1_num/b1_denom
		b0 = mean(list2) - b1 * mean(list1)
		b1 = b1
		{2, {b0, b1}}
	end
end
