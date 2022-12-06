defmodule AdventOfCode2022.WalkieTest do
  use ExUnit.Case
  alias AdventOfCode2022.Walkie
  doctest Walkie

  test "get marker position from signal" do
    assert Walkie.get_marker_position("mjqjpqmgbljsphdztnvjfqwrcgsmlb") == 7
    assert Walkie.get_marker_position("bvwbjplbgvbhsrlpgdmjqwftvncz") == 5
    assert Walkie.get_marker_position("nppdvjthqldpwncqszvftbrmjlhg") == 6
    assert Walkie.get_marker_position("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 10
    assert Walkie.get_marker_position("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 11
  end

  test "get message position from signal" do
    assert Walkie.get_message_position("mjqjpqmgbljsphdztnvjfqwrcgsmlb") == 19
    assert Walkie.get_message_position("bvwbjplbgvbhsrlpgdmjqwftvncz") == 23
    assert Walkie.get_message_position("nppdvjthqldpwncqszvftbrmjlhg") == 23
    assert Walkie.get_message_position("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 29
    assert Walkie.get_message_position("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 26
  end
end
