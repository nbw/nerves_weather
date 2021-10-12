import Config

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
