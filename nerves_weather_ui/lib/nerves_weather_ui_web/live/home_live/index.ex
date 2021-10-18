defmodule NervesWeatherUiWeb.HomeLive.Index do
  use Phoenix.LiveView

  # DHT refresh rate is 1s
  @refresh_rate 2000
  @refresh_light_rate 250

  def mount(_params, _, socket) do
    if connected?(socket) do
      Process.send_after(self(), :update, @refresh_rate)
      Process.send_after(self(), :update_light, @refresh_light_rate)
    end

    {:ok, assign(socket, default())}
  end

  def handle_info(:update, socket) do
    Process.send_after(self(), :update, @refresh_rate)
    %{temperature: t, humidity: h} = measure_temp()
    {:noreply, assign(socket, temperature: t, humidity: h)}
  end

  def handle_info(:update_light, socket) do
    Process.send_after(self(), :update_light, @refresh_light_rate)
    {:noreply, assign(socket, light: measure_light())}
  end

  def measure_temp do
    try do
      {:ok, %{temperature: _t, humidity: _h} = data} = NervesWeatherFirmware.temperature()
      data
    rescue
      _ -> %{temperature: 0, humidity: 0}
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

  def hide(socket) do
    if connected?(socket) do
      ""
    else
      "hide"
    end
  end

  defp default do
    %{temperature: t, humidity: h} = measure_temp()

    [temperature: t, humidity: h, light: measure_light()]
  end
end
