defmodule AdventOfCode2022.Cleanup do
  def get_fully_recleanings(cleanup_pairs_file_path) do
    cleanup_pairs_file_path
    |> File.read!()
    |> String.split("\n")
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(&get_cleanup_pair(&1))
    |> Enum.filter(&has_recleaning(&1))
    |> Enum.count()
  end

  def get_overlap_recleanings(cleanup_pairs_file_path) do
    cleanup_pairs_file_path
    |> File.read!()
    |> String.split("\n")
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(&get_cleanup_pair(&1))
    |> Enum.filter(&has_overlap(&1))
    |> Enum.count()
  end

  defp get_cleanup_pair(cleanup_pair) do
    cleanup_pair
    |> String.split(",")
    |> Enum.map(&get_sections(&1))
  end

  defp get_sections(range) do
    [from, to] = range
    |> String.split("-")
    |> Enum.map(&parse_int!(&1))

    Enum.to_list(from..to)
  end

  defp parse_int!(value) do
    case Integer.parse(value) do
      {value, ""} -> value
      error -> raise(error)
    end
  end

  defp has_recleaning([sections_a, sections_b]) do
    sections_a -- sections_b == [] || sections_b -- sections_a == []
  end

  defp has_overlap([sections_a, sections_b]) do
    sections_a -- sections_b != sections_a
  end
end
