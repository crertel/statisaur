defmodule Statisaur do
  @moduledoc """
  Statisaur - Statistics functions
  This module currently contains the functions for
  summary statistics.
  
  """
  
  @doc """
  Calculate the sum from a list of numbers

  ### Examples
  iex>Statisaur.sum([1,3,5,7,9])
  25
  iex>Statisaur.sum([1,1])
  2
  iex>Statisaur.sum([0.5,0.5])
  1.0

  """
  def sum(list) when is_list(list), do: Enum.sum(list)

  @doc """
  Calculate the mean from a list of numbers

  ### Examples
  iex>Statisaur.mean([1,3,5,7,9])
  5.0
  iex>Statisaur.mean([0.1,0.2,0.6])
  0.3

  """
  def mean(list) when is_list(list), do: sum(list)/length(list)

  @doc """
  Calculate the median from a list of numbers

  ### Examples
  iex>Statisaur.median([1,3,5,7,9])
  5
  iex>Statisaur.median([1,1])
  1.0
  iex>Statisaur.median([0.1,0.4,0.6,0.9])
  0.5

  """
  def median(list) when is_list(list) do
    n = length(list)
    sorted = list |> Enum.sort
    pivot = round(n/2)

    case rem(n,2)  do
      0 -> a = sorted |> Enum.at(pivot) 
           b = sorted |> Enum.at(pivot - 1) 
           (a+b)/2 # median for an even-sized set is the mean of the middle numbers
      _ -> sorted |> Enum.at(round(Float.floor(n/2))) # this seems weird, but Float floor yields float not int :()
    end
  end

  @doc """
  Calculate the variance from a list of numbers

  ### Examples
  iex>Statisaur.var([1,3,5,7,9])
  10.0
  iex>Statisaur.var([0.1,0.2,0.6])
  0.06999999999999999

  """
  def var(list) when is_list(list) and length(list) > 1 do
    mu = mean(list)
    diffmeans = list |> Enum.map(fn x -> (mu - x) * (mu - x) end) |> Enum.sum
    df = length(list) - 1
    diffmeans/df
  end
end
