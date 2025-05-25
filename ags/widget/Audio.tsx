import { Variable } from "astal"
import { Gtk } from "astal/gtk3";
import { LevelBar, Overlay, Slider } from "astal/gtk3/widget";
import Wp from "gi://AstalWp";
import Astal30 from "gi://Astal";

interface Measurement {

}

export default function Audio() {
  let loudness_10hz = new Variable(0).watch(
    ["bash", "-c",
      "jack_capture -p system:* -ws | ffmpeg -fflags nobuffer -f s16le -i - -filter_complex ebur128=peak=true -f null - 2>&1"
    ], (out: string, prev) => {
      if (!out.startsWith("[Parsed_ebur128_0")) {
        return prev
      }

      const split_infos = out.split(" ").map(frag => frag.trim()).filter(frag => frag != "")
      const ftpk_index = split_infos.findIndex(frag => frag === "FTPK:");
      if (ftpk_index < 0) {
        return prev
      }

      try {
        let newValue = parseFloat(split_infos[ftpk_index + 1])

        if (!isFinite(newValue)) {
          return 0
        }

        if (newValue > 0) {
          return 1
        }

        return (newValue + 60) / 60
      } catch { }
      return 0
    })

  let loudness_interpolated = new Variable(0).poll(1000 / 144, (prev) => {
    return prev - (prev - loudness_10hz.get()) / 10
  });
  

  let default_sink_volume = new Variable(0).poll(1, () => Wp.get_default()?.audio.get_default_speaker()?.get_volume() ?? 0)
  

  function onVolumeDragged(slider: Slider) {
    Wp.get_default()?.audio.get_default_speaker()?.set_volume(slider.get_value())
  }

  const bar = <LevelBar
      margin={20}
      marginTop={4}
      widthRequest={5}
      className="audiolevel"
      orientation={Gtk.Orientation.VERTICAL}
      inverted
      value={loudness_interpolated(v => v)}
    />

  bar.remove_offset_value("full")
  bar.add_offset_value("full", 0.99)

  bar.remove_offset_value("high")
  bar.add_offset_value("high", 0.8)

  return <Overlay hexpand={false} halign={Gtk.Align.END}>
    {bar} 
    <Slider  className="volume-slider" onDragged={onVolumeDragged} value={default_sink_volume()} marginTop={10} marginBottom={10} orientation={Gtk.Orientation.VERTICAL} inverted />
  </Overlay>
}
