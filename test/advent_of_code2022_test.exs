defmodule AdventOfCode2022Test do
  use ExUnit.Case
  alias AdventOfCode2022

  @day1 %{part_01: 69_310, part_02: 206_104}
  @day2 %{part_01: 11_449, part_02: 13_187}
  @day3 %{part_01: 8_176, part_02: 2_689}
  @day4 %{part_01: 584, part_02: 933}
  @day5 %{part_01: "SBPQRSCDF", part_02: "RGLVRCQSB"}
  @day6 %{part_01: 1_210, part_02: 3_476}
  @day7 %{part_01: 1_581_595, part_02: 1_544_176}
  @day8 %{part_01: 1719, part_02: 590_824}

  test "match_snapshots" do
    assert AdventOfCode2022.day_01() == @day1
    assert AdventOfCode2022.day_02() == @day2
    assert AdventOfCode2022.day_03() == @day3
    assert AdventOfCode2022.day_04() == @day4
    assert AdventOfCode2022.day_05() == @day5
    assert AdventOfCode2022.day_06() == @day6
    assert AdventOfCode2022.day_07() == @day7
    assert AdventOfCode2022.day_08() == @day8
  end
end
