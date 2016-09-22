defmodule Receiver do
  use Hulaaki.Client

  @qos   1
  @topic "IOT"
  @options [client_id: "iot-test", host: "localhost", port: 1883] 

  def on_subscribed_publish(options) do
  	IO.puts "Message received"
  	try do
	    msg = options[:message].message |> Poison.Parser.parse!
	    case Map.get(msg, "MAC48") do
	    	nil  -> IO.puts "Message has no MAC48"
	    	_mac -> forwardMessageToThng(msg)
	    end
	rescue
	  Poison.SyntaxError -> IO.puts "*BAD JSON"
	  e in RuntimeError  -> IO.puts e
	catch	
	  e -> IO.puts inspect(e)  		
  	end
  end

  def forwardMessageToThng(msg) do
  	mac48 = Map.get(msg, "MAC48")
  	thngPid = Thng.Server.findOrCreate(mac48)
  	Thng.Server.updatedProperty(thngPid, "pressure", get_in(msg, ["measurements", "pressure"]))
  	Thng.Server.updatedProperty(thngPid, "fan_1_speed", get_in(msg, ["measurements", "fan_1_speed"]))
  	Thng.Server.updatedProperty(thngPid, "fan_2_speed", get_in(msg, ["measurements", "fan_2_speed"]))
  	Thng.Server.updatedProperty(thngPid, "fan_3_speed", get_in(msg, ["measurements", "fan_3_speed"]))
  	Thng.Server.updatedProperty(thngPid, "temperature", get_in(msg, ["measurements", "temperature"]))
  end

end
