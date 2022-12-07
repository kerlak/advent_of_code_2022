defmodule AdventOfCode2022.Rucksacks do
  @moduledoc false

  def get_total_priority(rucksacks_file_path) do
    rucksacks_file_path
    |> File.read!()
    |> String.split("\n")
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(&get_priority(&1))
    |> Enum.sum()
  end

  def get_total_groups_priority(rucksacks_file_path) do
    rucksacks_file_path
    |> File.read!()
    |> String.split("\n")
    |> Enum.reject(&(&1 == ""))
    |> Enum.chunk_every(3)
    |> Enum.map(&get_group_priority(&1))
    |> Enum.sum()
  end

  defp get_priority(rucksack_string) do
    rucksack_string
    |> divide_compartments()
    |> get_common_item()
    |> get_value()
  end

  defp get_group_priority(group) do
    [rucksack_a, rucksack_b, rucksack_c] = Enum.map(group, &to_charlist(&1))

    rucksack_a
    |> get_common_items(rucksack_b)
    |> get_common_items(rucksack_c)
    |> Enum.uniq()
    |> List.first()
    |> get_value()
  end

  defp divide_compartments(rucksack_string) do
    rucksack_string
    |> String.length()
    |> div(2)
    |> then(&String.split_at(rucksack_string, &1))
  end

  defp get_common_item(compartments) do
    compartments
    |> then(fn {compartment_a, compartment_b} ->
      {a, b} = {to_charlist(compartment_a), to_charlist(compartment_b)}
      get_common_items(a, b)
    end)
    |> Enum.uniq()
    |> List.first()
  end

  defp get_common_items(a, b) when is_list(a) and is_list(b) do
    a -- a -- b
  end

  defp get_value(char) when is_integer(char) and char <= 91, do: char - 64 + 26
  defp get_value(char), do: char - 96
end
