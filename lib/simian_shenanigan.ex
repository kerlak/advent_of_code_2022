defmodule AdventOfCode2022.SimianShenanigan do
  @moduledoc false
  alias AdventOfCode2022.SimianShenanigan.Monkey

  def simple_worry_management(), do: fn v -> div(v, 3) end

  def complex_worry_management(monkeys) do
    modular_product = Enum.reduce(monkeys, 1, &(&1.test_division_by * &2))

    fn v ->
      rem(v, modular_product)
    end
  end

  def play(monkey_notes, worry_level, rounds) do
    monkeys =
      monkey_notes
      |> String.split("\n\n", trim: true)
      |> Enum.map(&Monkey.from_note(&1))

    worry_management =
      case worry_level do
        :simple -> simple_worry_management()
        :complex -> complex_worry_management(monkeys)
      end

    Enum.reduce(1..rounds, monkeys, fn _round, monkeys_playing ->
      play_round(monkeys_playing, worry_management)
    end)
  end

  defp play_round(monkeys, worry_management) do
    Enum.reduce(0..(length(monkeys) - 1), monkeys, fn monkey_id, monkeys_playing ->
      monkey_index = Enum.find_index(monkeys_playing, &(&1.id == monkey_id))

      {monkey, throwable_items} =
        monkeys_playing
        |> Enum.at(monkey_index)
        |> Monkey.play(worry_management)

      monkeys_playing
      |> List.replace_at(monkey_index, monkey)
      |> throw_items(throwable_items)
    end)
  end

  defp throw_items(monkeys, items) do
    Enum.reduce(items, monkeys, fn
      {item, to}, monkeys_playing ->
        monkey_index = Enum.find_index(monkeys_playing, &(&1.id == to))
        monkey = Enum.at(monkeys_playing, monkey_index)
        monkey_items = monkey.items ++ [item]
        List.replace_at(monkeys_playing, monkey_index, Map.put(monkey, :items, monkey_items))

      _, monkeys_playing ->
        monkeys_playing
    end)
  end
end

defmodule AdventOfCode2022.SimianShenanigan.Monkey do
  alias AdventOfCode2022.SimianShenanigan.Monkey
  import AdventOfCode2022.Utils, only: [parse_int: 1, parse_int!: 1]

  defstruct [
    :id,
    :items,
    :operation,
    :test_division_by,
    :test,
    :pass,
    :fail,
    :throw,
    :inspections
  ]

  def from_note(note) do
    note
    |> String.split("\n", trim: true)
    |> Enum.reduce(%Monkey{inspections: 0}, fn attribute, monkey ->
      attribute
      |> String.trim()
      |> set(monkey)
    end)
    |> set_throw_function()
  end

  def play(%Monkey{items: []} = monkey, _), do: {monkey, [{}]}

  def play(%Monkey{items: [playing_item | items]} = monkey, worry_management) do
    item =
      playing_item
      |> monkey.operation.()
      |> worry_management.()

    updated_monkey = %Monkey{monkey | items: items, inspections: monkey.inspections + 1}
    throwable_item = {item, monkey.throw.(item)}

    {updated_monkey, more_throwable_items} = play(updated_monkey, worry_management)
    {updated_monkey, [throwable_item | List.wrap(more_throwable_items)]}
  end

  defp set("Monkey " <> str_id, monkey),
    do: Map.put(monkey, :id, parse_int!(String.replace(str_id, ":", "")))

  defp set("Starting items: " <> str_items, monkey) do
    items =
      str_items
      |> String.split(",")
      |> Enum.map(&String.trim(&1))
      |> Enum.map(&parse_int!(&1))

    Map.put(monkey, :items, items)
  end

  defp set("Operation: " <> str_operation, monkey) do
    operation = compose_operation(str_operation)
    Map.put(monkey, :operation, operation)
  end

  defp set("Test: divisible by " <> str_value, monkey) do
    value = parse_int!(str_value)
    test = fn v -> rem(v, value) == 0 end

    monkey
    |> Map.put(:test, test)
    |> Map.put(:test_division_by, value)
  end

  defp set("If true: throw to monkey " <> id, monkey), do: Map.put(monkey, :pass, parse_int!(id))
  defp set("If false: throw to monkey " <> id, monkey), do: Map.put(monkey, :fail, parse_int!(id))

  defp set_throw_function(%Monkey{test: test, pass: pass, fail: fail} = monkey) do
    throw_function = fn v ->
      if test.(v) do
        pass
      else
        fail
      end
    end

    Map.put(monkey, :throw, throw_function)
  end

  defp compose_operation("new = old " <> str_operation) do
    [operator, value] = String.split(str_operation, " ", trim: true)

    operation =
      case operator do
        "+" -> fn a, b -> a + b end
        "-" -> fn a, b -> a - b end
        "*" -> fn a, b -> a * b end
        "/" -> fn a, b -> div(a, b) end
      end

    case parse_int(value) do
      {:error, _} -> fn v -> operation.(v, v) end
      {:ok, int_value} -> fn v -> operation.(v, int_value) end
    end
  end
end
