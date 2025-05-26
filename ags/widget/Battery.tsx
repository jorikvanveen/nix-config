import { CircularProgress, Overlay } from "astal/gtk3/widget";
import { CenterBox } from "astal/gtk3/widget";

const battery_icons = [
  "\udb80\udc8e"
];
export default function Battery() {
  return <box margin={4}><Overlay className="battery">
    <CircularProgress className={"progress"} startAt={0.25} endAt={0.25} value={0.95} expand />
    <CenterBox className={"battery_icon"}>{battery_icons[0]}</CenterBox>
  </Overlay>
  </box>

}
