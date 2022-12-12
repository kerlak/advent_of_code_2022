defmodule AdventOfCode2022Test do
  use ExUnit.Case, async: true
  alias AdventOfCode2022

  @day01 %{part_01: 69_310, part_02: 206_104}
  @day02 %{part_01: 11_449, part_02: 13_187}
  @day03 %{part_01: 8_176, part_02: 2_689}
  @day04 %{part_01: 584, part_02: 933}
  @day05 %{part_01: "SBPQRSCDF", part_02: "RGLVRCQSB"}
  @day06 %{part_01: 1_210, part_02: 3_476}
  @day07 %{part_01: 1_581_595, part_02: 1_544_176}
  @day08 %{part_01: 1719, part_02: 590_824}
  @day09 %{part_01: 6256, part_02: 2665}
  @day10 %{
    part_01: 11960,
    part_02: """
    ####...##..##..####.###...##..#....#..#.
    #.......#.#..#.#....#..#.#..#.#....#..#.
    ###.....#.#....###..#..#.#....#....####.
    #.......#.#....#....###..#.##.#....#..#.
    #....#..#.#..#.#....#....#..#.#....#..#.
    ####..##...##..#....#.....###.####.#..#.
    """
  }
  @day11 %{part_01: 120_384, part_02: 32_059_801_242}
  @day12 %{part_01: 339, part_02: 332}

  test "match_snapshots" do
    assert AdventOfCode2022.day_01() == @day01
    assert AdventOfCode2022.day_02() == @day02
    assert AdventOfCode2022.day_03() == @day03
    assert AdventOfCode2022.day_04() == @day04
    assert AdventOfCode2022.day_05() == @day05
    assert AdventOfCode2022.day_06() == @day06
    assert AdventOfCode2022.day_07() == @day07
    assert AdventOfCode2022.day_08() == @day08
    assert AdventOfCode2022.day_09() == @day09
    assert AdventOfCode2022.day_09() == @day09
    assert AdventOfCode2022.day_10() == @day10
    assert AdventOfCode2022.day_11() == @day11
    assert AdventOfCode2022.day_12() == @day12
  end
end
