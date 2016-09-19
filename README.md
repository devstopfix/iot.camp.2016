# IotCamp

# MQTT broker

Start with:

    vagrant up


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `iot_camp` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:iot_camp, "~> 0.1.0"}]
    end
    ```

  2. Ensure `iot_camp` is started before your application:

    ```elixir
    def application do
      [applications: [:iot_camp]]
    end
    ```

# MQTT Elixir Client

See usage at:  [hulaaki](https://github.com/suvash/hulaaki)
