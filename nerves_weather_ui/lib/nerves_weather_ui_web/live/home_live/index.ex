defmodule NervesWeatherUiWeb.HomeLive.Index do
  use Phoenix.LiveView

  def mount(_params, _, socket) do
    if connected?(socket), do: Process.send_after(self(), :update, 1000)

    socket =
      socket
      |> assign(:temperature, 0)
      |> assign(:timer, 0)

    {:ok, assign(socket, temperature: 0, humidity: 0, timer: 0, light: false)}
  end

  def handle_info(:update, %{assigns: %{timer: timer}} = socket) do
    Process.send_after(self(), :update, 250)

    %{temperature: t, humidity: h} = measure_temp()

    {:noreply,
     assign(socket, temperature: t, humidity: h, light: measure_light(), timer: timer + 1)}
  end

  def measure_temp do
    try do
      {:ok, %{temperature: _t, humidity: _h} = data} = NervesWeatherFirmware.temperature()
      data
    rescue
      _ -> %{temperature: 888, humidity: 999}
    end
  end

  def measure_light do
    try do
      NervesWeatherFirmware.light?()
    rescue
      _ -> true
    end
  end

  def display_mode(light) do
    if light do
      ""
    else
      "dark"
    end
  end
end
