# Nerves Weather Station

- Measure temperature
- Measure humidity
- Measure light
- Use Phoenix's LiveView to display readings

![nerves weather](/docs/nerves-weather.gif)
![nerves weather](/docs/circuit.jpg)

## Parts

- [DHT11 sensor temp/humidity](https://www.amazon.co.jp/gp/product/B010GXAH4E)
- [Photo-resistor sensor](https://www.amazon.co.jp/gp/product/B08B7QT1BV)
- RaspberryPi (with SD card)
- Breadboard & wires

## Usage (for me)

Refer to Makefile in firmware folder for common nerves commands.

build firmware: `mix firmware`

upload: `sh upload.sh` (if wifi is setup)

(don't forget to set your MIX_TARGET-- `export MIX_TARGET=rpi4`)

### UI Phoenix App

To compile assets, before building firmware, run `mix assets.deploy` from ui root folder.

## Thanks

- Thanks to [Jon Carstens](https://github.com/jjcarstens) for help with his [dht](https://github.com/jjcarstens/dht) library.
- The Nerves Slack community for help with various things
