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
end