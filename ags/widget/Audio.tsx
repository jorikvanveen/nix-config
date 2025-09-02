import { AstalIO, exec, interval, Process, subprocess, timeout, Variable } from "astal"
import { Gtk } from "astal/gtk3";
import { Label, LevelBar, Overlay, Slider } from "astal/gtk3/widget";
import Wp from "gi://AstalWp";
import Mpris from "gi://AstalMpris";

function spawnCaptureProcess(loudness: Variable<number>): AstalIO.Process {
  return subprocess([
    "bash",
    "-c",
    "jack_capture -p system:monitor* -ws | ffmpeg -fflags nobuffer -f s16le -i - -filter_complex ebur128=peak=true -f null - 2>&1"
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

interface NiriWindow {
  id: number,
  title: string,
  app_id: string,
  pid: number,
  is_focused: boolean,
  is_floating: boolean,
  is_urgent: boolean
}

export default function Audio() {
  let loudness_10hz = new Variable(0);
  let captureProcess = spawnCaptureProcess(loudness_10hz)
  let spotifyId = new Variable<null | number>(null).poll(5000, () => {
    const windows = JSON.parse(exec(["niri", "msg", "-j", "windows"])) as NiriWindow[]
    const spotifyIdx = windows.findIndex(window => window.app_id == "Spotify")
    if (spotifyIdx < 0) return null
    return windows[spotifyIdx].id
  })

  let loudness_interpolated = new Variable(0).poll(1000 / 60, (prev) => {
    return prev - (prev - loudness_10hz.get()) / 5
  });

  const default_speaker_path = new Variable("").poll(1000, () => Wp.get_default()?.audio.get_default_speaker()?.path ?? "");
  default_speaker_path.subscribe(_ => {
    captureProcess.write("\n")
    captureProcess.kill()
    captureProcess = spawnCaptureProcess(loudness_10hz)
    try {
      exec(["playerctl", "-a", "pause"])
    } catch {}
  })

  let default_sink_volume = new Variable(0).poll(1000, () => Wp.get_default()?.audio.get_default_speaker()?.get_volume() ?? 0)


  function onVolumeDragged(slider: Slider) {
    Wp.get_default()?.audio.get_default_speaker()?.set_volume(slider.get_value())
  }

  const spotify = Mpris.Player.new("spotify")
  const cover_url = Variable("");
  const playback_status = Variable(false);

  interval(1000, () => {
    if (spotify.available) {
      cover_url.set(spotify.get_cover_art())
      playback_status.set(spotify.get_playback_status() == Mpris.PlaybackStatus.PLAYING)
    }
  })

  function openSpotify() {
    const id = spotifyId.get()
    if (id) {
      exec(["niri", "msg", "action", "focus-window", "--id", id.toString()])
    }
  }

  function spotifyPlay() {
    playback_status.set(true)
    if (spotify.available) {
      spotify.play()
    }
  }

  function spotifyPause() {
    playback_status.set(false)
    if (spotify.available) {
      spotify.pause()
    }
  }

  const bar = <LevelBar
    widthRequest={1}
    height_request={100}
    className="audiolevel"
    orientation={Gtk.Orientation.VERTICAL}
    inverted
    value={loudness_interpolated(v => v)}
  />

  bar.remove_offset_value("full")
  bar.add_offset_value("full", 0.99)

  bar.remove_offset_value("high")
  bar.add_offset_value("high", 0.8)

  bar.add_offset_value("low", 0.5)

  return <box orientation={Gtk.Orientation.VERTICAL}>
    <centerbox
      height_request={150}
      hexpand
      className="audio-container"
      css={cover_url(url => `background-image: url('${url}'); background-position: center center; background-size: cover`)}
    >
      <centerbox hexpand className="mpris-cover-overlay">
        <Overlay hexpand>
          {bar}
          <Slider
            height_request={80}
            className="volume-slider"
            onDragged={onVolumeDragged}
            value={default_sink_volume()}
            orientation={Gtk.Orientation.VERTICAL}
            inverted
          />
        </Overlay>
      </centerbox>
    </centerbox>

    {playback_status(status => status ? <button onClick={spotifyPause} className="audio-playbutton">{"\uf04c"}</button> : <button onClick={spotifyPlay} className="audio-playbutton">{"\udb81\udc0a"}</button>)}
    <button className="audio-playbutton" onClick={openSpotify}><Label xalign={0.40}>{"\uf1bc"}</Label></button>
  </box>
}
