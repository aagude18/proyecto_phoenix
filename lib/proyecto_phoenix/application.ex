defmodule ProyectoPhoenix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ProyectoPhoenixWeb.Telemetry,
      ProyectoPhoenix.Repo,
      {DNSCluster, query: Application.get_env(:proyecto_phoenix, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ProyectoPhoenix.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ProyectoPhoenix.Finch},
      # Start a worker by calling: ProyectoPhoenix.Worker.start_link(arg)
      # {ProyectoPhoenix.Worker, arg},
      # Start to serve requests, typically the last entry
      ProyectoPhoenixWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ProyectoPhoenix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ProyectoPhoenixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
