defmodule ParallelMapTest do
  use ExUnit.Case

  test "the truth" do
    assert true
  end

  test "try it" do
    square = fn(x) -> x * x end
    new_list = 
    Enum.map([1,2,3,4,5], &(Task.async(fn -> square.(&1) end)))
    |>
    Enum.map(&(Task.await(&1)))

    assert [1,4,9,16,25] = new_list
  end


end
