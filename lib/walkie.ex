defmodule AdventOfCode2022.Walkie do
  @marker_size 4
  @message_size 14

  def get_window_position(signal, window_size, pos \\ 0)

  def get_window_position(signal, window_size, pos)
      when is_list(signal) and length(signal) < pos - window_size - 1,
      do: nil

  def get_window_position(signal, window_size, pos) when is_list(signal) do
    from = pos
    to = pos + window_size - 1
    signal_window = Enum.slice(signal, from..to)

    if is_marker(signal_window) do
      pos + window_size
    else
      get_window_position(signal, window_size, pos + 1)
    end
  end

  def get_marker_position(signal) do
    signal
    |> to_charlist()
    |> get_window_position(@marker_size)
  end

  def get_message_position(signal) do
    signal
    |> to_charlist()
    |> get_window_position(@message_size)
  end

  defp is_marker(signal_window) do
    signal_window
    |> Enum.uniq()
    |> Enum.count() ==
      Enum.count(signal_window)
  end
end
