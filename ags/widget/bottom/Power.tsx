import { interval, Variable } from "astal"
import { Gtk } from "astal/gtk3";
import { Label } from "astal/gtk3/widget";

export default function Power() {
  const expanded = new Variable(false);
  interval(1000, () => expanded.set(!expanded.get()))
  return <box className="power-container">
    <Label justify={Gtk.Justification.CENTER} xalign={0.38} hexpand>{"\uf011"}</Label>
  </box>
}
