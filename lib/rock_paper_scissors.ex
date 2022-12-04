defmodule AdventOfCode2022.RockPaperScissors do
  @win_points 6
  @draw_points 3
  @lose_points 0

  def calc_score(games_file_path) do
    games_file_path
    |> File.read!()
    |> String.split("\n")
    |> Enum.reduce(0, fn game, total_score ->
      score =
        game
        |> String.split(" ")
        |> Enum.reject(fn
          "" -> true
          _ -> false
        end)
        |> Enum.map(&common_game_values(&1))
        |> Enum.reverse()
        |> play()

      total_score + score
    end)
  end

  def calc_figured_out_score(games_file_path) do
    games_file_path
    |> File.read!()
    |> String.split("\n")
    |> Enum.reduce(0, fn game, total_score ->
      score =
        game
        |> String.split(" ")
        |> Enum.reject(fn
          "" -> true
          _ -> false
        end)
        |> Enum.map(&figured_game_values(&1))
        |> Enum.reverse()
        |> play()

      total_score + score
    end)
  end

  defp value_for("rock"), do: 1
  defp value_for("paper"), do: 2
  defp value_for("scissors"), do: 3

  defp common_game_values("A"), do: "rock"
  defp common_game_values("B"), do: "paper"
  defp common_game_values("C"), do: "scissors"
  defp common_game_values("X"), do: "rock"
  defp common_game_values("Y"), do: "paper"
  defp common_game_values("Z"), do: "scissors"

  defp figured_game_values("A"), do: "rock"
  defp figured_game_values("B"), do: "paper"
  defp figured_game_values("C"), do: "scissors"
  defp figured_game_values("X"), do: "lose"
  defp figured_game_values("Y"), do: "draw"
  defp figured_game_values("Z"), do: "win"

  defp play([value, opponent_value]) when value == opponent_value,
    do: @draw_points + value_for(value)

  defp play(["paper" = value, "rock"]), do: @win_points + value_for(value)
  defp play(["rock" = value, "scissors"]), do: @win_points + value_for(value)
  defp play(["scissors" = value, "paper"]), do: @win_points + value_for(value)
  defp play(["lose", opponent]), do: play([lose(opponent), opponent])
  defp play(["draw", opponent]), do: play([draw(opponent), opponent])
  defp play(["win", opponent]), do: play([win(opponent), opponent])
  defp play([value, _]), do: @lose_points + value_for(value)
  defp play(_), do: 0

  defp lose("rock"), do: "scissors"
  defp lose("paper"), do: "rock"
  defp lose("scissors"), do: "paper"

  defp draw(value), do: value

  defp win("rock"), do: "paper"
  defp win("paper"), do: "scissors"
  defp win("scissors"), do: "rock"
end
