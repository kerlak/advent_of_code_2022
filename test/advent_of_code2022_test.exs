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

  test "match_snapshots" do
    assert @day1 == AdventOfCode2022.day_01()
    assert @day2 == AdventOfCode2022.day_02()
    assert @day3 == AdventOfCode2022.day_03()
    assert @day4 == AdventOfCode2022.day_04()
    assert @day5 == AdventOfCode2022.day_05()
    assert @day6 == AdventOfCode2022.day_06()
    assert @day7 == AdventOfCode2022.day_07()
  end
end
