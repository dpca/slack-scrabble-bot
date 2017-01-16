defmodule ScrabbleBotTest do
  use ExUnit.Case
  doctest ScrabbleBot

  test "can tally a message" do
    assert ScrabbleBot.tally(":scrabble_a::scrabble_b::scrabble_c:") == 7
  end

  test "works with repeats" do
    assert ScrabbleBot.tally(":scrabble_a::scrabble_a::scrabble_a:") == 3
  end

  test "finds scrabble emoji within a message" do
    assert ScrabbleBot.tally("blah blah :scrabble_c: foo bar") == 3
  end

  test "tallies things it doesn't recognize as 0" do
    assert ScrabbleBot.tally(":scrabble_blank::scrabble_foo:ok") == 0
  end

  test "tallies messages with no scrabble as 0" do
    assert ScrabbleBot.tally("foo bar") == 0
  end
end
