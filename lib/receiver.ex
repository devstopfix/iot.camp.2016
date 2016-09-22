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
	    	_mac -> forward_message_to_process(msg)
	    end
	rescue
	  Poison.SyntaxError -> IO.puts "*BAD JSON"
	  e in RuntimeError  -> IO.puts e
	catch	
	  e -> IO.puts inspect(e)  		
  	end
  end

  def forward_message_to_process(_msg) do
  	
  end

end
