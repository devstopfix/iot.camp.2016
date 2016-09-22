defmodule Thng.Server do
	
  use GenServer

  def start_link(mac) do
  	if IEEE.MAC.valid_mac_48?(mac) do
  		GenServer.start_link(__MODULE__, %{id: mac}, name: String.to_atom(mac))
  	else
       {:fail, :invalid_mac}
  	end
  end

  # Utility

  def lookup(mac) do
  	case Process.whereis(String.to_atom(mac)) do
  	  nil -> false
  	  pid -> {:ok, pid}
  	end
  end

  def findOrCreate(mac) do
    case lookup(mac) do
      {:ok, pid} -> {:ok, pid}
      false      -> start_link(mac)
    end
  end

  # Callbacks

  def init(state) do
  	{:ok, state}
  end

  def updatedProperty(pid, name, measurement) do
    GenServer.cast(pid, {:update_property, name, measurement})
  end

  def getProperty(pid, name) do
    GenServer.call(pid, {:get_property, name})
  end

  # Callbacks

  def handle_cast({:update_property, name, measurement}, state) do
    new_state = Map.put(state, name, measurement)
    {:noreply, new_state}
  end

  def handle_call({:get_property, name}, _from, state) do
    case Map.get(state, name) do
      nil   -> {:reply, :missing, state}
      value -> {:reply, {:ok, value}, state}
    end
  end

  

end