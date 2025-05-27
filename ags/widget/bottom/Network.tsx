import { exec, interval, Variable } from "astal";
import { EventBox, Label } from "astal/gtk3/widget";
import AstalNetwork from "gi://AstalNetwork?version=0.1";

enum Connection {
  None,
  Wifi0,
  Wifi1,
  Wifi2,
  Wifi3,
  Wired
}

export default function Network() {
  const connection = new Variable(Connection.None);

  interval(1000, () => {
    const network = AstalNetwork.get_default();
    const wifi = network.get_wifi();
    const wired = network.get_wired();

    if (wifi && wifi.get_state() == AstalNetwork.DeviceState.ACTIVATED) {
      switch (true) {
        case wifi.strength < 20:
          connection.set(Connection.Wifi0)
          break
        case wifi.strength < 50:
          connection.set(Connection.Wifi1)
          break
        case wifi.strength < 70:
          connection.set(Connection.Wifi2)
          break
        default:
          connection.set(Connection.Wifi3)
          break
      }
      return
    }

    if (wired && wired.get_state() == AstalNetwork.DeviceState.ACTIVATED) {
      connection.set(Connection.Wired)
      return
    }

    connection.set(Connection.None)
  })

  const icon = connection(c => {
    switch (c) {
      case Connection.None:
        return "\udb82\udd2b"
      case Connection.Wifi0:
        return "\udb82\udd2f"
      case Connection.Wifi1:
        return "\udb82\udd22"
      case Connection.Wifi2:
        return "\udb82\udd25"
      case Connection.Wifi3:
        return "\udb82\udd28"
      case Connection.Wired:
        return "\uef44";
    }
  })

  function openNmtui() {
    exec(
      ["ghostty",
        "--command=nmtui-connect",
        "--window-decoration=none",
        "--confirm-close-surface=false",
        "--title=networkconfig"
      ])
  }

  return <box className="bottom-square bg-surface0" hexpand>
    <EventBox onClick={openNmtui} hexpand vexpand>
      <Label css="font-size: 20px" hexpand vexpand xalign={0.40}>{icon}</Label>
    </EventBox>
  </box>
}
