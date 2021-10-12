import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :nerves_weather_ui, NervesWeatherUiWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "G1D2yC7otReCmnpLpjhtovph5ZByfwnXZCeiXB+rlmqWdDMMGmfLN55JsIJYWsaQ",
  server: false

# In test we don't send emails.
config :nerves_weather_ui, NervesWeatherUi.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
