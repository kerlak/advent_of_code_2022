defmodule AdventOfCode2022.Calories do
  @moduledoc false

  defp get_sorted_elves_calories(calories_file_path) do
    calories_file_path
    |> File.read!()
    |> String.split("\n\n")
    |> Enum.map(
      &(&1
        |> String.split("\n")
        |> Enum.reduce(0, fn calories_str, total_calories ->
          case Integer.parse(calories_str) do
            {calories_val, ""} -> calories_val + total_calories
            _ -> total_calories
          end
        end))
    )
    |> Enum.sort()
    |> Enum.reverse()
  end

  def get_top_elf_calories(calories_file_path, top_size) do
    calories_file_path
    |> get_sorted_elves_calories()
    |> Enum.take(top_size)
    |> Enum.sum()
  end
end
