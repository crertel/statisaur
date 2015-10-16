defmodule StatisaurTest do
  use ExUnit.Case
  doctest Statisaur

  @large Enum.to_list(1..10000)

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

  test "var([0.1,0.2,0.6]) returns 0.06999999999999999" do
    assert 0.06999999999999999 == Statisaur.var([0.1,0.2,0.6])
  end

  test "var(@large) returns 8334166.666666667" do
    assert 8334166.666666667 == Statisaur.var(@large)
  end

end


