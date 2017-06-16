import Commands             from 'ace/lib/Commands'
import DB                   from 'ace/lib/DB'

import Player               from 'ace/hoc/Player'
import Recorder             from 'ace/hoc/Recorder'

import PlayerView           from 'ace/ui/PlayerView'
import RecorderView         from 'ace/ui/RecorderView'
import Recordings           from 'ace/ui/Recordings'

const App = React.createClass({
  getInitialState() {
    return ({
      videoId: parseInt(window.location.hash.substring(1)),
      commands: [],
      videos: Object.keys(localStorage),
      recordingId: this.getTimeNow()
    })
  },

  componentWillMount() {
    window.commands = []
    window.editor = this.editor = ace.edit("editor")

    editor.setTheme("ace/theme/monokai")
    editor.getSession().setMode("ace/mode/javascript")
    editor.getSession().setUseSoftTabs(true)

    this.PlayerView2 = Player(PlayerView, editor)
    this.RecorderView2 = Recorder(RecorderView, editor)

    if (this.state.videoId) {
      this.setState({commands: DB[this.state.videoId]})
    }
  },

  toggle() {
    if (window.commands.length > 0) {
      this.setState({commands: window.commands})
    }
    else if(this.state.commands.length > 0) {
      this.setState({commands: []})
    } else {
      this.setState({commands: DB[3]})
    }
  },

  isPlayable() {
    return this.state.commands.length > 0
  },

  getTimeNow() {
    return (new Date()).getTime()
  },

  getRecordingId() {
    return this.state.recordingId
  },

  getRecordingName() {
    return `vids_${this.getRecordingId()}`
  },

  hasCommands() {
    return window.commands && window.commands.length > 0
  },

  save() {
    if (!this.hasCommands()) { return }

    window.localStorage.setItem(this.getRecordingName(), JSON.stringify(window.commands))
    window.commands = []
    this.refreshVideos()
  },

  clearCommands() {
    this.setState({commands: []})
  },

  clearEditor() {
    this.editor.setValue()
  },

  newRecording() {
    console.log("newRecording")
    this.clearCommands()
    this.clearEditor()
    this.setState({recordingId: this.getTimeNow()})
  },

  playVideo(videoId) {
    this.clearEditor()
    const json = localStorage.getItem(videoId)
    this.setState({commands: JSON.parse(json)})
  },

  refreshVideos() {
    this.setState({videos: Object.keys(localStorage)})
  },

  deleteVideo(videoId) {
    localStorage.removeItem(videoId)
    this.refreshVideos()
  },

  render() {
    let props = {
      save: this.save
    }

    if (this.isPlayable()) {
      props = Object.assign(props, Commands(this.state.commands))
      component = this.PlayerView2
    } else {
      component = this.RecorderView2
    }
    return (
      <div>
        {React.createElement(component, props)}
      <div>
        <a
          href="#"
          style={{color: "#FFF"}}
          onClick={(e) => {
            e.preventDefault()
            this.newRecording()
          }}
        >
          New recording
        </a>
      </div>
      {this.state.videos && (
        <Recordings
          list={this.state.videos}
          onSelect={this.playVideo}
          onDelete={this.deleteVideo}
        />
      )}
      </div>

    )
  }
})

export default App
