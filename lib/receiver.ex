defmodule Receiver do
  use Hulaaki.Client

  @qos   1
  @topic "IOT"
  @options [client_id: "iot-test", host: "localhost", port: 1883] 

  def on_subscribed_publish(options) do
  	try do
	    options[:message].message |> Poison.Parser.parse!
	rescue
	  e -> IO.inspect e  	
	catch	
	  e -> IO.inspect e  		
  	end
  end

end
