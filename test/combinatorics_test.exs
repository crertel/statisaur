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

  test "n_choose_k(4, 2) returns 6" do
    assert Combinatorics.n_choose_k(4, 2) == 6
  end

  test "n_choose_k(15, 8) returns 6435" do
    assert Combinatorics.n_choose_k(15, 8) == 6435
  end

  test "n_choose_k raises an error with negative integers" do
    assert_raise ArgumentError, fn -> Combinatorics.n_choose_k(10, -5) end
  end

  test "n_choose_k raises an error with non-integer inputs" do
    assert_raise ArgumentError, fn -> Combinatorics.n_choose_k("string", 5) end
  end

  test "falling_factorial with two positive integers" do
    assert Combinatorics.falling_factorial(10, 5) == 30240
  end

  test "falling_factorial with first argument negative" do
    assert Combinatorics.falling_factorial(-10, 5) == -240240
  end

  test "falling_factorial with second argument negative returns float between zero and one" do
    assert Combinatorics.falling_factorial(4, -2) == 1/30
  end

  test "falling factorial with second argument as 0 returns 1" do
    assert Combinatorics.falling_factorial(4, 0) == 1
  end
end