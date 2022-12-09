defmodule AdventOfCode2022.RopeTest do
  use ExUnit.Case
  alias AdventOfCode2022.Rope

  @rope_file_path "lib/files/day_09/rope_movements_test.txt"

  test "count visible trees" do
    visited_positions =
      @rope_file_path
      |> File.read!()
      |> Rope.count_tail_visited_positions(1)

    assert visited_positions == 13
  end
end
