defmodule Communications.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Communications.Worker.start_link(arg)
      # {Communications.Worker, arg},
      supervisor(Communications.Repo, []),
      Plug.Adapters.Cowboy.child_spec(:http, Communications.Router, [], [port: 4001])
    ]

    Logger.info "Started application"

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Communications.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
