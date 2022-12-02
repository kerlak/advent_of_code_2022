defmodule AdventOfCode2022.CaloriesTest do
  use ExUnit.Case
  alias AdventOfCode2022.Calories
  doctest Calories

  test "count max calories" do
    assert Calories.get_top_elf_calories("lib/files/day_01/elves_calories_test.txt", 1) == 24000
  end

  test "sum of top three max calories" do
    assert Calories.get_top_elf_calories("lib/files/day_01/elves_calories_test.txt", 3) == 45000
  end
end
