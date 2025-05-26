import { exec, Variable } from "astal"
import { Gtk } from "astal/gtk3";
import { EventBox, Label } from "astal/gtk3/widget";

export default function Power() {
  const expanded = new Variable(true);

  function shutdown() {
    exec(["shutdown", "now"])
  }

  function restart() {
    exec(["reboot"])
  }

  function lock() {
    exec(["swaylock"])
  }

  return <box orientation={Gtk.Orientation.VERTICAL} className="power-container">
    <centerbox hexpand orientation={Gtk.Orientation.VERTICAL}>
      <revealer revealChild={expanded()}>
        <centerbox marginBottom={10} marginTop={10} orientation={Gtk.Orientation.VERTICAL}>
          <EventBox onClick={lock}>
            <Label
              justify={Gtk.Justification.CENTER}
              xalign={0.50}
              vexpand
              heightRequest={35}
              css="font-size: 28px"
            >{"\udb80\udf3e"}</Label>
          </EventBox>
          <EventBox onClick={restart}>
            <Label
              vexpand
              heightRequest={35}
              justify={Gtk.Justification.CENTER}
              yalign={1}
              xalign={0.50}
              css="font-size: 32px; margin-top: -4px"
            >{"\udb81\udf09"}</Label>
          </EventBox>
          <EventBox onClick={shutdown}>
            <Label
              vexpand
              heightRequest={35}
              justify={Gtk.Justification.CENTER}
              xalign={0.41}
            >{"\uf011"}</Label>
          </EventBox>
        </centerbox>
      </revealer>
    </centerbox>
    <EventBox onClick={() => expanded.set(!expanded.get())} heightRequest={35} widthRequest={35}>
      <Label
        justify={Gtk.Justification.CENTER}
        xalign={expanded(v => v ? 0.30 : 0.38)}
        setup={self => self.hook(expanded, (self, v) => self.toggleClassName("power-expanded", v))}
        className={expanded(v => v ? "power-expanded" : "")}
        hexpand
        vexpand
      >{expanded(v => v ? "\uf467" : "\uf011")}</Label>
    </EventBox>
  </box>
}
