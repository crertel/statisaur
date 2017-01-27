defmodule CombinatoricsTest do
  use ExUnit.Case
  doctest Statisaur.Combinatorics
  alias Statisaur.Combinatorics

  test "factorial 5 returns 120" do
    assert Combinatorics.factorial(5) == 120
  end
<<<<<<< HEAD

  test "factorial 0 returns 1" do
    assert Combinatorics.factorial(0) == 1 
  end

  test "factorial raises an error with negative integers" do
    assert_raise ArgumentError, fn -> Combinatorics.factorial(-10) end
  end

  test "combinations(4, 2) returns 6" do
    assert Combinatorics.combinations(4, 2) == 6
  end

  test "combinations(15, 8) returns 6435" do
    assert Combinatorics.combinations(15, 8) == 6435
  end

  test "combinations raises an error with negative integers" do
    assert_raise ArgumentError, fn -> Combinatorics.combinations(10, -5) end
  end

  test "combinations raises an error with non-integer inputs" do
    assert_raise ArgumentError, fn -> Combinatorics.combinations("string", 5) end
  end
=======
>>>>>>> a7e084b... Add test case for factorial function happy path

  test "factorial 0 returns 1" do
    assert Combinatorics.factorial(0) == 1 
  end

  test "factorial raises an error with negative integers" do
    assert_raise ArgumentError, fn -> Combinatorics.factorial(-10) end
  end

end