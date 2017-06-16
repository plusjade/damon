const Recordings = (props) => {
  return (
    <ul style={{color: "#FFF"}}>
    {props.list.map((v, i) => {
      return (
        <li key={i}>
          <a
            style={{color: "inherit"}}
            href="#"
            onClick={(e) => { e.preventDefault(); props.onSelect(v) }}
          >
            {v}
          </a>
          <a
            href="#"
            style={{float: "right", color: "inherit"}}
            onClick={(e) => { e.preventDefault(); props.onDelete(v) }}
          >
            [x]
          </a>
        </li>
      )
    })}
    </ul>
  )
}

export default Recordings
