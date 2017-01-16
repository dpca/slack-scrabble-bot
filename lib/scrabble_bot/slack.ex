defmodule ScrabbleBot.Slack do
  @moduledoc """
  Handles interaction with slack real time messaging
  """

  use Slack

  def handle_connect(slack, state) do
    IO.puts "Connected as #{slack.me.name}"
    {:ok, state}
  end

  def handle_event(message = %{type: "message"}, _slack, state) do
    case ScrabbleBot.tally(message.text) do
      x when x > 0 ->
        IO.puts "Got message '#{message.text}', worth #{x} points"
      _ ->
        IO.puts "Got message '#{message.text}'"
    end
    {:ok, state}
  end
  def handle_event(_, _, state), do: {:ok, state}
end
