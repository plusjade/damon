import IconPause              from 'ace/ui/IconPause'
import IconPlay               from 'ace/ui/IconPlay'

const PlayerView = (props) => {
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
            props.play()
          } else if (props.timePosition >= props.timeDuration ) {
            props.replay()
          }
          else {
            props.pause()
          }
        }}
      >
        {props.isPaused ? <IconPlay /> : <IconPause />}
      </div><div
        style={{
          display: "inline-block",
          width: "80%",
          boxSizing: "border-box",
          padding: "10px",
          verticalAlign: "top"
      }}>
        <input
          style={{width: "100%"}}
          type="range"
          min="0"
          max={props.timeDuration}
          value={props.timePosition}
          onChange={(e) => {
            const time = parseFloat(e.target.value)
            if (time > 0) {
              props.seekTo(time)
            }
          }}
        />
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
          {`${formatTime(props.timePosition)}/${formatTime(props.timeDuration)}`}
        </small>
        <span onClick={() => { props.toggle() }}>
          toggle
        </span>
      </div>
    </div>
  )
}

export default PlayerView
