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



# Data format


## Sample

The IoT box or sensor will send periodic measurements in JSON format. Each device is identified by it's MAC address. Example:

```json
{           
  "MAC48":  "01:23:45:67:89:ab"       
  "measurements": {       
    "temperature": [ 21.0 , "C" ],
    "fan_1_speed": [ 3, "rpm" ],
    "fan_2_speed": [ 2, "rpm" ],
    "fan_3_speed": [ 1, "rpm" ],
    "pressure": [ 1068 ,"mbar" ]
    },        
  "recorded_at" 1473764952        
}           
```
NB `recorded_at` is optional

