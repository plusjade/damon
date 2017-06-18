const withRecord = (Component) => {
  window.commands = []
  window.editor = this.editor = ace.edit("editor")
  editor.setTheme("ace/theme/monokai")
  editor.getSession().setMode("ace/mode/javascript")
  editor.getSession().setUseSoftTabs(true)
  let synchronizedTime = undefined

  const withRecord = React.createClass({
    propTypes: {
    },

    initialState() {
      return ({
        chunkPosition: -1,
        timeStart: undefined,
        timePosition: 0,
        timePositionPaused: 0,
      })
    },

    getInitialState() {
      return (this.initialState())
    },

    componentWillMount() {
      this.tickInterval = undefined
    },

    componentDidMount() {
      this.listen()
    },

    componentWillUnmount() {
      console.log("unmounting")
      this.unListen()
    },

    resetState() {
      this.setState(this.initialState())
    },

    getTimeNow() {
      return (new Date()).getTime()
    },

    setTimeStart(time) {
      this.setState({timeStart: time || this.getTimeNow()})
    },

    getTimeStart() {
      return this.state.timeStart
    },

    getTimePosition() {
      return this.state.timePositionPaused + this.getTimeNow() - this.getTimeStart()
    },

    updateTimePosition(time) {
      this.setState({timePosition: time || this.getTimePosition()})
    },

    listen() {
      editor.session.doc.on("change", this.listenChange, true)
      editor
        .selection
        .addEventListener("changeCursor", this.listenChangeCursor, true)
      editor
        .selection
        .addEventListener("changeSelection", this.listenSelect, true)
    },

    unListen() {
      editor.session.doc.off("change", this.listenChange)
      editor.selection.removeEventListener("changeCursor", this.listenChangeCursor)
      editor.selection.removeEventListener("changeSelection", this.listenSelect)
    },

    listenChange(e) {
      const start = e.start
      const end = e.end

      if (e.action.indexOf("insert") === 0) {
        const insert = e.lines || e.text
        this.log(
          e.action,
          start.row,
          start.column,
          end.row,
          end.column,
          insert
        )
      } else {
        this.log(
          e.action,
          start.row,
          start.column,
          end.row,
          end.column
        )
      }
    },

    listenChangeCursor() {
      if (editor.selection.isEmpty()) {
        this.listenSelect()
      }
    },

    listenSelect() {
      const curRange = editor.selection.getRange()
      const start = curRange.start
      const end = curRange.end
      this.log(
        "select",
        start.row,
        start.column,
        end.row,
        end.column
      )
    },

    // Commands are stored in the format:
    // [time, name, arguments...]

    // By only rechecking the time when asynchrynous code executes we guarantee that
    // all event which occured as part of the same action
    // (and therefore the same paint) have the same timestamp. Meaning they will be
    // together during playback and not allow paints of intermediate states.
    // Specifically this applies to replace (which is a remove and an insert back to back)
    log() {
      if (this.isPaused()) { return }

      console.log("log")

      if (synchronizedTime === undefined) {
        synchronizedTime = Math.floor(this.getTimePosition())
        setTimeout(() => {
            synchronizedTime = undefined
        }, 50)
      }

      let args = Array.prototype.slice.call(arguments, 0)
      args.unshift(synchronizedTime)
      window.commands.push(args)
      return true
    },

    record() {
      editor.focus()
      this.setTimeStart()
      this.tickInterval = setInterval(() => {
        this.updateTimePosition()
      }, 50)

      console.log("pressed record")
    },

    pause(time) {
      clearInterval(this.tickInterval)
      this.tickInterval = undefined
      this.setState({
        timeStart: undefined,
        timePositionPaused: time || this.getTimePosition()
      })
      if (this.isPaused && this.hasRecording) {
        this.props.save()
      }
    },

    isPaused() {
      return !this.tickInterval
    },

    hasRecording() {
      return window.commands.length > 0
    },

    render() {
      return (
        <Component
          {...this.props}
          {...this.state}
          getTimePosition={this.getTimePosition}
          record={this.record}
          pause={this.pause}
          isPaused={this.isPaused()}
          hasRecording={this.hasRecording()}
        />
      )
    }
  })

  return withRecord
}

export default withRecord
