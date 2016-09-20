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

  test "We can name a Thng process with it's MAC address" do
  	{:ok, pid} = Thng.Server.start_link("00:00:00:00:00:00")
  	assert Process.alive? pid
  	assert pid == Process.whereis(String.to_atom("00:00:00:00:00:00"))
  end

end