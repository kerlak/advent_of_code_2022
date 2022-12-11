defmodule AdventOfCode2022.Shell do
  @moduledoc false
  import AdventOfCode2022.Utils, only: [parse_int!: 1]

  @total_size 70_000_000

  def get_folders_size(commands, max_folder_size) do
    commands
    |> get_folders_size_with_path()
    |> Enum.filter(fn {_path, size} -> size < max_folder_size end)
    |> Enum.map(fn {_path, size} -> size end)
    |> Enum.sum()
  end

  def get_size_to_remove_to_get(commands, space) do
    sizes =
      commands
      |> get_folders_size_with_path()
      |> Enum.map(fn {_path, size} -> size end)
      |> Enum.sort(:desc)

    required_size = space - (@total_size - List.first(sizes))

    sizes
    |> Enum.reverse()
    |> Enum.find(fn size -> size >= required_size end)
  end

  def get_folders_size_with_path(commands) do
    tree =
      commands
      |> String.split("\n")
      |> execute_commands(%{"/" => %{}}, [])

    tree
    |> get_folder_paths()
    |> Enum.map(&{&1, get_nested_size(tree, &1)})
  end

  def execute_commands([], tree, _), do: tree

  def execute_commands(["$ cd " <> ".." | commands], tree, workdir) do
    {workdir, _} = Enum.split(workdir, -1)
    execute_commands(commands, tree, workdir)
  end

  def execute_commands(["$ cd " <> folder | commands], tree, workdir) do
    workdir = workdir ++ [folder]
    execute_commands(commands, tree, workdir)
  end

  def execute_commands(["$ ls" | commands], tree, workdir) do
    {items, commands} = Enum.split_while(commands, &(!is_user_command(&1)))
    tree = Enum.reduce(items, tree, &update_with(&2, &1, workdir))
    execute_commands(commands, tree, workdir)
  end

  defp is_user_command(command), do: String.starts_with?(command, "$")

  defp update_with(tree, "", _workdir), do: tree

  defp update_with(tree, "dir " <> folder, workdir) do
    update_in(tree, workdir, &Map.put(&1, folder, %{}))
  end

  defp update_with(tree, file, workdir) do
    [size, file_name] = String.split(file, " ")
    update_in(tree, workdir, &Map.put(&1, file_name, size))
  end

  def get_folder_paths(tree, path \\ []) do
    tree
    |> Map.to_list()
    |> Enum.reduce([], fn {key, value}, folders ->
      if folder?(value) do
        current_path = path ++ [key]
        nested = get_folder_paths(value, current_path)
        folders ++ nested ++ [current_path]
      else
        folders
      end
    end)
  end

  def get_nested_size(tree, path) do
    tree
    |> get_in(path)
    |> get_size()
  end

  def get_size(%{} = tree) do
    tree
    |> Map.to_list()
    |> Enum.reduce(0, fn {_key, value}, size ->
      size + get_size(value)
    end)
  end

  def get_size({_key, %{} = value}), do: get_size(value)
  def get_size(value), do: parse_int!(value)

  def folder?(%{}), do: true
  def folder?(_), do: false
end
