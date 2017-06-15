import IconPause              from 'ace/ui/IconPause'
import IconRecord             from 'ace/ui/IconRecord'

const RecorderView = (props) => {
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
          width: "80%",
          boxSizing: "border-box",
          padding: "10px",
          verticalAlign: "top"
      }}>
        --
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
        <small>
          {`${formatTime(props.timePosition)}`}
        </small>

        <span onClick={() => { props.toggle() }}>
          toggle
        </span>
      </div>
    </div>
  )
}

export default RecorderView
