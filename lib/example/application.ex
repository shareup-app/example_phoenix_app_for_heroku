defmodule Example.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Example.NodeMonitor,
      {Cluster.Supervisor,
       [Application.get_env(:libcluster, :topologies), [name: Example.ClusterSupervisor]]},
      Example.Repo,
      ExampleWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Example.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    ExampleWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
