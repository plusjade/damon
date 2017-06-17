import IconPause              from 'ace/ui/IconPause'
import IconPlay               from 'ace/ui/IconPlay'
import IconRecord             from 'ace/ui/IconRecord'

const Recorder = (props) => {
  function formatTime(milliseconds) {
    return (milliseconds/1000.0).toFixed(1)
  }

  return (
    <div>
      <div
        style={{
          display: "inline-block",
          width: "10%",
          boxSizing: "border-box",
          padding: "10px",
          verticalAlign: "top"
        }}
        onClick={(e) => {
          e.preventDefault()
          if (props.isPaused) {
            props.record()
          }
          else {
            props.pause()
          }
        }}
      >
        {props.isPaused ? <IconRecord /> : <IconPause />}
      </div><div
        style={{
          display: "inline-block",
          boxSizing: "border-box",
          padding: "10px",
          verticalAlign: "top",
          textAlign: "center",
          color: "#FFF"
      }}>
        <span>
          {`${formatTime(props.timePosition)}`}
        </span>
      </div>
      <div
        style={{
          display: "inline-block",
          width: "10%",
          boxSizing: "border-box",
          padding: "10px",
          verticalAlign: "top",
          color: "#FFF"
        }}
      >
      hi
      </div>
      <div
        style={{
          display: "inline-block",
          width: "10%",
          boxSizing: "border-box",
          padding: "10px",
          verticalAlign: "top",
          color: "#FFF"
        }}
      >
        -
      </div>
    </div>
  )
}

export default Recorder
