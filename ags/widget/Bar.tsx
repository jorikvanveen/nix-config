import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable } from "astal"
import Date from "./Date"
import Battery from "./Battery"
import Audio from "./Audio"
import { DrawingArea, Label } from "astal/gtk3/widget"
import Workspaces from "./Workspaces"
import Time from "./Time"
import ReactivityTest from "./ReactivityTest"

const time = Variable("").poll(1000, "date")

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, BOTTOM } = Astal.WindowAnchor

  return <window
    className="Bar"
    gdkmonitor={gdkmonitor}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    anchor={TOP | LEFT | BOTTOM}
    application={App}>
    <centerbox orientation={Gtk.Orientation.VERTICAL} widthRequest={50}>
      <box height_request={500} vexpand halign={Gtk.Align.CENTER} valign={Gtk.Align.START} orientation={Gtk.Orientation.VERTICAL}>
        <Label
          widthRequest={50}
          justify={Gtk.Justification.CENTER}
          hexpand
          halign={Gtk.Align.CENTER}
          className="nix-logo"
          xalign={0.23}
        >{"\udb84\udd05"}</Label>
        <box marginTop={20} valign={Gtk.Align.END} height_request={200}>
          <Audio />
        </box>
      </box>
      <box orientation={Gtk.Orientation.VERTICAL}>
        <Date />
        <Workspaces />
        <Time />
      </box>
      <box valign={Gtk.Align.END} orientation={Gtk.Orientation.VERTICAL} >
      </box>
    </centerbox>
  </window>
}
