defmodule AdventOfCode2022.RockPaperScissorsTest do
  use ExUnit.Case
  alias AdventOfCode2022.RockPaperScissors

  test "get example score" do
    assert "lib/files/day_02/elves_rock_paper_scissors_test.txt"
           |> RockPaperScissors.calc_score() == 15
  end

  test "get figured out score" do
    assert "lib/files/day_02/elves_rock_paper_scissors_test.txt"
           |> RockPaperScissors.calc_figured_out_score() == 12
  end
end
