defmodule CombinatoricsTest do
  use ExUnit.Case
  doctest Statisaur.Combinatorics
  alias Statisaur.Combinatorics

  test "factorial 5 returns 120" do
    assert Combinatorics.factorial(5) == {:ok, 120}
  end

  test "factorial 0 returns 1" do
    assert Combinatorics.factorial(0) == {:ok, 1} 
  end

  test "factorial returns error tuple with negative integers" do
    assert Combinatorics.factorial(-10) == {:error, "argument must be positive integer"}
  end

  test "factorial! raises an error with negative integers" do
    assert_raise ArgumentError, fn -> Combinatorics.factorial!(-10) end
  end

  test "n_choose_k(4, 2) returns 6" do
    assert Combinatorics.n_choose_k(4, 2) == {:ok, 6}
  end

  test "n_choose_k(15, 8) returns 6435" do
    assert Combinatorics.n_choose_k(15, 8) == {:ok, 6435}
  end

  test "n_choose_k returns an error tuple with negative integers" do
    assert Combinatorics.n_choose_k(10, -5) == {:error, "arguments must be positive integers"}  
  end

  test "n_choose_k! raises an error with negative integers" do
    assert_raise ArgumentError, fn -> Combinatorics.n_choose_k!(10, -5) end
  end

  test "n_choose_k returns an error  tuple with non-integer inputs" do
    assert Combinatorics.n_choose_k("string", 5) == {:error, "arguments must be positive integers"}
  end

  test "n_choose_k! raises an error with non-integer inputs" do
    assert_raise ArgumentError, fn -> Combinatorics.n_choose_k!("string", 5) end
  end

  test "falling_factorial with two positive integers" do
    assert Combinatorics.falling_factorial(10, 5) == {:ok, 30240}
  end

  test "falling_factorial with first argument negative" do
    assert Combinatorics.falling_factorial(-10, 5) == {:ok, -240240}
  end

  test "falling_factorial with second argument negative returns float between zero and one" do
    assert Combinatorics.falling_factorial(4, -2) == {:ok, 1/30}
  end

  test "falling_factorial with second argument as 0 returns 1" do
    assert Combinatorics.falling_factorial(4, 0) == {:ok, 1}
  end

  test "falling_factorial with non-integer arguments returns error tuple" do
    assert Combinatorics.falling_factorial(:bad, "info") == {:error, "arguments must be integers"}
  end

  test "falling_factorial! with non-integer arguments raises ArgumentError" do
    assert_raise ArgumentError, fn -> Combinatorics.falling_factorial!(:bad, "info") end
  end

  test "rising_factorial with two positive integers" do
    assert Combinatorics.rising_factorial(5, 3) == {:ok, 210}
  end

  test "rising factorial with first argument smaller than second argument" do
    assert Combinatorics.rising_factorial(3, 5) == {:ok, 2520}
  end

  test "rising_factorial with second argument as 0 returns 1" do
    assert Combinatorics.rising_factorial(5, 0) == {:ok, 1}
  end

  test "rising factorial with first argument as 0 returns zero" do
    assert Combinatorics.rising_factorial(0, 5) == {:ok, 0}
  end

  test "rising_factorial with first argument negative" do
    assert Combinatorics.rising_factorial(-5, 3) == {:ok, -60}
  end

  test "rising_factorial with second argument negative raises ArithmeticError" do
    assert Combinatorics.rising_factorial(5, -3) == {:error, "bad argument in arithmetic expression"}
  end

  test "rising_factorial with non-integer arguments raises ArgumentError" do
    assert Combinatorics.rising_factorial("not", [:good]) == {:error, "arguments must be integers"}
  end

  test "rising_factorial! with second argument negative raises ArgumentError" do
    assert_raise ArgumentError, fn -> Combinatorics.rising_factorial!(5, -3) end
  end

  test "rising_factorial! with non-integer arguments raises ArgumentError" do
    assert_raise ArgumentError, fn -> Combinatorics.rising_factorial!("not", [:good]) end
  end
end