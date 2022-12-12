defmodule AdventOfCode2022.Pathfinder do
  def get_matrix(matrix_str) do
    matrix =
      matrix_str
      |> String.split("\n", trim: true)
      |> Enum.map(fn row ->
        row
        |> String.split("", trim: true)
        |> Enum.map(&to_charlist(&1))
      end)

    start_positions = find_all(matrix, 'S')
    end_position = find(matrix, 'E')

    map =
      Enum.map(matrix, fn row ->
        Enum.map(row, fn
          'E' -> 'z' |> List.first()
          'S' -> 'a' |> List.first()
          value -> value |> List.first()
        end)
      end)

    {map, start_positions, end_position}
  end

  def a_star(matrix, starts) do
    {x_size, y_size} = get_range(matrix)

    costs =
      :infinity
      |> List.duplicate(x_size)
      |> List.duplicate(y_size)

    costs = Enum.reduce(starts, costs, fn start, acc_costs -> set(acc_costs, start, 0) end)

    step(starts, matrix, costs)
  end

  defp step(positions, matrix, costs, distance \\ 0)
  defp step([], _matrix, costs, _distance), do: costs

  defp step(positions, matrix, costs, distance) do
    {updated_costs, updated_positions} =
      Enum.reduce(positions, {costs, []}, fn position, acc ->
        {acc_costs, acc_positions} = acc
        {temporal_costs, new_positions} = expand(acc_costs, matrix, position, distance + 1)

        {temporal_costs, acc_positions ++ new_positions}
      end)

    step(updated_positions, matrix, updated_costs, distance + 1)
  end

  defp find(map, value), do: find_all(map, value) |> List.first()

  defp find_all(map, value) do
    Enum.reduce(0..(length(map) - 1), [], fn y, acc ->
      row = Enum.at(map, y)

      indexes =
        Enum.reduce(0..(length(row) - 1), [], fn x, row_acc ->
          if Enum.at(row, x) == value do
            row_acc ++ [{x, y}]
          else
            row_acc
          end
        end)

      acc ++ indexes
    end)
  end

  defp expand(costs, matrix, position, distance) do
    positions =
      position
      |> get_coordinates()
      |> Enum.filter(&(get(costs, &1) == :infinity and can_go(position, &1, matrix)))

    updated_costs =
      positions
      |> Enum.reduce(costs, &set(&2, &1, distance))

    {updated_costs, positions}
  end

  defp can_go(from, to, matrix), do: get(matrix, from) + 1 >= get(matrix, to)

  defp get_coordinates({x, y}) do
    [
      {x, y},
      {x, y + 1},
      {x, y - 1},
      {x + 1, y},
      {x - 1, y}
    ]
  end

  def get(_matrix, {x, y}) when x < 0 or y < 0, do: nil

  def get(matrix, {x, y} = _position) do
    case Enum.at(matrix, y, nil) do
      nil -> nil
      row -> Enum.at(row, x, nil)
    end
  end

  defp set(matrix, {x, y} = _position, value) do
    List.update_at(matrix, y, &List.replace_at(&1, x, value))
  end

  defp get_range(matrix) do
    case length(matrix) do
      0 ->
        {0, 0}

      y ->
        x =
          matrix
          |> Enum.at(0)
          |> length()

        {x, y}
    end
  end
end
