defmodule AdventOfCode2022 do
  alias AdventOfCode2022.Calories
  alias AdventOfCode2022.RockPaperScissors

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
end
