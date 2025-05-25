import { AstalIO, interval, Process, subprocess, timeout, Variable } from "astal"
import { Gtk } from "astal/gtk3";
import { LevelBar, Overlay, Slider } from "astal/gtk3/widget";
import Wp from "gi://AstalWp";
import Mpris from "gi://AstalMpris";

interface Measurement {

}

function spawnCaptureProcess(loudness: Variable<number>): AstalIO.Process {
  return subprocess([
    "bash",
    "-c",
    "jack_capture -p system:* -ws | ffmpeg -fflags nobuffer -f s16le -i - -filter_complex ebur128=peak=true -f null - 2>&1"
  ], (out) => {
    if (!out.startsWith("[Parsed_ebur128_0")) {
      return
    }

    const split_infos = out.split(" ").map(frag => frag.trim()).filter(frag => frag != "")
    const ftpk_index = split_infos.findIndex(frag => frag === "FTPK:");
    if (ftpk_index < 0) {
      return
    }

    try {
      let newValue = parseFloat(split_infos[ftpk_index + 1])

      if (!isFinite(newValue)) {
        loudness.set(0)
        return
      }

      if (newValue > 0) {
        loudness.set(1)
        return
      }

      loudness.set((newValue + 60) / 60)
      return
    } catch { }
    loudness.set(0)
  })
}

export default function Audio() {
  let loudness_10hz = new Variable(0);
  let captureProcess = spawnCaptureProcess(loudness_10hz)

  let loudness_interpolated = new Variable(0).poll(1000 / 60, (prev) => {
    return prev - (prev - loudness_10hz.get()) / 10
  });

  const default_speaker_path = new Variable("").poll(1000, () => Wp.get_default()?.audio.get_default_speaker()?.path ?? "");
  default_speaker_path.subscribe(_ => {
     captureProcess.write("\n")
     captureProcess.kill()
     captureProcess = spawnCaptureProcess(loudness_10hz)
  })

  let default_sink_volume = new Variable(0).poll(1, () => Wp.get_default()?.audio.get_default_speaker()?.get_volume() ?? 0)


  function onVolumeDragged(slider: Slider) {
    Wp.get_default()?.audio.get_default_speaker()?.set_volume(slider.get_value())
  }

  const spotify = Mpris.Player.new("spotify")

  interval(1000, () => {
    console.log(spotify.get_cover_art())
  })

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
    <Slider className="volume-slider" onDragged={onVolumeDragged} value={default_sink_volume()} marginTop={10} marginBottom={10} orientation={Gtk.Orientation.VERTICAL} inverted />
  </Overlay>
}
