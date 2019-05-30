defmodule StatisaurTest do
  use ExUnit.Case
  doctest Statisaur
  doctest Statisaur.Bivariate

  @large Enum.to_list(1..10000)
  @eps 1.0e-4

  test "min([1,1,2,3,5,8]) returns 1" do
    assert 1 == Statisaur.min([1,1,2,3,5,8])
  end

  test "max([1,1,2,3,5,8]) returns 8" do
    assert 8 == Statisaur.max([1,1,2,3,5,8])
  end

  test "sum([1,3,5,7,9])returns 25" do
    assert 25 == Statisaur.sum([1,3,5,7,9])
  end

  test "sum([1,1])returns 2" do
    assert 2 == Statisaur.sum([1,1])
  end

  test "mean([1,3,5,7,9]) returns 5" do
    assert 5 == Statisaur.mean([1,3,5,7,9])
  end

  test "mean([0.1,0.2,0.6]) returns 0.3" do
    assert 0.3 == Statisaur.mean([0.1,0.2,0.6])
  end

  test "mean(@large) returns 5000.5" do
    assert 5000.5 == Statisaur.mean(@large)
  end

  test "median([0.1,0.2,0.6) returns 0.2" do
    assert 0.2 == Statisaur.median([0.1,0.2,0.6])
  end

  test "median([0.7,0.4,0.6,0.1]) returns 0.5" do
    assert 0.5 == Statisaur.median([0.7,0.4,0.6,0.1])
  end

  test "variance([0.1,0.2,0.6]) returns 0.06999999999999999" do
    assert 0.06999999999999999 == Statisaur.variance([0.1,0.2,0.6])
  end

  test "variance(@large) returns 8334166.666666667" do
    assert 8334166.666666667 == Statisaur.variance(@large)
  end

  test "stddev([0.1,0.2,0.6]) returns 0.2645751" do
    assert_in_delta( 0.2645751, Statisaur.stddev([0.1,0.2,0.6]), @eps )
  end

  test "stddev(@large) returns 2886.895679" do
    assert_in_delta(2886.895679, Statisaur.stddev(@large), @eps )
  end

end
