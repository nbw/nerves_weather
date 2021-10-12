defmodule NervesWeatherFirmware.Sensors.Light do
  @moduledoc """
  Read photo resisitor (digital read).
  """
  use GenServer

  @sensor_pin 6

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def read do
    GenServer.call(__MODULE__, :read)
  end

  @impl true
  def init(_) do
    Circuits.GPIO.open(@sensor_pin, :input)
  end

  @impl true
  def handle_call(:read, _from, gpio) do
    {:reply, Circuits.GPIO.read(gpio), gpio}
  end
end
