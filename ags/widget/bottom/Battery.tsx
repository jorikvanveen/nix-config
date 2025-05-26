import { EventBox, Label } from "astal/gtk3/widget";
import AstalBattery from "gi://AstalBattery?version=0.1";

export default function Battery() {
  const battery = AstalBattery.get_default()

  battery.get_percentage()
  
  return <box className="bottom-square bg-surface0" hexpand>
    <EventBox hexpand vexpand>
    {/*<Label css="font-size: 20px" hexpand vexpand xalign={0.40}>{icon}</Label>*/}
    </EventBox>
  </box>
}
