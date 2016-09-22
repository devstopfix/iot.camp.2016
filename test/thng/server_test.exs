defmodule Thng.ServerTest do
	
  use ExUnit.Case, async: true
  doctest Thng.Server

  test "Start a Thng process" do
  	{:ok, pid} = Thng.Server.start_link("00:00:00:00:00:00")
  	assert Process.alive? pid
  end

  test "Cannot start a Thng identified with invalid MAC address" do
  	{:fail, :invalid_mac} = Thng.Server.start_link("OU:CH")
  end

  test "We can name a Thng and retrive it by it's MAC address" do
  	mac = "00:00:00:00:00:00"
  	{:ok, pid} = Thng.Server.start_link(mac)
  	assert Process.alive? pid
  	assert pid == Process.whereis(String.to_atom(mac))
  end

  test "Lookup Thng by MAC - does not exist case" do
  	mac = "99:99:99:99:99:99"
  	false = Thng.Server.lookup(mac)
  end

  test "Lookup Thng by MAC - return pid" do
  	mac = "55:55:55:55:55:55"
  	{:ok, pid} = Thng.Server.start_link(mac)
  	{:ok, pid} = Thng.Server.lookup(mac)
  	assert Process.alive? pid
  end

  test "Thng can store a pressure" do
    {:ok, pid} = Thng.Server.start_link("00:00:00:00:00:00")
    :ok = Thng.Server.updatedProperty(pid, "pressure", 1000)
  end

  test "Thng can retrive a pressure" do
    {:ok, pid} = Thng.Server.start_link("00:00:00:00:00:00")
    :ok = Thng.Server.updatedProperty(pid, "pressure", 1000)
    {:ok, 1000} = Thng.Server.getProperty(pid, "pressure")
  end  

  test "Thng returns nil if it has no pressure" do
    {:ok, pid} = Thng.Server.start_link("00:00:00:00:00:00")
    :missing = Thng.Server.getProperty(pid, "pressure")
  end  

end