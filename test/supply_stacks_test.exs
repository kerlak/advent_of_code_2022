defmodule AdventOfCode2022.SupplyStacksTest do
  use ExUnit.Case, async: true
  alias AdventOfCode2022.SupplyStacks

  @stack_str "    [D]    \n[N] [C]    \n[Z] [M] [P]\n 1   2   3 "

  test "get stack from string" do
    assert @stack_str
           |> SupplyStacks.get_stack() ==
             [
               ["N", "Z"],
               ["D", "C", "M"],
               ["P"]
             ]
  end

  test "test transpose" do
    assert [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]]
           |> SupplyStacks.transpose_matrix() ==
             [[1, 5, 9], [2, 6, 10], [3, 7, 11], [4, 8, 12]]
  end

  test "get last crane" do
    assert SupplyStacks.last_crane("lib/files/day_05/stack_test.txt") == "CMZ"
  end

  test "get last crane with CrateMover 9001" do
    assert SupplyStacks.last_crane_with_9001("lib/files/day_05/stack_test.txt") == "MCD"
  end
end
