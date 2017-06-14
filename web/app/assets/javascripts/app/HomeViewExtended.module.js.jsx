import SectionView from "app/SectionView"
const HomeViewExtended = (props) => {
  return (
    <div>
      <h1>{props.course.title}</h1>
      {props.sections.map((section) => {
        return (
          <div key={section.id}>
            <h3
              href="#"
              onClick={(e) => {
                e.preventDefault()
                props.toSection(section.id)
              }}
            >
              {section.name}
            </h3>
            <SectionView
              {...props}
              {...section}
            />
          </div>
        )
      })}
    </div>
  )
}

export default HomeViewExtended
