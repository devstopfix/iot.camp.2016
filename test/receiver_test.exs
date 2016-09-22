defmodule ReceiverTest do
  use ExUnit.Case
  doctest Receiver

  setup_all do
  	  {:ok, r} = Receiver.start_link(%{})
      Receiver.connect(r, [client_id: "iot-receiver", host: "localhost", port: 1883])

  	  {:ok, p} = PublishClient.start_link(%{})
      PublishClient.connect(p, [client_id: "iot-publisher", host: "localhost", port: 1883])

      {:ok, %{pub: p, rec: r}}
  end

  test "We can subscribe to a topic", state do
  	pid = state[:pub]
    Receiver.subscribe(pid, [id: 24_756, topics: ["IOT"], qoses: [1]])
  end

  test "We can retrieve a JSON message from a topic", state do
    PublishClient.publish_json(state[:pub], %{:hello=>"World"})
    PublishClient.disconnect(state[:pub])

    Receiver.subscribe(state[:rec], [id: 24_756, topics: ["IOT"], qoses: [1]])
  end

end
