defmodule ScrabbleBot do
  @moduledoc """
  A bot for tallying scrabble scores in slack channels. Scrabble emoji must be
  in the form :scrabble_a:, :scrabble_b:, etc.
  """

  def tally(message) do
    message
    |> scan_for_matches
    |> Enum.map(fn([_full_match, letter]) -> points(letter) end)
    |> Enum.reduce(0, &(&1 + &2))
  end

  defp scan_for_matches(message) do
    Regex.scan(~r/:scrabble_([a-z]|blank*):/, message)
  end

  defp points("a"), do: 1
  defp points("b"), do: 3
  defp points("c"), do: 3
  defp points("d"), do: 2
  defp points("e"), do: 1
  defp points("f"), do: 4
  defp points("g"), do: 2
  defp points("h"), do: 4
  defp points("i"), do: 1
  defp points("j"), do: 8
  defp points("k"), do: 5
  defp points("l"), do: 1
  defp points("m"), do: 3
  defp points("n"), do: 1
  defp points("o"), do: 1
  defp points("p"), do: 3
  defp points("q"), do: 10
  defp points("r"), do: 1
  defp points("s"), do: 1
  defp points("t"), do: 1
  defp points("u"), do: 1
  defp points("v"), do: 1
  defp points("w"), do: 4
  defp points("x"), do: 8
  defp points("y"), do: 4
  defp points("z"), do: 10
  defp points(_any), do: 0

end
