defmodule AdventOfCode2022.CpuTest do
  use ExUnit.Case
  alias AdventOfCode2022.Cpu

  @instructions_file_path "lib/files/day_10/cpu_instructions_test.txt"

  test "get register value at cycle…" do
    register_values =
      @instructions_file_path
      |> File.read!()
      |> Cpu.execute_instructions()

    signal_strengths = [20, 60, 100, 140, 180, 220]
    |> Enum.map(&Enum.at(register_values, &1 - 1) * &1)

    assert [420, 1140, 1800, 2940, 2880, 3960] == signal_strengths
    assert 13140 == Enum.sum(signal_strengths)
  end
end
