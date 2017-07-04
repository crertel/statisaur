defmodule StatisaurTest do
  use ExUnit.Case
  doctest Statisaur
  doctest Statisaur.TestHelper
  doctest Statisaur.Bivariate

  @large Enum.to_list(1..10000)
  @eps 1.0e-4

  test "min([1,1,2,3,5,8]) returns 1" do
    assert {:ok, 1} == Statisaur.min([1,1,2,3,5,8])
  end

  test "min([]) returns error tuple" do
    assert {:error, "argument must be nonempty list of numbers"} == Statisaur.min([])
  end

  test "min!([]) raises error" do
    assert_raise ArgumentError, fn -> Statisaur.min!([]) end
  end

  test "max([1,1,2,3,5,8]) returns 8" do
    assert {:ok, 8} == Statisaur.max([1,1,2,3,5,8])
  end

  test "max([]) returns error tuple" do
    assert {:error, "argument must be nonempty list of numbers"} == Statisaur.max([])
  end

  test "max!([]) raises error" do
    assert_raise ArgumentError, fn -> Statisaur.max!([]) end
  end


  test "sum([1,3,5,7,9])returns 25" do
    assert {:ok, 25} == Statisaur.sum([1,3,5,7,9])
  end

  test "sum([1,1])returns 2" do
    assert {:ok, 2} == Statisaur.sum([1,1])
  end

  test "sum/1 returns an error tuple when given non-list argument" do
    assert {:error, "argument must be list of numbers"} == Statisaur.sum(:not_a_list)
  end

  test "sum/1 returns an error tuple when given list of non-numbers as argument" do
    assert {:error, "argument must be list of numbers"} == Statisaur.sum([:list_of, "bad_stuff"])
  end

  test "sum/1 returns an error turble when given list with first argument as number and second argument invalid" do
    assert {:error, "argument must be list of numbers"} == Statisaur.sum([5, "hidden badstuff"])
  end

  test "sum!([1,3,5,7,9]) returns 25" do
    assert 25 == Statisaur.sum!([1,3,5,7,9])
  end

  test "sum!(:bad_info) raises an error" do
    assert_raise ArgumentError, fn -> Statisaur.sum!([:bad_info]) end
  end

  test "sum!([15, :bad_info]} raises an error" do
    assert_raise ArgumentError, fn -> Statisaur.sum!([15, :bad_info]) end 
  end

  test "mean([1,3,5,7,9]) returns 5" do
    assert {:ok, 5} == Statisaur.mean([1,3,5,7,9])
  end

  test "mean([0.1,0.2,0.6]) returns 0.3" do
    assert {:ok, 0.3} == Statisaur.mean([0.1,0.2,0.6])
  end

  test "mean(@large) returns 5000.5" do
    assert {:ok, 5000.5} == Statisaur.mean(@large)
  end

  test "mean([1, 3, 5, :uh_oh]) returns an error tuple" do
    assert {:error, "argument must be list of numbers"} == Statisaur.mean([1, 3, 5, :uh_oh])
  end 

  test "mean!([1, 3, 5, :uh_oh]) rasies an error" do
    assert_raise ArgumentError, fn -> Statisaur.mean!([1, 3, 5, :uh_oh]) end 
  end

  test "mean!([1,3,5,7,9]) returns 5 directly" do
    assert 5 == Statisaur.mean!([1,3,5,7,9])
  end

  test "median([0.1,0.2,0.6) returns 0.2" do
    assert {:ok, 0.2} == Statisaur.median([0.1,0.2,0.6])
  end

  test "median([0.7,0.4,0.6,0.1]) returns 0.5" do
    assert {:ok, 0.5} == Statisaur.median([0.7,0.4,0.6,0.1])
  end

  test "median([:bad_info, 3, 5, 7]) returns an error tuple" do
    assert {:error, "argument must be nonempty list of numbers"} == Statisaur.median([:bad_info, 3, 5, 7])
  end

  test "median!([9,3,7,5,1]) returns 5 directly" do
    assert 5 == Statisaur.median!([9, 3, 7, 5, 1])
  end

  test "median!([:bad_info, 1, 5, 6]) raises an error" do
    assert_raise ArgumentError, fn -> Statisaur.median!([:bad_info, 1, 5, 6]) end
  end

  test "variance([0.1,0.2,0.6]) returns 0.06999999999999999" do
    assert {:ok, 0.06999999999999999} == Statisaur.variance([0.1,0.2,0.6])
  end

  test "variance(@large) returns 8334166.666666667" do
    assert {:ok, 8334166.666666667} == Statisaur.variance(@large)
  end

  test "variance([:a, :bad, :list]) returns an error tuple" do
    assert {:error, "argument must be list of numbers"} == Statisaur.variance([:a, :bad, :list])
  end

  test "variance!(@large) returns 8334166.666666667 directly" do
    assert 8334166.666666667 == Statisaur.variance!(@large)
  end

  test "variance! raises an exception when given bad data" do
     assert_raise ArgumentError, fn -> Statisaur.variance!([:bad_info, 1, 5, 6]) end
  end

  test "stddev([0.1,0.2,0.6]) returns 0.2645751" do
    {:ok, dev} = Statisaur.stddev([0.1,0.2,0.6])
    assert_in_delta( 0.2645751, dev, @eps )
  end

  test "stddev(@large) returns 2886.895679" do
    {:ok, dev} = Statisaur.stddev(@large)
    assert_in_delta(2886.895679, dev, @eps)
  end

  test "stddev returns an error tuple when given bad data" do
    assert {:error, "argument must be list of numbers"} == Statisaur.stddev([:a, :bad, :list])
  end

  test "stddev!([0.1,0.2,0.6]) returns 0.2645751 directly" do
    dev = Statisaur.stddev!([0.1,0.2,0.6])
    assert_in_delta( 0.2645751, dev, @eps )
  end

  test "stddev!(@large) returns 2886.895679 directly" do
    dev = Statisaur.stddev!(@large)
    assert_in_delta(2886.895679, dev, @eps)
  end

  test "stddev! raises an error when given bad data" do
    assert_raise ArgumentError, fn -> Statisaur.stddev!([:a, :bad, :list]) end
  end

end
