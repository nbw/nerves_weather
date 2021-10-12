defmodule NervesWeatherFirmware do
  @moduledoc false

  def temperature do
    NervesWeatherFirmware.Sensors.Temperature.read()
  end

  def light? do
    NervesWeatherFirmware.Sensors.Light.read() == 0
  end
end
