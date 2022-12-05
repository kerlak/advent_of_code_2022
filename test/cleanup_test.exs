defmodule AdventOfCode2022.CleanupTest do
  use ExUnit.Case
  alias AdventOfCode2022.Cleanup
  doctest Cleanup

  test "get fully recleanings" do
    assert Cleanup.get_fully_recleanings("lib/files/day_04/cleanup_pairs_test.txt") == 2
  end

  test "get overlap recleanings" do
    assert Cleanup.get_overlap_recleanings("lib/files/day_04/cleanup_pairs_test.txt") == 4
  end
end
