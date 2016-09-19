defmodule PublishClientTest do
  use ExUnit.Case
  doctest PublishClient

  setup_all do
  	  {:ok, pid} = PublishClient.start_link(%{})
      PublishClient.connect(pid, [client_id: "iot-test", host: "localhost", port: 1883])
      {:ok, mqtt: pid}
  end

  #on_exit PublishClient.disconnect

  test "We can publish JSON to a topic", state do
  	pid = state[:mqtt]
    PublishClient.publish_json(pid, %{:hello=>"World"})
  end

end
