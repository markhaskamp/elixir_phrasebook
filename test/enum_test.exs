defmodule EnumTest do
  use ExUnit.Case

  test "empty?" do
    Enum.empty?([])
  end

  test "chunk(list,n) splits list into multiple lists with n elements each" do
    list = [0,1,2,3,4,5,6,7,8,9,10,11,12]

    chunks = Enum.chunk(list, 6)
    assert 2 == Enum.count(chunks)
    assert [0,1,2,3,4,5] == Enum.at(chunks, 0)
  end
end

