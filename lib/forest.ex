defmodule AdventOfCode2022.Forest do
  @moduledoc false
  import AdventOfCode2022.Utils, only: [parse_int!: 1]

  def count_visible_trees(scan) do
    forest =
      scan
      |> String.split("\n")
      |> Enum.reject(&(&1 == ""))
      |> Enum.map(&String.split(&1, "", trim: true))
      |> Enum.map(&Enum.map(&1, fn v -> parse_int!(v) end))

    Enum.reduce(0..(length(forest) - 1), 0, fn y, trees ->
      x_range = 0..(length(Enum.at(forest, y)) - 1)

      trees +
        Enum.reduce(x_range, 0, fn x, x_trees ->
          if is_visible(forest, x, y) do
            x_trees + 1
          else
            x_trees
          end
        end)
    end)
  end

  def best_scenic_score(scan) do
    forest =
      scan
      |> String.split("\n")
      |> Enum.reject(&(&1 == ""))
      |> Enum.map(&String.split(&1, "", trim: true))
      |> Enum.map(&Enum.map(&1, fn v -> parse_int!(v) end))

    Enum.reduce(0..(length(forest) - 1), 0, fn y, score ->
      x_range = 0..(length(Enum.at(forest, y)) - 1)

      candidate_score =
        Enum.reduce(x_range, 0, fn x, x_score ->
          xy_score = calc_score(forest, x, y)

          if xy_score > x_score do
            xy_score
          else
            x_score
          end
        end)

      if candidate_score > score do
        candidate_score
      else
        score
      end
    end)
  end

  defp is_visible(_forest, x, y) when x == 0 or y == 0, do: true
  defp is_visible(forest, _x, y) when y == length(forest) - 1, do: true

  defp is_visible(forest, x, y) do
    if x == length(Enum.at(forest, y)) - 1 do
      true
    else
      is_visible_row_column(forest, x, y)
    end
  end

  defp is_visible_row_column(forest, x, y) do
    row = get_row(forest, x, y)
    column = get_column(forest, x, y)
    is_visible_in_row(row, x) or is_visible_in_row(column, y)
  end

  defp calc_score(forest, x, y) do
    row = get_row(forest, x, y)
    column = get_column(forest, x, y)
    {reversed_up, _} = Enum.split(column, y)
    up = Enum.reverse(reversed_up)
    {_, down} = Enum.split(column, y + 1)
    {reversed_left, _} = Enum.split(row, x)
    left = Enum.reverse(reversed_left)
    {_, right} = Enum.split(row, x + 1)
    tree_height = Enum.at(forest, y) |> Enum.at(x)

    vision = [up, down, left, right]

    scores =
      Enum.map(vision, fn orientation ->
        Enum.reduce_while(orientation, 0, fn height, score ->
          if height < tree_height do
            {:cont, score + 1}
          else
            {:halt, score + 1}
          end
        end)
      end)

    Enum.reduce(scores, fn score, total_score ->
      total_score * score
    end)
  end

  defp get_row(forest, _x, y) do
    Enum.at(forest, y)
  end

  defp get_column(forest, x, _y) do
    Enum.reduce(forest, [], fn row, column ->
      column ++ [Enum.at(row, x)]
    end)
  end

  defp is_visible_in_row(row, position) do
    {left, _} = Enum.split(row, position)
    {_, right} = Enum.split(row, position + 1)
    value = Enum.at(row, position)
    Enum.all?(left, &(&1 < value)) or Enum.all?(right, &(&1 < value))
  end
end
