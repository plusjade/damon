const Recorder = (Component, editor) => {
  let synchronizedTime = undefined
  window.commands = []

  const Recorder = React.createClass({
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

    componentDidMount() {
      this.listen()
    },

    resetState() {
      this.setState(this.initialState())
    },

    getTimeNow() {
      return (new Date()).getTime()
    },

    setTimeStart() {
      this.setState({timeStart: this.getTimeNow()})
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

    // Track text change events
    listen() {
      editor.session.doc.on("change", (e) => {
        const start = e.data.range.start
        const end = e.data.range.end

        if (e.data.action.indexOf("insert") === 0) {
          const insert = e.data.lines || e.data.text
          this.log(
            e.data.action,
            start.row,
            start.column,
            end.row,
            end.column,
            insert
          )
        } else {
          this.log(
            e.data.action,
            start.row,
            start.column,
            end.row,
            end.column
          )
        }
      }, true)

      editor.selection.addEventListener("changeCursor", () => {
        if (editor.selection.isEmpty()) {
          this.handleSelect()
        }
      }, true)

      editor
        .selection
        .addEventListener("changeSelection", this.handleSelect, true)
    },

    // Commands are stored in the format:
    // [time, name, arguments...]

    // By only rechecking the time when asynchrynous code executes we guarantee that
    // all event which occured as part of the same action
    // (and therefore the same paint) have the same timestamp. Meaning they will be
    // together during playback and not allow paints of intermediate states.
    // Specifically this applies to replace (which is a remove and an insert back to back)
    log() {
      if (!this.getTimeStart() > 0 ) { return }

      if (synchronizedTime === undefined) {
        synchronizedTime = Math.floor(this.getTimePosition())
        setTimeout(() => {
            synchronizedTime = undefined
        }, 50)
      }

      let args = Array.prototype.slice.call(arguments, 0)
      args.unshift(synchronizedTime)
      commands.push(args)
      console.log(commands)
      return true
    },

    handleSelect() {
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

    record() {
      this.setTimeStart()
      console.log("pressed record")
    },

    render() {
      return (
        <Component
          {...this.props}
          {...this.state}
          record={this.record}
        />
      )
    }
  })

  return Recorder
}

export default Recorder
