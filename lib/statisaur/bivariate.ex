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
   mu_x = mean(list1)
   mu_y = mean(list2)
   numerator = Enum.zip(list1, list2) |>
   Enum.map( fn {x, y} -> (x - mu_x) * (y + mu_y) end ) |> 
   Enum.sum()
   numerator/(n - 1)
 end
end
