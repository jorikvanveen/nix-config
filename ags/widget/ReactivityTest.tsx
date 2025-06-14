import { interval, Variable } from "astal"

export default function ReactivityTest() {
  const status = Variable(false)

  interval(1000, () => status.set(!status.get()))

  return <box>
    <button className="ws-btn" setup={self => status.subscribe(v => self.toggleClassName("active-ws", v))}>a</button>
  </box>
}
