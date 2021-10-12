# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
import Config

# Enable the Nerves integration with Mix
Application.start(:nerves_bootstrap)

config :nerves_weather_firmware, target: Mix.target()

# Customize non-Elixir parts of the firmware. See
# https://hexdocs.pm/nerves/advanced-configuration.html for details.

config :nerves, :firmware, rootfs_overlay: "rootfs_overlay"

# Set the SOURCE_DATE_EPOCH date for reproducible builds.
# See https://reproducible-builds.org/docs/source-date-epoch/ for more information

config :nerves, source_date_epoch: "1632057078"

# Use Ringlogger as the logger backend and remove :console.
# See https://hexdocs.pm/ring_logger/readme.html for more information on
# configuring ring_logger.

config :nerves_ssh,
  authorized_keys: [
    File.read!(Path.join(System.user_home!(), ".ssh/id_rsa.pub"))
  ]

config :nerves_firmware_ssh,
  authorized_keys: [
    File.read!(Path.join(System.user_home!(), ".ssh/id_rsa.pub"))
  ]

config :logger, backends: [RingLogger]

config :vintage_net,
  default_config: [
    {"wlan0",
     %{
       type: VintageNetWiFi,
       vintage_net_wifi: %{
         networks: [
           %{
             key_mgmt: :wpa_psk,
             ssid: "",
             psk: ""
           }
         ]
       },
       ipv4: %{method: :dhcp}
     }}
  ]

# Phoenix
#
import_config "../../nerves_weather_ui/config/config.exs"
import_config "../../nerves_weather_ui/config/prod.exs"

config :nerves_weather_ui, NervesWeatherUiWeb.Endpoint,
  # Nerves root filesystem is read-only, so disable the code reloader
  code_reloader: false,
  http: [ip: {0, 0, 0, 0}, port: 80],
  # Use compile-time Mix config instead of runtime environment variables
  load_from_system_env: false,
  # Start the server since we're running in a release instead of through `mix`
  server: true,
  url: [host: "nerves.local", port: 80],
  # live_view: [signing_salt: "3J2S31Z1"],
  secret_base_key: "pWTILdXT+8RMPzUrmGPrxPI1dbj24tALEuYBm3HsJJ2DyDNUAax02JM23CgfxFEF",
  cache_static_manifest: "priv/static/cache_manifest.json",
  watchers: []

if Mix.target() == :host or Mix.target() == :"" do
  import_config "host.exs"
else
  import_config "target.exs"
end
