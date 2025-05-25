import { Variable } from "astal";
import { Gtk } from "astal/gtk3";
import { Label } from "astal/gtk3/widget";

export default function Date() {
  const dateString = Variable("00-00").poll(1000, "date +%d-%m")

  return <centerbox margin={8} marginBottom={16} className="pill" orientation={Gtk.Orientation.VERTICAL}>
    <Label>{dateString(v => v.split("-")[0])}</Label>
    <Label>{dateString(v => v.split("-")[1])}</Label>
    <Label xalign={0.45} margin={4} className="pill-icon">{"\uef37"}</Label>
  </centerbox>
}
