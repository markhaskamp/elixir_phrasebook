defmodule EnumTest do
  use ExUnit.Case

  import Enum

  test "empty?" do
    empty?([])
  end

  test "chunk(list,n) splits list into multiple lists with n elements each" do
    chunks = chunk(list_12, 6)
    assert 2 == count(chunks)
    assert [0,1,2,3,4,5] == at(chunks, 0)
  end

  test "chunk(list,n,step) starts each new chunked list by stepping \"step\"s into the original list. The chunked lists can have overlapping members" do
    chunks = chunk(list_with_6, 2, 2)
    assert [[0,1], [2,3], [4,5]] == chunks
  end

  test "chunk(list,n,step,pad) fills in the last chunk from pad, if necessary" do
    chunks = chunk(list_12, 5,5,[:a, :b, :c, :d])
    assert at(chunks,2) == [10, 11, :a, :b, :c]
  end
  
  test "chunk(list,n,step,nil) will build chunks only up to what is defined by n and step. original items my not appear in new chunks " do
    chunks = chunk([:a, :b, :c, :d, :e, :f], 4,4)
    assert 1 == count(chunks)
    assert [:a,:b,:c,:d] == at(chunks,0)
  end

  test "chunk(list,n,step,[]) may build the last chunk with fewer items than the previous chunks" do
    chunks = chunk([:a, :b, :c, :d, :e, :f], 4,4,[])
    assert 2 == count(chunks)
    assert [:e,:f] == at(chunks,1)
  end



  defp list_12 do
    [0,1,2,3,4,5, 6,7,8,9,10,11]
  end

  defp list_with_6 do
    [0,1,2,3,4,5]
  end

end

