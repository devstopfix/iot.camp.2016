defmodule PublishClient do
  use Hulaaki.Client

  @qos   1
  @topic "IOT"
  @options [client_id: "iot-test", host: "localhost", port: 1883]

  def on_connect_ack(options) do
    # IO.inspect options
  end

  def on_subscribed_publish(options) do
    # IO.inspect options
  end

  def on_subscribe_ack(options) do
    # IO.inspect options
  end

  def on_pong(options) do
    IO.inspect options
  end

  @doc """
  Test with:

      {:ok, pid} = PublishClient.start_link(%{})
      PublishClient.connect(pid, [client_id: "iot-test", host: "localhost", port: 1883])

      PublishClient.subscribe(pid, [id: 24_756, topics: ["IOT"], qoses: [1]])

      PublishClient.publish_json(pid, %{:hello=>"World"})

  """
  def publish_json(pid, msg_data) do
    msg_json = Poison.encode!(msg_data)
    options = [id: 9_347, 
               topic: @topic, 
               message: msg_json,
               dup: 0, 
               qos: @qos, 
               retain: 1]
    publish(pid, options)
  end
end
