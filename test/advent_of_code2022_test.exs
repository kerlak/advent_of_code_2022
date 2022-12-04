defmodule AdventOfCode2022Test do
  use ExUnit.Case
  alias AdventOfCode2022
  doctest AdventOfCode2022

  @day1 %{part_01: 69310, part_02: 206104}
  @day2 %{part_01: 11449, part_02: 13187}
  @day3 %{part_01: 8176, part_02: 2689}

  test "match_snapshots" do
    assert @day1 == AdventOfCode2022.day_01()
    assert @day2 == AdventOfCode2022.day_02()
    assert @day3 == AdventOfCode2022.day_03()
  end
end
