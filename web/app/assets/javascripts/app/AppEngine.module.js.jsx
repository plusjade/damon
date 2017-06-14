const DB = require("app/DB")

const AppEngine = (Component) => {
  const AppEngine = React.createClass({
    getInitialState() {
      return ({
        sectionId: null,
        level: 1,
        practice: 0
      })
    },

    toCourse() {
      this.setState({sectionId: undefined, practice: 0})
    },

    toSection(sectionId) {
      this.setState({sectionId: sectionId, practice: 0})
    },

    sectionNext() {
      const sectionId = this.state.sectionId + 1
      this.toSection(sectionId)
    },

    sectionPrevious() {
      const sectionId = this.state.sectionId - 1
      this.toSection(sectionId)
    },

    setLevel(level) {
      this.setState({level: parseInt(level)})
    },

    setPractice(index) {
      this.setState({practice: index})
    },

    getLessons() {
      return DB.lessons.filter((lesson) => {
        return lesson.section_id === this.state.sectionId
      })
    },

    // find the active section and coerce the data
    sectionLesson() {
      const section = this.getSection()
      const lessons = this.getLessons()
      return ({
        name: section.name,
        levels: lessons.map((l) => l.content),
        level: this.state.level || 1
      })
    },

    lessonPractice() {
      const data = DB.practices["section:1:lesson:1"].map((d, i) => {
                      return ({id: i, name: d})
                    })
      return (data)
    },

    getSections() {
      return DB.sections.filter((s) => {
        return s.course_id === this.props.course.id
      })
    },

    getSectionsExtended() {
      return this.getSections().map((s) => {
        const levels = DB.lessons.filter((lesson) => {
                          return lesson.section_id === s.id
                        }).map((l) => l.content)

        return (Object.assign({
                  name: s.name,
                  levels: levels,
                  level: 1
                }, s))
      })
    },

    getSection() {
      return DB.sections.find((section) => {
        return section.id === this.state.sectionId
      })
    },

    render() {
      return (
        <Component
          {...this.props}
          {...this.state}
          sections={this.getSectionsExtended()}
          toCourse={this.toCourse}
          toSection={this.toSection}
          setLevel={this.setLevel}
          sectionLesson={this.sectionLesson}
          sectionNext={this.sectionNext}
          sectionPrevious={this.sectionPrevious}
          lessonPractice={this.lessonPractice}
          setPractice={this.setPractice}
        />
      )
    }
  })

  return AppEngine
}

export default AppEngine
