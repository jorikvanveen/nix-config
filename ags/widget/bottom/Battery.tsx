import { interval, Variable } from "astal";
import { CircularProgress, EventBox, Label, Overlay } from "astal/gtk3/widget";
import AstalBattery from "gi://AstalBattery?version=0.1";

const icons = [
  "\udb80\udc8e",
  "\udb80\udc7a",
  "\udb80\udc7b",
  "\udb80\udc7c",
  "\udb80\udc7d",
  "\udb80\udc7e",
  "\udb80\udc7f",
  "\udb80\udc80",
  "\udb80\udc81",
  "\udb80\udc82",
  "\udb80\udc79",
];

export default function Battery() {
  const battery = AstalBattery.get_default()
  const charging = new Variable(false)
  const hasBattery = new Variable(false)
  const percentage = new Variable(0);

  interval(3000, () => {
    percentage.set(battery.get_percentage())
    hasBattery.set(battery.get_is_present())
    charging.set(battery.get_charging())
  })

  const icon = Variable.derive([charging, percentage], (c, p) => {
    if (c) return "\udb80\udc84";
    return icons[Math.round(p * 10)]
  })

  return <>{hasBattery(v => v ? <box className="bottom-square bg-surface0" hexpand>
    <EventBox hexpand vexpand>
      <Overlay>
        <CircularProgress startAt={0.25} endAt={0.25} css="font-size: 2px" value={percentage()}/>
        <Label
          css="font-size: 20px"
          hexpand
          vexpand
          xalign={0.50}
        >{icon()}</Label>
      </Overlay>
    </EventBox>
  </box> : <></>)}</>
}
