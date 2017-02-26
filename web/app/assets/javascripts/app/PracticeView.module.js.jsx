const PracticeView = (props) => {
  return (
    <div>
      <ul>
      {props.practices.map((p, i) => {
        return (
          <li key={i}>
            <span>{`${p.name} `}</span>
            <a
              href="#"
              onClick={(e) => {
                e.preventDefault
                console.log(p.id)
                props.setPractice(2)
              }}
            >
              go
            </a>
          </li>
        )
      })}
      </ul>
    </div>
  )
}

export default PracticeView
