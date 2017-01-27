defmodule Statisaur.TestHelper do
  @moduledoc """
  Testhelper - functions to load
  data and otherwise help with
  testing.

  """

  @doc """
  Pluck nth column

  ### Examples
  iex>Statisaur.TestHelper.pluck([[1, 4]], 1)
  [1]
  """
  def pluck(list, n) do
    Enum.map(list, &Enum.at(&1, n - 1))
  end

  @doc """
  Pluck all columns

  ### Examples
  iex>Statisaur.TestHelper.pluck_all([[1, 4, 3], [2, 3, 1]])
  [[1, 2], [4, 3], [1, 3]]
  """
  def pluck_all(list, ncol, result) when ncol < 1 do
    result
  end

  @doc """
  Pluck all columns

  ### Examples
  iex>Statisaur.TestHelper.pluck_all([[1, 4, 3], [2, 3, 1]], 3, [])
  [[1, 2], [4, 3], [3, 1]]
  """
  def pluck_all(list, ncol, result) do
    result = [pluck(list, ncol)|result]
    pluck_all(list, ncol - 1, result)
  end

  @doc """
  Pluck all columns

  ### Examples
  iex>Statisaur.TestHelper.pluck_contents([[1, 4, 3], [2, 3, 1]])
  [[1, 2], [4, 3], [3, 1]]
  """
  def pluck_contents(list) when is_list(list) do
    ncol = length(hd(list))
    pluck_all(list, ncol, [])
  end
  
  @doc """
  Load csv

  ### Examples
  iex> Statisaur.TestHelper.load_csv("./test/data/crickets.csv")
  [["chirps_per_second", ["20.0", "16.0", "19.8", "18.4", "17.1", "15.5", "14.7",
    "15.7", "15.4", "16.3", "15.0", "17.2", "16.0", "17.0", "14.4", ""]],
     ["temperature_deg_f", ["88.6", "71.6", "93.3", "84.3", "80.6", "75.2", "69.7",
       "71.6", "69.4", "83.3", "79.6", "82.6", "80.6", "83.5", "76.3", nil]]]
  """
  def load_csv(file_path) when is_bitstring(file_path) do
    {:ok, contents} = File.read(file_path)
    [names, contents] = contents |>
    String.split("\n") |>
    Enum.filter( fn(x)-> (String.trim(x) |> String.length()) > 0 end ) |>
    Enum.map(&String.split(&1, ",")) |> 
    pluck_contents() |>
    Enum.map(fn(x) -> [hd(x), tl(x)] end)
  end
end
