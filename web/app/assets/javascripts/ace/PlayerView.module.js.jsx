import IconPause              from './IconPause'
import IconPlay               from './IconPlay'

const PlayerView = (props) => {
  let offsetIndex = 0
  window.isOn = false
  function poll(boundingBox, x) {
    const offsetX = boundingBox.left
    const position = x - offsetX
    const percent = parseFloat(position/boundingBox.width)
    const index = parseInt(props.commands.length*percent)

    if (index >= 0 && index != offsetIndex) {
      console.log(index)
      offsetIndex = index
      props.seekTo(index)
    }
  }

  let animationFrame = undefined

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
          if (props.isPlaying) {
            props.pause()
          } else if (props.timePosition >= props.timeDuration ) {
            props.replay()
          }
          else {
            props.play()
          }
        }}
      >
        {props.isPlaying ? <IconPause /> : <IconPlay />}
      </div><div
        style={{
          display: "inline-block",
          width: "80%",
          boxSizing: "border-box",
          padding: "10px",
          verticalAlign: "top"
      }}>
        <div
          style={{height: "100%", width: "100%", display: "none"}}
          onMouseDown={(e) => {
            console.log(window.isOn)
            window.isOn = true
            console.log(window.isOn)
            e.persist()
            animationFrame = window.requestAnimationFrame(() => {
              poll(e.target.getBoundingClientRect(), e.clientX)
            })
          }}
          onMouseMove={(e) => {
            console.log(window.isOn)

              requestAnimationFrame(poll)
              e.persist()
              animationFrame = window.requestAnimationFrame(() => {
                poll(e.target.getBoundingClientRect(), e.clientX)
              })
          }}
          onMouseUp={(e) => {
            //isOn = false
            console.log(animationFrame)
            window.cancelAnimationFrame(animationFrame)
          }}
          onMouseOut={(e) => {
            console.log(animationFrame)
            window.cancelAnimationFrame(animationFrame)
          }}
        />
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
      </div>
    </div>
  )
}

export default PlayerView
