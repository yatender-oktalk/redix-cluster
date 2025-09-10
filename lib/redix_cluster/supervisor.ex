defmodule RedixCluster.Supervisor do
  @moduledoc false

  use Supervisor

  @spec start_link() :: Supervisor.on_start()
  def start_link() do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    children = [
      {RedixCluster.Pools.Supervisor, [name: RedixCluster.Pools.Supervisor]},
      {RedixCluster.Monitor, [name: RedixCluster.Monitor]}
    ]

    slot_cache_num = RedixCluster.SlotCache.process_num()

    slot_cache_children =
      Enum.map(1..slot_cache_num, fn x ->
        name = RedixCluster.SlotCache.process_name(x)
        Supervisor.child_spec({RedixCluster.SlotCache, name}, id: name)
      end)

    Supervisor.init(children ++ slot_cache_children, strategy: :one_for_one)
  end
end
