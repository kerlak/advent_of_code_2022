defmodule AdventOfCode2022 do
  alias AdventOfCode2022.{
    Calories,
    Cleanup,
    Cpu,
    Crt,
    Forest,
    Pathfinder,
    RockPaperScissors,
    Rope,
    Rucksacks,
    Shell,
    SimianShenanigan,
    SupplyStacks,
    Walkie
  }

  @moduledoc false

  def day_01 do
    %{
      part_01: Calories.get_top_elf_calories("lib/files/day_01/elves_calories.txt", 1),
      part_02: Calories.get_top_elf_calories("lib/files/day_01/elves_calories.txt", 3)
    }
  end

  def day_02 do
    %{
      part_01: RockPaperScissors.calc_score("lib/files/day_02/elves_rock_paper_scissors.txt"),
      part_02:
        RockPaperScissors.calc_figured_out_score("lib/files/day_02/elves_rock_paper_scissors.txt")
    }
  end

  def day_03 do
    %{
      part_01: Rucksacks.get_total_priority("lib/files/day_03/rucksacks_items.txt"),
      part_02: Rucksacks.get_total_groups_priority("lib/files/day_03/rucksacks_items.txt")
    }
  end

  def day_04 do
    %{
      part_01: Cleanup.get_fully_recleanings("lib/files/day_04/cleanup_pairs.txt"),
      part_02: Cleanup.get_overlap_recleanings("lib/files/day_04/cleanup_pairs.txt")
    }
  end

  def day_05 do
    %{
      part_01: SupplyStacks.last_crane("lib/files/day_05/stack.txt"),
      part_02: SupplyStacks.last_crane_with_9001("lib/files/day_05/stack.txt")
    }
  end

  def day_06 do
    signal = File.read!("lib/files/day_06/signal.txt")

    %{
      part_01: Walkie.get_marker_position(signal),
      part_02: Walkie.get_message_position(signal)
    }
  end

  def day_07 do
    commands = File.read!("lib/files/day_07/commands.txt")

    %{
      part_01: Shell.get_folders_size(commands, 100_000),
      part_02: Shell.get_size_to_remove_to_get(commands, 30_000_000)
    }
  end

  def day_08 do
    scan = File.read!("lib/files/day_08/forest.txt")

    %{
      part_01: Forest.count_visible_trees(scan),
      part_02: Forest.best_scenic_score(scan)
    }
  end

  def day_09 do
    movements = File.read!("lib/files/day_09/rope_movements.txt")

    %{
      part_01: Rope.count_tail_visited_positions(movements, 1),
      part_02: Rope.count_tail_visited_positions(movements, 9)
    }
  end

  def day_10 do
    instructions_str = File.read!("lib/files/day_10/cpu_instructions.txt")

    register_values = Cpu.execute_instructions(instructions_str)

    signal_strengths_sum =
      [20, 60, 100, 140, 180, 220]
      |> Enum.map(&(Enum.at(register_values, &1 - 1) * &1))
      |> Enum.sum()

    %{
      part_01: signal_strengths_sum,
      part_02: Crt.draw_frame(register_values) <> "\n"
    }
  end

  def day_11 do
    monkeys_notes = File.read!("lib/files/day_11/monkeys_notes.txt")

    monkey_business_level =
      monkeys_notes
      |> SimianShenanigan.play(:simple, 20)
      |> Enum.map(& &1.inspections)
      |> Enum.sort(:desc)
      |> Enum.take(2)
      |> Enum.reduce(&(&1 * &2))

    monkey_complex_business_level =
      monkeys_notes
      |> SimianShenanigan.play(:complex, 10_000)
      |> Enum.map(& &1.inspections)
      |> Enum.sort(:desc)
      |> Enum.take(2)
      |> Enum.reduce(&(&1 * &2))

    %{
      part_01: monkey_business_level,
      part_02: monkey_complex_business_level
    }
  end

  def day_12 do
    {map_01, start_positions_01, end_position_01} =
      "lib/files/day_12/map.txt"
      |> File.read!()
      |> Pathfinder.get_matrix()

    costs_part_01 = Pathfinder.a_star(map_01, start_positions_01)

    {map_02, start_positions_02, end_position_02} =
      "lib/files/day_12/map.txt"
      |> File.read!()
      |> String.replace("a", "S")
      |> Pathfinder.get_matrix()

    costs_part_02 = Pathfinder.a_star(map_02, start_positions_02)

    %{
      part_01: Pathfinder.get(costs_part_01, end_position_01),
      part_02: Pathfinder.get(costs_part_02, end_position_02)
    }
  end
end
