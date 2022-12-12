defmodule AdventOfCode2022.PathfinderTest do
  use ExUnit.Case, async: true
  alias AdventOfCode2022.Pathfinder

  @map_file_path "lib/files/day_12/map_test.txt"

  test "get goal distance" do
    {map, start_positions, end_position} =
      @map_file_path
      |> File.read!()
      |> Pathfinder.get_matrix()

    costs = Pathfinder.a_star(map, start_positions)
    assert Pathfinder.get(costs, end_position) == 31
  end

  test "get max hiking effort" do
    {map, start_positions, end_position} =
      @map_file_path
      |> File.read!()
      |> String.replace("a", "S")
      |> Pathfinder.get_matrix()

    costs = Pathfinder.a_star(map, start_positions)
    assert Pathfinder.get(costs, end_position) == 29
  end
end
