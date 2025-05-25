import { Variable } from "astal";
import { Gtk } from "astal/gtk3";
import { Label } from "astal/gtk3/widget";

export default function Date() {
  const dateString = Variable("00-00").poll(1000, "date +%H-%M")

  return <centerbox margin={8} marginTop={16} className="pill iconup" orientation={Gtk.Orientation.VERTICAL}>
    <Label margin={2} xalign={0.45} className="pill-icon">{"\udb82\udd54"}</Label>
    <Label>{dateString(v => v.split("-")[0])}</Label>
    <Label>{dateString(v => v.split("-")[1])}</Label>
  </centerbox>
}
