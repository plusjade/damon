import SectionView from "app/SectionView"
import HomeView from "app/HomeView"
import PracticeView from "app/PracticeView"
import PracticeOneView from "app/PracticeOneView"

const Heading = (props) => {
  return (
    <div>
      <h2>{props.name}</h2>
      <div>
        <a
          style={{float: "right"}}
          href="#"
          onClick={(e) => {
            e.preventDefault()
            props.setPractice(1)
          }}
        >
          Practice
        </a>
        <a
          href="#"
          onClick={(e) => {
            e.preventDefault()
            props.setPractice(0)
          }}
        >
          Level 1
        </a>
      </div>
    </div>
  )
}

const View = (props) => {
  let name
  let view
  let sectionLesson
  if (props.sectionId) {
    sectionLesson = props.sectionLesson()
    name = sectionLesson.name
    view = (
      <SectionView
        {...props}
        {...sectionLesson}
      />
    )
  } else {
    view = (
      <HomeView {...props} />
    )
  }

  return (
    <div className="wrap active">
      <div style={{position: "absolute", top: "5px", left: "5px"}}>
        <ul>
          <li>
            <a href="#" onClick={(e) => { e.preventDefault; props.toCourse() }}>Home</a>
          </li>
          <li>
            <a href="#" onClick={(e) => {
              e.preventDefault
              props.setLevel(1)
            }}>{`Level 1`}</a>
          </li>
          <li>
            <a href="#" onClick={(e) => {
              e.preventDefault
              props.setLevel(2)
            }}>{`Level 2`}</a>
          </li>
          <li>
            <a href="#" onClick={(e) => {
              e.preventDefault
              props.setLevel(3)
            }}>{`Level 3`}</a>
          </li>
        </ul>
      </div>

      <div className="view">
      {props.sectionId && (
        <Heading
        {...props}
        name={name}
        />
      )}
        <div className="unit" style={{left: `-${props.practice * 600}px`}}>
          <div className="slide">
            {view}
          </div>
          <div className="slide">
            <PracticeView
              {...props}
              practices={props.lessonPractice()}
            />
          </div>
          <div className="slide">
            <PracticeOneView
              {...props}
              practices={props.lessonPractice()}
            />
          </div>
        </div>
      </div>
    </div>
  )
}

export default View
