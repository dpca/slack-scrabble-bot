defmodule ScrabbleBot.Slack do
  use Slack

  def handle_connect(slack, state) do
    IO.puts "Connected as #{slack.me.name}"
    {:ok, state}
  end

  def handle_event(message = %{type: "message"}, _slack, state) do
    IO.puts "Got message #{message.text}"
    {:ok, state}
  end
  def handle_event(_, _, state), do: {:ok, state}
end
