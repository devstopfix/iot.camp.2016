defmodule Receiver do
  use Hulaaki.Client

  @qos   1
  @topic "IOT"
  @options [client_id: "iot-test", host: "localhost", port: 1883] 

  def on_subscribed_publish(options) do
    IO.inspect options
  end

end
