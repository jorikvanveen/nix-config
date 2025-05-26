import { interval, Variable } from "astal";
import { CircularProgress, EventBox, Label } from "astal/gtk3/widget";
import AstalBattery from "gi://AstalBattery?version=0.1";

export default function Battery() {
  const battery = AstalBattery.get_default()
  const hasBattery = new Variable(false)

  const percentage = new Variable(0);

  interval(5000, () => {
    percentage.set(battery.get_percentage())
    hasBattery.set(battery.isPresent)
    console.log(battery.isPresent)
    console.log(battery.get_charging())
    AstalBattery.Type.WEARABLE
  })
  
  return hasBattery(v => v ? <box className="bottom-square bg-surface0" hexpand>
    <EventBox hexpand vexpand>
      <CircularProgress />
      *<Label css="font-size: 20px" hexpand vexpand xalign={0.40}>{percentage(v => v.toString())}</Label>
    </EventBox>
  </box> : <></>)
}
