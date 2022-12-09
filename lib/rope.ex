defmodule AdventOfCode2022.Rope do
  @moduledoc false

  def count_tail_visited_positions(movements_str, number_of_knots) do
    head = {0, 0}
    tails = List.duplicate(head, number_of_knots)

    movements =
      movements_str
      |> String.split("\n")
      |> Enum.reject(&(&1 == ""))
      |> Enum.map(&String.split(&1, " "))
      |> expand_movements()
      |> List.flatten()

    {_, head_positions} =
      Enum.reduce(movements, {head, [head]}, fn orientation, {head, positions} ->
        head = move(head, orientation)
        {head, positions ++ [head]}
      end)

    Enum.reduce(tails, head_positions, fn tail, positions ->
      {_, positions} =
        Enum.reduce(positions, {tail, [tail]}, fn position, {tail, positions} ->
          tail = maybe_move_closer(tail, position)
          {tail, positions ++ [tail]}
        end)

      positions
    end)
    |> Enum.uniq()
    |> Enum.count()
  end

  defp move({x, y}, "U"), do: {x, y + 1}
  defp move({x, y}, "D"), do: {x, y - 1}
  defp move({x, y}, "R"), do: {x + 1, y}
  defp move({x, y}, "L"), do: {x - 1, y}

  defp maybe_move_closer({tx, ty} = tail, {hx, hy} = head) do
    delta_x = abs(hx - tx)
    delta_y = abs(hy - ty)

    if delta_x > 1 or delta_y > 1 do
      move_closer(tail, head)
    else
      tail
    end
  end

  defp move_closer({tx, ty} = _tail, {hx, hy} = _head) when tx == hx and ty < hy, do: {tx, ty + 1}
  defp move_closer({tx, ty} = _tail, {hx, hy} = _head) when tx == hx and ty > hy, do: {tx, ty - 1}
  defp move_closer({tx, ty} = _tail, {hx, hy} = _head) when tx == hx and ty == hy, do: {tx, ty}
  defp move_closer({tx, ty} = _tail, {hx, hy} = _head) when tx < hx and ty == hy, do: {tx + 1, ty}
  defp move_closer({tx, ty} = _tail, {hx, hy} = _head) when tx > hx and ty == hy, do: {tx - 1, ty}

  defp move_closer({tx, ty} = _tail, {hx, hy} = _head) when tx < hx and ty < hy,
    do: {tx + 1, ty + 1}

  defp move_closer({tx, ty} = _tail, {hx, hy} = _head) when tx < hx and ty > hy,
    do: {tx + 1, ty - 1}

  defp move_closer({tx, ty} = _tail, {hx, hy} = _head) when tx > hx and ty < hy,
    do: {tx - 1, ty + 1}

  defp move_closer({tx, ty} = _tail, {hx, hy} = _head) when tx > hx and ty > hy,
    do: {tx - 1, ty - 1}

  defp expand_movements(movements) do
    Enum.map(movements, fn [orientation, times] ->
      List.duplicate(orientation, parse_int!(times))
    end)
  end

  defp parse_int!(value) do
    case Integer.parse(value) do
      {value, ""} -> value
      error -> raise(error)
    end
  end
end
