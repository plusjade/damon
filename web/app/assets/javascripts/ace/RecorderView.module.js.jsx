import IconPause              from './IconPause'
import IconPlay               from './IconPlay'

const RecorderView = (props) => {
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
          props.record()
        }}
      >
        {props.isRecording ? <IconPause /> : <IconPlay />}
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
        000
      </div>
    </div>
  )
}

export default RecorderView
