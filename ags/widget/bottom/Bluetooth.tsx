import { exec } from "astal";
import { EventBox, Label } from "astal/gtk3/widget";
import AstalBluetooth from "gi://AstalBluetooth?version=0.1";


export default function Bluetooth() {

  function openBlueman() {
    exec("blueman-manager")
  }

  return <box className="bottom-square bg-surface0" hexpand>
    <EventBox onClick={openBlueman} hexpand vexpand>
      <Label css="font-size: 20px" hexpand vexpand>{"\udb80\udcaf"}</Label>
    </EventBox>
  </box>
}
