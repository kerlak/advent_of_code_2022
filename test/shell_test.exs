defmodule AdventOfCode2022.ShellTest do
  use ExUnit.Case, async: true
  alias AdventOfCode2022.Shell

  @commands_file_path "lib/files/day_07/commands_test.txt"
  @min_folder_size 100_000
  @free_space 30_000_000

  test "get total folders size" do
    size =
      @commands_file_path
      |> File.read!()
      |> Shell.get_folders_size(@min_folder_size)

    assert size == 95_437
  end

  test "get size to remove to get enought space to update" do
    size =
      @commands_file_path
      |> File.read!()
      |> Shell.get_size_to_remove_to_get(@free_space)

    assert size == 24_933_642
  end
end
