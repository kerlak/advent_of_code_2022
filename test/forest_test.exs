defmodule AdventOfCode2022.ForestTest do
  use ExUnit.Case, async: true
  alias AdventOfCode2022.Forest

  @forest_file_path "lib/files/day_08/forest_test.txt"

  test "count visible trees" do
    trees =
      @forest_file_path
      |> File.read!()
      |> Forest.count_visible_trees()

    assert trees == 21
  end

  test "get best scenic socre for a tree house" do
    score =
      @forest_file_path
      |> File.read!()
      |> Forest.best_scenic_score()

    assert score == 8
  end
end
