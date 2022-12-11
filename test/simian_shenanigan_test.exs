defmodule AdventOfCode2022.SimianShenaniganTest do
  use ExUnit.Case, async: true
  alias AdventOfCode2022.SimianShenanigan

  @monkeys_notes "lib/files/day_11/monkeys_notes_test.txt"

  test "get monkeys items after 20 rounds" do
    monkeys_notes = File.read!(@monkeys_notes)
    monkeys = SimianShenanigan.play(monkeys_notes, :simple, 20)

    assert Enum.map(monkeys, & &1.items) == [
             [10, 12, 14, 26, 34],
             [245, 93, 53, 199, 115],
             [],
             []
           ]

    assert monkeys
           |> Enum.map(& &1.inspections)
           |> Enum.sort(:desc)
           |> Enum.take(2)
           |> Enum.reduce(&(&1 * &2)) ==
             10605
  end

  test "get monkeys items after 10_000 rounds with custom management_system" do
    monkeys_notes = File.read!(@monkeys_notes)
    monkeys = SimianShenanigan.play(monkeys_notes, :complex, 10_000)

    assert Enum.map(monkeys, & &1.inspections) == [52166, 47830, 1938, 52013]

    assert monkeys
           |> Enum.map(& &1.inspections)
           |> Enum.sort(:desc)
           |> Enum.take(2)
           |> Enum.reduce(&(&1 * &2)) ==
             2_713_310_158
  end
end
