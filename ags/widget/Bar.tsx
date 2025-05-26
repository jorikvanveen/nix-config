import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable } from "astal"
import Date from "./Date"
import Battery from "./bottom/Battery"
import Audio from "./Audio"
import { DrawingArea, Label } from "astal/gtk3/widget"
import Workspaces from "./Workspaces"
import Time from "./Time"
import ReactivityTest from "./ReactivityTest"
import Power from "./bottom/Power"
import Bluetooth from "./bottom/Bluetooth"
import Network from "./bottom/Network"

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, BOTTOM } = Astal.WindowAnchor

  return <window
    className="Bar"
    gdkmonitor={gdkmonitor}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    anchor={TOP | LEFT | BOTTOM}
    application={App}>
    <centerbox orientation={Gtk.Orientation.VERTICAL} widthRequest={50}>
      <box orientation={Gtk.Orientation.VERTICAL}>
        <Label
          widthRequest={50}
          justify={Gtk.Justification.CENTER}
          hexpand
          halign={Gtk.Align.CENTER}
          className="nix-logo"
          xalign={0.23}
        >{"\udb84\udd05"}</Label>
        <centerbox vexpand halign={Gtk.Align.CENTER} valign={Gtk.Align.CENTER} orientation={Gtk.Orientation.VERTICAL}>
          <box marginTop={0} valign={Gtk.Align.END} height_request={200}>
            <Audio />
          </box>
        </centerbox>
      </box>
      <box orientation={Gtk.Orientation.VERTICAL}>
        <Date />
        <Workspaces />
        <Time />
      </box>
      <box valign={Gtk.Align.END} orientation={Gtk.Orientation.VERTICAL} >
        <box
          spacing={2}
          orientation={Gtk.Orientation.VERTICAL}
          css="padding: 2px 2px; margin: 0 6px; border-radius: 50px"
          className="bg-surface2"
        >
          <Battery />
          <Network />
          <Bluetooth />
        </box>
        <Power />
      </box>
    </centerbox>
  </window>
}
