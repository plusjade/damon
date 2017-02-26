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

    // find the active section and coerce the data
    sectionLesson() {
      let levels = DB.lessons[`sectionId:${this.state.sectionId}`]
      const section = DB.course.sections.find((section) => {
                        return section.id === this.state.sectionId
                      })

      return ({
        name: section.name,
        levels: levels,
        level: this.state.level || 1
      })
    },

    lessonPractice() {
      const data = DB.practices["section:1:lesson:1"].map((d, i) => {
                      return ({id: i, name: d})
                    })
      return (data)
    },

    render() {
      return (
        <Component
          {...this.props}
          {...this.state}
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
