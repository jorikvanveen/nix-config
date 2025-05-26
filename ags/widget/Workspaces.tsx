import { subprocess, Variable } from "astal";
import { Gtk } from "astal/gtk3";

interface WorkspaceInfo {
  id: number,
  idx: number,
  name: string | null,
  is_focused: boolean, // This property is only changed on WorkspacesChanged event
  // not WorkspaceActivated
  active_window_id: number
}

export default function Workspaces() {
  const focused = new Variable(0);
  const workspaces = new Variable<WorkspaceInfo[]>([])
    .watch(["bash", "-c", "niri msg -j event-stream"], (eventString, prev) => {
      const event = JSON.parse(eventString.trim())

      if (event["WorkspacesChanged"]) {
        const newWorkspaces = event.WorkspacesChanged.workspaces as WorkspaceInfo[]
        newWorkspaces.forEach(ws => ws.is_focused ? focused.set(ws.id) : null)
        return newWorkspaces
      }

      if (event["WorkspaceActivated"]) {
        const id = event.WorkspaceActivated.id
        focused.set(id)
        return prev
      }
      return prev
    })


  function focusWorkspace(idx: number) {
    subprocess(["bash", "-c", `niri msg action focus-workspace ${idx}`])
  }

  return <box margin={4} orientation={Gtk.Orientation.VERTICAL}>
    {workspaces(allWorkspaces => allWorkspaces.sort((a, b) => a.idx - b.idx)
      .map(ws => (
        <button
          margin={2}
          height_request={20}
          width_request={20}
          onClick={() => focusWorkspace(ws.idx)}
          className="ws-btn"
          setup={self => {
            self.toggleClassName("active-ws", focused.get() == ws.id)
            self.hook(focused, ((_, v: number) => self.toggleClassName("active-ws", v == ws.id)))
          }}
        >
          {ws.idx}
        </button>
      )))}
  </box>
}
