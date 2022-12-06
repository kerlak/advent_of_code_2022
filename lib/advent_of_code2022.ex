defmodule AdventOfCode2022 do
  alias AdventOfCode2022.SupplyStacks
  alias AdventOfCode2022.Cleanup
  alias AdventOfCode2022.{Calories, RockPaperScissors, Rucksacks, SupplyStacks, Walkie}

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
end
