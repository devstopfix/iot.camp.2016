defmodule Thng.Server do
	
  use GenServer

  def start_link(mac) do
  	if IEEE.MAC.valid_mac_48?(mac) do
  		GenServer.start_link(__MODULE__, %{id: mac}, name: String.to_atom(mac))
  	else
       {:fail, :invalid_mac}
  	end
  end

  def init(state) do
  	{:ok, state}
  end

end