defmodule ReceiverTest do
  use ExUnit.Case
  doctest Receiver

  setup do
  	  {:ok, r} = Receiver.start_link(%{})
      Receiver.connect(r, [client_id: "iot-receiver", host: "localhost", port: 1883])

  	  {:ok, p} = PublishClient.start_link(%{})
      PublishClient.connect(p, [client_id: "iot-publisher", host: "localhost", port: 1883])

      #on_exit fn -> Receiver.disconnect(r) end

      {:ok, %{pub: p, rec: r}}
  end

  test "We can subscribe to a topic", state do
    id = :rand.uniform(32767)
  	pid = state[:pub]
    Receiver.subscribe(pid, [id: id, topics: ["IOT"], qoses: [1]])
  end

  test "We can retrieve a JSON message from a topic", state do
    id = :rand.uniform(32767)
    Receiver.subscribe(state[:rec], [id: id, topics: ["IOT"], qoses: [1]])
    PublishClient.publish_json(state[:pub], %{:hello=>"World"})
    PublishClient.disconnect(state[:pub])
  end

end
