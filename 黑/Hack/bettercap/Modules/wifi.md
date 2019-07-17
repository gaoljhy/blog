wifi
======

The `wifi.*` modules work with a `WiFi interface supporting monitor(监控)` mode and packet injection and they are used to monitor and perform wireless attacks on 802.11.

The interface only needs to support monitor mode and packet injection, it'll be bettercap itself to switch it to the right mode, just make sure there aren't other processes using the same wifi interface.

Commands
=========

| command                      | description                                                                                                                                                            |
| ---------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `wifi.recon on/off`          | Start/Stop 802.11 wireless base stations discovery.                                                                                                                    |
| `wifi.recon BSSID`           | Set 802.11 base station address to filter for.                                                                                                                         |
| `wifi.recon clear`           | Remove the 802.11 base station filter.                                                                                                                                 |
| `wifi.deauth BSSID`          | Start a 802.11 deauth(缺乏) attack, if an access point BSSID is provided(开始), every client will be deauthenticated (缺乏), otherwise(除了) only the selected client. |
| `wifi.show`                  | Show current wireless stations list (default sorting by RSSI).                                                                                                         |
| `wifi.recon.channel CHANNEL` | Comma separated (分割) list of channels to hop on.                                                                                                                     |
| `wifi.recon.channel clear`   | Enable channel hopping(跳转) on all supported channels.                                                                                                                |
| `wifi.ap`                    | Inject fake management beacons(导航) in order to create a rogue(无赖) access point ( requires wifi.recon to run ).                                                     |

Parameters
===========

| parameter            | default        | description                                                                                                                                                                                   |
| -------------------- | -------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `wifi.hop.period`    | `250`          | If channel hopping is enabled (empty wifi.recon.channel), this is the time in millseconds the algorithm will hop on every channel (it'll be doubled if both 2.4 and 5.0 bands are available). |
| `wifi.source.file`   |                | If set, the wifi module will read from this pcap file instead of the hardware interface.                                                                                                      |
| `wifi.skip-broken`   | `true`         | If true, dot11 packets with an invalid(残缺) checksum will be skipped.                                                                                                                        |
| `wifi.ap.bssid`      | `<random mac>` | BSSID of the fake access point.                                                                                                                                                               |
| `wifi.ap.channel`    | `1`            | Channel of the fake access point.                                                                                                                                                             |
| `wifi.ap.encryption` | `true`         | If true, the fake access point will use WPA2, otherwise it'll result as an open AP.                                                                                                           |

-----------------------

Examples
=======

1. Starts bettercap on wlan0
    use the ticker and wifi.recon modules to create a WiFi scanner
    performing channel hopping on every supported frequency(频率)

    `sudo bettercap -iface wlan0`

    `set ticker.commands "clear; wifi.show";`
    `wifi.recon on;`
    `ticker on`

2. Only recon on channels 1, 2 and 3:

    `wifi.recon on;`
    `wifi.recon.channel 1,2,3`

3. Keep deauthing(拒绝) clients from the access point with BSSID
    `DE:AD:BE:EF:DE:AD` every five seconds:

    `set ticker.period 5;`
    `set ticker.commands "wifi.deauth DE:AD:BE:EF:DE:AD";`
    `ticker on`

4. send management beacons as the fake access point "Banana" with BSSID DE:AD:BE:EF:DE:AD on channel 5 without encryption:

    `set wifi.ap.ssid Banana`
    `set wifi.ap.bssid DE:AD:BE:EF:DE:AD`
    `set wifi.ap.channel 5`
    `set wifi.ap.encryption false`
    `wifi.recon on;`
    `wifi.ap`