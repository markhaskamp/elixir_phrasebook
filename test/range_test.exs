defmodule RangeTest do
  use ExUnit.Case

  import Range

  test "m..n creates a range" do
    assert range?(11..20)
  end

  test "range? returns true if arg is a range" do
    assert range?(11..20)
  end

  test "given m..n, the last element in the range is n" do
    first .. last = 11..20
    assert last == 20
  end

  test "given m..n, the first element in the range is m" do
    first .. last = 11..20
    assert first == 11
  end
end
