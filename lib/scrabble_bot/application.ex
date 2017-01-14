defmodule ScrabbleBot.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    slack_token = Application.get_env(:scrabble_bot, ScrabbleBot.Slack)[:api_token]

    # Define workers and child supervisors to be supervised
    children = [
      worker(Slack.Bot, [ScrabbleBot.Slack, [], slack_token])
      # Starts a worker by calling: ScrabbleBot.Worker.start_link(arg1, arg2, arg3)
      # worker(ScrabbleBot.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ScrabbleBot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
