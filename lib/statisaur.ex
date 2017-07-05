defmodule Statisaur do
  @moduledoc """
  Statisaur - Statistics functions
  This module currently contains the functions for
  summary statistics.
  """
  
  @doc """
  Calculate the smallest value from a list of numbers.

  ### Examples
  iex>Statisaur.min([1,2,3])
  {:ok, 1}
  iex>Statisaur.min([5,0.5,2,3])
  {:ok, 0.5}

  Statisaur will return an error tuple for empty lists.
  iex>Statisaur.min([])
  {:error, "argument must be nonempty list of numbers"}
  """
  def min(list) when is_list(list) and length(list) > 1 do
    response = do_min(list)
    {:ok, response}
  end

  def min(_list) do
    {:error, "argument must be nonempty list of numbers"}
  end

  @doc """
  Same as `min/1`, but but returns the response directly, or 
  throws `ArgumentError` if an error is returned.
  """
  def min!(list) do
    case min(list) do
      {:ok, response} ->
        response
      {:error, reason} ->
        raise ArgumentError, "#{reason}"
    end
  end

  defp do_min(list) when is_list(list) and length(list) > 1 do
    Enum.min(list)
  end

  @doc """
  Calculate the largest value from a list of numbers.
  ### Examples
  iex>Statisaur.max([1,2,3])
  {:ok, 3}
  iex>Statisaur.max([5.1,0.5,2,3])
  {:ok, 5.1}

  Statisaur returns an error tuple with empty lists.
  iex>Statisaur.max([])
  {:error, "argument must be nonempty list of numbers"}
  """
  def max(list) when is_list(list) and length(list) > 1 do
    response = do_max(list)
    {:ok, response}
  end

  def max(_list) do
    {:error, "argument must be nonempty list of numbers"}
  end

  @doc """
  Same as `max/1`, but but returns the response directly, or 
  throws `ArgumentError` if an error is returned.
  """
  def max!(list) do
    case max(list) do
      {:ok, response} ->
        response
      {:error, reason} ->
        raise ArgumentError, "#{reason}"
    end
  end

  defp do_max(list) when is_list(list) and length(list) > 1 do
    Enum.max(list)
  end

  @doc """
  Calculate the sum from a list of numbers

  ### Examples
  iex>Statisaur.sum([1,3,5,7,9])
  {:ok, 25}
  iex>Statisaur.sum([1,1])
  {:ok, 2}
  iex>Statisaur.sum([0.5,0.5])
  {:ok, 1.0}
  iex> Statisaur.sum(:banana)
  {:error, "argument must be list of numbers"}

  """
  @spec sum([number]) :: {:ok, number} | {:error, String.t}
  def sum(list = [number | _tail]) when is_list(list) and is_number(number) do
    try do 
      result = Enum.sum(list) 
      {:ok, result}
    rescue
      ArithmeticError -> {:error, "argument must be list of numbers"}
    end
  end

  def sum(_not_list), do: {:error, "argument must be list of numbers"}

  @doc """
  Same as `sum/1`, but but returns the response directly, or 
  throws `ArgumentError` if an error is returned.
  """

  def sum!(list) do
    case sum(list) do
      {:ok, response} ->
        response
      {:error, reason} ->
        raise ArgumentError, "#{reason}"
    end
  end


  @doc """
  Calculate the mean from a list of numbers

  ### Examples
  iex>Statisaur.mean([1,3,5,7,9])
  {:ok, 5.0}
  iex>Statisaur.mean([0.1,0.2,0.6])
  {:ok, 0.3}

  """
  @spec mean([number]) :: {:ok, float} | {:error, String.t}
  def mean(list) when is_list(list) do
    with {:ok, result} <- sum(list) do
     {:ok, result/length(list)}
    else
      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Same as `mean/1`, but but returns the response directly, or 
  throws `ArgumentError` if an error is returned.
  """

  def mean!(list) do
    case mean(list) do
      {:ok, response} ->
        response
      {:error, reason} ->
        raise ArgumentError, "#{reason}"
    end
  end

  @doc """
  Calculate the median from a list of numbers

  ### Examples
  iex>Statisaur.median([1,3,5,7,9])
  {:ok, 5}
  iex>Statisaur.median([1,1])
  {:ok, 1.0}
  iex>Statisaur.median([0.1,0.4,0.6,0.9])
  {:ok, 0.5}

  """
  @spec median([number]) :: {:ok, number} | {:error, String.t}
  def median(list = [number | _tail]) when is_list(list) and is_number(number) do
    n = length(list)
    sorted = list |> Enum.sort
    pivot = round(n/2)

    result = case rem(n,2)  do
      0 -> a = sorted |> Enum.at(pivot) 
           b = sorted |> Enum.at(pivot - 1) 
           (a+b)/2 # median for an even-sized set is the mean of the middle numbers
      _ -> sorted |> Enum.at(round(Float.floor(n/2))) # this seems weird, but Float floor yields float not int :()
    end
    {:ok, result}
  end

  def median(_list) do
    {:error, "argument must be nonempty list of numbers"}
  end


  @doc """
  Same as `median/1`, but but returns the response directly, or 
  throws `ArgumentError` if an error is returned.
  """
  def median!(list) do
    case median(list) do
      {:ok, result} ->
        result
      {:error, reason} ->
        raise ArgumentError, "#{reason}"
    end
  end

  @doc """
  Calculate the frequency counts of distinct elements.

  ### Examples
  iex>Statisaur.frequencies([1])
  {:ok, [{1,1}]}
  iex>Statisaur.frequencies([1,2,2,3])
  {:ok, [{1,1},{2,2},{3,1}]}
  """
  def frequencies(list) when is_list(list) do
    sorted = list |> Enum.sort
    vals = sorted |> Enum.uniq
    freqs = vals |> Enum.map( fn(v) -> Enum.count(sorted, fn(x)-> x == v end) end)
    result = Enum.zip(vals,freqs)
    {:ok, result}
  end

  def frequencies(_list) do
    {:error, "Argument must be an enumerable"}
  end

  @doc """
  Same as `frequencies/1`, but but returns the response directly, or 
  throws `ArgumentError` if an error is returned.
  """
  def frequencies!(list) do
    case frequencies(list) do
      {:ok, result} ->
        result
      {:error, reason} ->
        raise ArgumentError, "#{reason}"
    end
  end

  @doc """
  Calculate most commonly occurring number from a list of numbers

  ### Examples
  iex>Statisaur.mode([1,1,2,3])
  {:ok, [1]}
  iex>Statisaur.mode([1.0,2.0,2.0,3.0,3.0])
  {:ok, [2.0,3.0]}
  """
  def mode(list = [number | _tail]) when is_list(list) and is_number(number) and length(list) > 0 do
    {:ok, freqs} = frequencies(list)
    sorted_freqs = freqs |> Enum.sort_by(fn({_,f})->f end, &>=/2)
    {_, mode_guess} = sorted_freqs |> Enum.at(0)
    result = sorted_freqs |> Enum.filter( fn({_,f})-> f >= mode_guess end) |> Enum.map( fn({v,_})->v end)
    {:ok, result}
  end

  def mode(_list) do
    {:error, "argument must be nonempty list of numbers"}
  end

  @doc """
  Same as `mode/1`, but but returns the response directly, or 
  throws `ArgumentError` if an error is returned.
  """
  def mode!(list) do
    case mode(list) do
      {:ok, result} ->
        result
      {:error, reason} ->
        raise ArgumentError, "#{reason}"
    end
  end

  @doc """
  Create an element-wise kth-power of a list compared to a reference value.

  ### Examples
  iex>Statisaur.powered_error( [1,2,3], 2, 1)
  {:ok, [-1.0,0.0,1.0]}
  """
  def powered_error(list = [number | _tail], reference, k) when is_list(list) and length(list) > 1 and is_number(number)
    and is_number(reference) and is_number(k) do
    try do
      result = list |> Enum.map( fn(x) -> :math.pow( x - reference, k) end )
      {:ok, result}
    rescue
      ArgumentError -> {:error, "argument must be nonempty list of numbers, a number, and a number"}
    end
  end

  def powered_error(_list, _ref, _k) do
    {:error, "argument must be nonempty list of numbers, a number, and a number"}
  end

  @doc """
  Same as `powered_error/3`, but but returns the response directly, or 
  throws `ArgumentError` if an error is returned.
  """
  def powered_error!(list, ref, k) do
    case powered_error(list, ref, k) do
      {:ok, result} ->
        result
      {:error, reason} ->
        raise ArgumentError, "#{reason}"
    end
  end

  @doc """
  Calculate the variance from a list of numbers

  ### Examples
  iex>Statisaur.variance([1,3,5,7,9])
  {:ok, 10.0}
  iex>Statisaur.variance([0.1,0.2,0.6])
  {:ok, 0.06999999999999999}

  """
  def variance(list) when is_list(list) and length(list) > 1 do  
    with {:ok, mu} <- mean(list),
         {:ok, pe} <- powered_error(list, mu, 2),
         diffmeans <- Enum.sum(pe),
         df <- length(list) - 1,
         result <- diffmeans/df
      do {:ok, result} 
    else {:error, reason} ->
      {:error, reason}
    end 
  end

  @doc """
  Same as `variance/1`, but but returns the response directly, or 
  throws `ArgumentError` if an error is returned.
  """
  def variance!(list) do
    case variance(list) do
      {:ok, result} ->
        result
      {:error, reason} ->
        raise ArgumentError, "#{reason}" 
    end
  end

  @doc """
  Calculates the standard deviation from a list of numbers.

  ### Examples
  iex>with {:ok, result} <- Statisaur.stddev([1,3,5,7,9]), do: Float.round(result, 6)
  3.162278
  iex>with {:ok, result} <- Statisaur.stddev([0.1,0.2,0.6]), do: Float.round(result, 6)
  0.264575
  """
  def stddev(list) when is_list(list) and length(list) > 1 do
    with {:ok, var} <- variance(list),
          result <- :math.sqrt(var)
      do  {:ok, result}
    else 
      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Same as `stddev/1`, but but returns the response directly, or 
  throws `ArgumentError` if an error is returned.
  """
  def stddev!(list) do
    case stddev(list) do
      {:ok, result} ->
        result
      {:error, reason} ->
        raise ArgumentError, "#{reason}"
    end
  end

  @doc """
  Calculate the kth moment with respect to the origin of a list of numbers.

  ###Examples
  iex>Statisaur.raw_moment([1,2,3,4],1)
  {:ok, 2.5}
  iex>Statisaur.raw_moment([1,2,3,4],2)
  {:ok, 7.5}
  iex>Statisaur.raw_moment([1,2,3,4],3)
  {:ok, 25.0}
  iex>Statisaur.raw_moment([1,2,3,4],4)
  {:ok, 88.5}
  """
  def raw_moment(list, k) when is_list(list) and length(list) > 1 do
    try do 
    count = length(list)  
    result = (list |> Enum.map( fn(x) -> :math.pow( x, k) end ) |> Enum.sum) / count
    {:ok, result}
    rescue
      ArithmeticError -> {:error, "argument must be list of numbers and an integer"}
      ArgumentError -> {:error, "argument must be list of numbers and an integer"}
    end
  end


  @doc """
  Same as `raw_moment/2`, but but returns the response directly, or 
  throws `ArgumentError` if an error is returned.
  """
  def raw_moment!(list, k) do
    case raw_moment(list, k) do
      {:ok, result} ->
        result
      {:error, reason} ->
        raise ArgumentError, "#{reason}"
    end
  end

  @doc """
  Calculate the kth central moment of a list of numbers.

  ###Examples
  iex>Statisaur.central_moment([1,2,3,4],1)
  {:ok, 0.0}
  iex>Statisaur.central_moment([1,2,3,4],2)
  {:ok, 1.25}
  iex>Statisaur.central_moment([1,2,3,4],3)
  {:ok, 0.0}
  iex>with {:ok, moment} <- Statisaur.central_moment([1,2,3,4],4), do: Float.round(moment, 4)
  2.5625
  """
  def central_moment(list, k) when is_list(list) and length(list) > 1 do
    with count <- length(list),
         {:ok, mu} <- mean(list),
         {:ok, pe} <- powered_error(list, mu, k)
      do
        {:ok, Enum.sum(pe) / count}
      else
        {:error, reason} ->
          {:error, reason}
      end
  end

  @doc """
  Same as `central_moment/2`, but but returns the response directly, or 
  throws `ArgumentError` if an error is returned.
  """
  def central_moment!(list, k) do
    case central_moment(list, k) do
    {:ok, result} ->
      result
    {:error, reason} ->
      raise ArgumentError, "#{reason}"
    end
  end

  @doc """
  Calculate the kth standardized moment of a list of numbers. See [here](https://en.wikipedia.org/wiki/Standardized_moment) for definition.

  ###Examples
  iex>Statisaur.standardized_moment([1,2,3,4],1)
  {:ok, 0.0}
  iex>Statisaur.standardized_moment([1,2,3,4],2)
  {:ok, 1.0}
  iex>Statisaur.standardized_moment([1,2,3,4],3)
  {:ok, 0.0}
  iex>Statisaur.standardized_moment([1,2,3,4],4)
  {:ok, 1.64}
  """
  def standardized_moment(list, k) when is_list(list) and length(list) > 1 do 
    with {:ok, m1} <- raw_moment(list, 1),
          {:ok, pe} <- powered_error(list, m1, k),
          len <- length(list),
          num <- Enum.sum(pe) / len,
          {:ok, pe2} <- powered_error(list, m1, 2),
          denom <- :math.pow( (Enum.sum(pe2)/len), k/2 )
      do
        {:ok, num/denom}
      else
        {:error, reason} ->
          {:error, reason}
      end
  end

  @doc """
  Same as `standardized_moment/2`, but but returns the response directly, or 
  throws `ArgumentError` if an error is returned.
  """
  def standardized_moment!(list, k) do
    case central_moment(list, k) do
    {:ok, result} ->
      result
    {:error, reason} ->
      raise ArgumentError, "#{reason}"
    end
  end

  @doc """
  Calculates the skewness (3rd standardized moment) of a list of numbers.

  ###Examples
  iex>Statisaur.skewness([1,2,3,4])
  {:ok, 0.0}
  """
  def skewness(list) when is_list(list) and length(list) > 1  do    
    case standardized_moment(list,3) do
      {:ok, result} ->
        {:ok, result}
      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Same as `skewness/1`, but but returns the response directly, or 
  throws `ArgumentError` if an error is returned.
  """
  def skewness!(list) do    
    case standardized_moment(list,3) do
      {:ok, result} ->
        result
      {:error, reason} ->
       raise ArgumentError, "#{reason}"
    end
  end

  @doc """
  Calculates the kurtosis (4th standardized moment) of a list of numbers.

  ###Examples
  iex>Statisaur.kurtosis([1,2,3,4])
  {:ok, 1.64}
  """
  def kurtosis(list) when is_list(list) and length(list) > 1  do    
    case standardized_moment(list,4) do
      {:ok, result} ->
        {:ok, result}
      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Same as `kurtosis/1`, but but returns the response directly, or 
  throws `ArgumentError` if an error is returned.
  """
  def kurtosis!(list) when is_list(list) and length(list) > 1  do    
    case standardized_moment(list,4) do
      {:ok, result} ->
        result
      {:error, reason} ->
        raise ArgumentError, "#{reason}"
    end
  end

  @doc """
  Calculates the coefficient of variation for a list of numbers.

  ###Examples
  iex>with {:ok, result} <- Statisaur.coefficient_of_variation([1,2,3,4]), do: Float.round(result, 4)
  0.5164
  """
  def coefficient_of_variation(list) when is_list(list) and length(list) > 1 do
    with {:ok, dev} <- stddev(list),
         {:ok, me } <- mean(list)
    do 
      {:ok, dev/me}
    else
      {:error, reason} ->
        {:error, reason}
     end
  end


  @doc """
  Same as `coefficient_of_variation/1`, but but returns the response directly, or 
  throws `ArgumentError` if an error is returned.
  """
  def coefficient_of_variation!(list) do
    case coefficient_of_variation(list) do
      {:ok, result} ->
        result
      {:error, reason} ->
        raise ArgumentError, "#{reason}"
    end
  end

end
