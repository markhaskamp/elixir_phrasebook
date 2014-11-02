defmodule EnumTest do
  use ExUnit.Case

  test "empty?" do
    Enum.empty?([])
  end

  test "chunk(list,n) splits list into multiple lists with n elements each" do
    chunks = Enum.chunk(list_12, 6)
    assert 2 == Enum.count(chunks)
    assert [0,1,2,3,4,5] == Enum.at(chunks, 0)
  end

  test "chunk(list,n,step) starts each new chunked list by stepping \"step\"s into the original list. The chunked lists can have overlapping members" do
    chunks = Enum.chunk(list_with_6, 2, 2)
    assert [[0,1], [2,3], [4,5]] == chunks
  end

  test "chunk(list,n,step,pad) fills in the last chunk from pad, if necessary" do
    chunks = Enum.chunk(list_12, 5,5,[:a, :b, :c, :d])
    assert Enum.at(chunks,2) == [10, 11, :a, :b, :c]
  end


  defp list_12 do
    [0,1,2,3,4,5, 6,7,8,9,10,11]
  end

  defp list_with_6 do
    [0,1,2,3,4,5]
  end

end

