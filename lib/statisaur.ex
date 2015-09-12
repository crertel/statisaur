defmodule Statisaur do
  @doc """
  Test if a collection is enumerable

  ### Examples

  iex>Statisaur.is_enum(1..8)
  true
  iex>Statisaur.is_enum([1,2,3])
  true
  iex>Statisaur.is_enum({1,2,3})
  false

  """
  def is_enum(item) do
    try do
      Enum.sum(item)
      what_happened = true
    rescue
      _ -> what_happened = false
    end
  end

  @doc """
  Calculate the mean from a list of numbers

  If list, coerce to list

  ### Examples
  iex>Statisaur.sum([1,3,5,7,9])
  25
  iex>Statisaur.sum([1,1])
  2
  iex>Statisaur.sum([0.5,0.5])
  1.0

  """
  def sum(list) when is_list(list), do: Enum.sum(Enum.to_list(list))

  @doc """
  Calculate the mean from a list of numbers

  ### Examples
  iex>Statisaur.mean([1,3,5,7,9])
  5.0
  iex>Statisaur.mean([0.1,0.2,0.6])
  0.3

  """
  def mean(list) when is_list(list), do: sum(list)/length(list)

end
