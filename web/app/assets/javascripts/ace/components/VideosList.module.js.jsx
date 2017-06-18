const VideosList = (props) => {
  return (
    <ul style={{color: "#BDBDBD", textAlign: "right", listStyle: "none"}}>
    {props.list.map((v, i) => {
      return (
        <li key={i}>
          <a
            style={{color: "inherit"}}
            href="#"
            onClick={(e) => {
              e.preventDefault()
              if (typeof props.onSelect === "function") {
                props.onSelect(v)
              }
            }}
          >
            {v}
          </a>
        {typeof props.onDelete === "function" && (
          <a
            href="#"
            style={{float: "right", color: "inherit"}}
            onClick={(e) => {
              e.preventDefault()
              props.onDelete(v)
            }}
          >
            [x]
          </a>
        )}
        </li>
      )
    })}
    </ul>
  )
}

export default VideosList
