import Autobot from 'ace/lib/Autobot'

const Player = (Component) => {
  window.commands = []
  const editor = window.editor = ace.edit("editor")

  editor.setTheme("ace/theme/monokai")
  editor.getSession().setMode("ace/mode/javascript")
  editor.getSession().setUseSoftTabs(true)

  const autobot = Autobot(editor)


  const Player = React.createClass({
    propTypes: {
      chunksUpTo: React.PropTypes.func.isRequired,
      nextChunk: React.PropTypes.func.isRequired,
      timeDuration: React.PropTypes.number.isRequired,
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
      this.playInterval = undefined
    },

    componentWillReceiveProps(nextProps) {
      console.log("componentWillReceiveProps")
      if (nextProps.test !== this.props.test) {
        this.play()
      }
    },

    resetState() {
      this.setState(this.initialState())
    },

    getChunkPosition() {
      return this.state.chunkPosition
    },

    setChunkPosition(index) {
      this.setState({chunkPosition: index})
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

    replay() {
      this.pause()
      this.resetState()
      editor.setValue()
      autobot.setCursor({row: 0, column: 0})
      this.play()
    },

    pause(time) {
      clearInterval(this.playInterval)
      this.playInterval = undefined
      this.setState({timePositionPaused: time || this.state.timePosition})
    },

    play() {
      if (this.playInterval) { return }

      this.setTimeStart()
      this.playInterval = setInterval(() => {
        this.updateTimePosition()
        const time = this.getTimePosition()
        const {chunk, chunkPosition} = this.props.nextChunk(time, this.getChunkPosition())

        if (chunk) {
          chunk.forEach((c) => { autobot.runCommand(c) })
          this.setChunkPosition(chunkPosition)
          if (time >= this.props.timeDuration) {
            this.pause()
            return
          }
        }
      }, 50)
    },

    seekTo(time) {
      this.pause(time)
      this.updateTimePosition(time)
      editor.setValue()

      const chunkPosition = (
        this.props.chunksUpTo(time, (chunk) => {
          chunk.forEach((c) => { autobot.runCommand(c) })
        })
      )

      this.setChunkPosition(chunkPosition)
    },

    isPaused() {
      return !this.playInterval
    },

    playVideo(videoId) {
      this.pause()
      this.resetState()
      editor.setValue()
      this.props.playVideo(videoId)
    },

    render() {
      return (
        <Component
          {...this.props}
          {...this.state}
          playVideo={this.playVideo}
          play={this.play}
          pause={this.pause}
          replay={this.replay}
          seekTo={this.seekTo}
          isPaused={this.isPaused()}
        />
      )
    }
  })

  return Player
}

export default Player
