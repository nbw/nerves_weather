defmodule NervesWeatherFirmware.Sensors.Temperature do
  @moduledoc """
  Read temp and humidity values from a DHT sensor.

  A wrapper for https://hexdocs.pm/dht/DHT.html
  """

  @sensor_pin 17
  @sensor_type :dht11

  @spec read() ::
          {:ok, %{temperature: float(), humidity: float()}}
          | {:error, %ArgumentError{}}
          | {:error, integer()}
  def read, do: read(@sensor_pin, @sensor_type)

  defdelegate read(pin, sensor), to: DHT
end
