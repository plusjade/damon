const HomeView = (props) => {
  return (
    <div>
      <h1>{props.title}</h1>
      <ul>
      {props.sections.map((section) => {
        return (
          <li key={section.id}>
            <a
              href="#"
              onClick={(e) => {
                e.preventDefault()
                props.toSection(section.id)
              }}
            >
              {section.name}
            </a>
          </li>
        )
      })}
      </ul>
    </div>
  )
}

export default HomeView
