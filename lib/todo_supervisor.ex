defmodule TodoSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  # Using a callback module the callback module is more flexible with respect to hot-code reloading, allowing you to modify the list of children, without needing to restart the entire supervisor.
  def init(_arg) do
    Supervisor.init([
      Todo.Cache
    ], strategy: :one_for_one)

    # Supervisor.start_link(
    #   [
    #     %{
    #       id: Todo.Cache,
    #       start: {Todo.Cache, :start_link, [nil]}
    # } ],
    #   strategy: :one_for_one
    # )
  end
end

# iex -S mix
# Supervisor.start_link([Todo.Cache], strategy: :one_for_one)
# bob_list = Todo.Cache.server_process("bob_list")
# Todo.Server.entries(bob_list, ~D[2018-12-19])
# cache_pid = Process.whereis(Todo.Cache)
# Process.exit(cache_pid, :kill)