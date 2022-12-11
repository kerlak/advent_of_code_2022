defmodule AdventOfCode2022.Crt do
  @moduledoc false

  @wide 40
  @high 6

  def draw_frame(values) do
    empty_frame =
      " "
      |> List.duplicate(@wide)
      |> List.duplicate(@high)

    values
    |> Enum.take(@wide * @high)
    |> Enum.with_index()
    |> Enum.reduce(empty_frame, fn {value, cycle}, frame ->
      draw(cycle, value, frame)
    end)
    |> display()
  end

  defp display(frame) do
    frame
    |> Enum.map(&Enum.join(&1))
    |> Enum.join("\n")
  end

  defp draw(cycle, value, frame) do
    {x, y} = get_position(cycle)

    pixel =
      if abs(value - x) <= 1 do
        "#"
      else
        "."
      end

    updated_row =
      frame
      |> Enum.at(y)
      |> List.update_at(x, fn _ -> pixel end)

    List.update_at(frame, y, fn _ -> updated_row end)
  end

  defp get_position(cycle) do
    y = div(cycle, @wide)
    x = cycle - @wide * y
    {x, y}
  end
end
