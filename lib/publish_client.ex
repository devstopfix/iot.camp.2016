defmodule PublishClient do
  use Hulaaki.Client

  @options [client_id: "iot-test", host: "localhost", port: 1883]

  def on_connect_ack(options) do
    IO.inspect options
  end

  def on_subscribed_publish(options) do
    IO.inspect options
  end

  def on_subscribe_ack(options) do
    IO.inspect options
  end

  def on_pong(options) do
    IO.inspect options
  end


  def publish(pid) do
    options = [id: 9_347, topic: "IOT", message: "{}",
               dup: 0, qos: 1, retain: 1]
    publish(pid, options)
  end
end
