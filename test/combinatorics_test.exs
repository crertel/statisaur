defmodule CombinatoricsTest do
  use ExUnit.Case
  doctest Statisaur.Combinatorics
  alias Statisaur.Combinatorics

  test "factorial 5 returns 120" do
    assert Combinatorics.factorial(5) == 120
  end

end