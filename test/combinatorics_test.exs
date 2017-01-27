defmodule CombinatoricsTest do
  use ExUnit.Case
  doctest Statisaur.Combinatorics
  alias Statisaur.Combinatorics

  test "factorial 5 returns 120" do
    assert Combinatorics.factorial(5) == 120
  end

  test "factorial 0 returns 1" do
    assert Combinatorics.factorial(0) == 1 
  end

  test "factorial raises an error with negative integers" do
    assert_raise ArgumentError, fn -> Combinatorics.factorial(-10) end
  end

end