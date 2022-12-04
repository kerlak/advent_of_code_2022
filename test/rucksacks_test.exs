defmodule AdventOfCode2022.RucksacksTest do
  use ExUnit.Case
  alias AdventOfCode2022.Rucksacks
  doctest Rucksacks

  test "get sum of priorities" do
    assert Rucksacks.get_total_priority("lib/files/day_03/rucksacks_items_test.txt") == 157
  end

  test "get groups priorities" do
    assert Rucksacks.get_total_groups_priority("lib/files/day_03/rucksacks_items_test.txt") == 70
  end
end
