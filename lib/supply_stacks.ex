defmodule AdventOfCode2022.SupplyStacks do
  @moduledoc false

  def last_crane(stack_file_path) do
    [str_stack, str_movements] =
      stack_file_path
      |> File.read!()
      |> String.split("\n\n")

    initial_stack = get_stack(str_stack)
    movements = String.split(str_movements, "\n")

    Enum.reduce(movements, initial_stack, fn movement, stack ->
      stack
      |> move(movement)
    end)
    |> Enum.reduce("", fn supplies, acc ->
      acc <> List.first(supplies)
    end)
  end

  def last_crane_with_9001(stack_file_path) do
    [str_stack, str_movements] =
      stack_file_path
      |> File.read!()
      |> String.split("\n\n")

    initial_stack = get_stack(str_stack)
    movements = String.split(str_movements, "\n")

    Enum.reduce(movements, initial_stack, fn movement, stack ->
      stack
      |> move_9001(movement)
    end)
    |> Enum.reduce("", fn supplies, acc ->
      acc <> List.first(supplies)
    end)
  end

  def get_stack(str) do
    str
    |> String.split("\n")
    |> Enum.drop(-1)
    |> Enum.map(fn char ->
      char
      |> to_charlist()
      |> Enum.chunk_every(4)
      |> Enum.map(&to_letters(&1))
    end)
    |> transpose_matrix()
    |> Enum.map(&Enum.reject(&1, fn item -> item == "" end))
  end

  def transpose_matrix([]), do: []
  def transpose_matrix([[] | _]), do: []

  def transpose_matrix(a) do
    [Enum.map(a, &hd/1) | transpose_matrix(Enum.map(a, &tl/1))]
  end

  defp to_letters(str) do
    str
    |> to_string()
    |> String.replace(" ", "")
    |> String.replace("[", "")
    |> String.replace("]", "")
  end

  defp move(stack, [0, _from, _to]), do: stack

  defp move(stack, [times, from, to]) do
    [item | from_list] = Enum.at(stack, from - 1)
    to_list = [item | Enum.at(stack, to - 1)]

    stack
    |> List.replace_at(from - 1, from_list)
    |> List.replace_at(to - 1, to_list)
    |> move([times - 1, from, to])
  end

  defp move(stack, str_movement) do
    Regex.scan(~r/\d+/, str_movement, [])
    |> List.flatten()
    |> Enum.map(&parse_int!(&1))
    |> then(&move(stack, &1))
  end

  defp move_9001(stack, [0, _from, _to]), do: stack

  defp move_9001(stack, [times, from, to]) do
    {items, from_list} = Enum.at(stack, from - 1) |> Enum.split(times)
    to_list = items ++ Enum.at(stack, to - 1)

    stack
    |> List.replace_at(from - 1, from_list)
    |> List.replace_at(to - 1, to_list)
  end

  defp move_9001(stack, str_movement) do
    Regex.scan(~r/\d+/, str_movement, [])
    |> List.flatten()
    |> Enum.map(&parse_int!(&1))
    |> then(&move_9001(stack, &1))
  end

  defp parse_int!(value) do
    case Integer.parse(value) do
      {value, ""} -> value
      error -> raise(error)
    end
  end
end
