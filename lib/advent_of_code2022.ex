defmodule AdventOfCode2022 do
  @moduledoc """
  Documentation for `AdventOfCode2022`.
  """

  def day_01_part_01 do
    get_sorted_elves_calories()
    |> List.first()
  end

  def day_01_part_02 do
    get_sorted_elves_calories()
    |> Enum.take(3)
    |> Enum.sum()
  end

  defp get_sorted_elves_calories() do
    "lib/files/elves_calories.txt"
    |> File.read!()
    |> String.split("\n\n")
    |> Enum.map(fn calories_str_list ->
      calories_str_list
      |> String.split("\n")
      |> Enum.reduce(0, fn calories_str, total_calories ->
        case Integer.parse(calories_str) do
          {calories_val, ""} -> calories_val + total_calories
          _ -> total_calories
        end
      end)
    end)
    |> Enum.sort()
    |> Enum.reverse()
  end
end
