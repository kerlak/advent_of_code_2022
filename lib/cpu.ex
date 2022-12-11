defmodule AdventOfCode2022.Cpu do
  @moduledoc false
  import AdventOfCode2022.Utils, only: [parse_int!: 1]

  @x 1

  def execute_instructions(instructions_str) do
    instructions =
      instructions_str
      |> String.split("\n", trim: true)

    Enum.reduce(instructions, [@x], fn instruction, values ->
      reg = List.last(values)

      result =
        instruction
        |> String.split(" ")
        |> execute_instruction(reg)

      values ++ List.wrap(result)
    end)
  end

  defp execute_instruction(["noop"], reg), do: reg
  defp execute_instruction(["addx", value], reg), do: [reg, parse_int!(value) + reg]
end
