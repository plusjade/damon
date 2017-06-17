import Commands             from 'ace/lib/Commands'
import VideosDB             from 'ace/lib/VideosDB'

import withRecord           from 'ace/hoc/withRecord'
import Recorder             from 'ace/ui/Recorder'
import VideosList           from 'ace/ui/VideosList'

const RecorderView = withRecord(Recorder)
const Videos = VideosDB()

const App = React.createClass({
  getInitialState() {
    return ({
      videoId: parseInt(window.location.hash.substring(1)),
      commands: [],
      videos: Videos.list(),
      recordingId: undefined
    })
  },

  componentWillMount() {
    this.newRecording()
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
    Videos.save(this.getRecordingName(), window.commands)
    this.refreshVideos()
  },

  clearCommands() {
    this.setState({commands: []})
  },

  newRecording() {
    console.log("newRecording")
    this.clearCommands()
    this.setState({recordingId: this.getTimeNow()})
  },

  loadVideo(videoId) {
    window.open(`/play#${videoId}`, "_blank")
    return
    const commands = Videos.find(videoId)
    if (commands) {
      this.setState({commands: commands, videoId: videoId})
    }
  },

  refreshVideos() {
    this.setState({videos: Videos.list()})
  },

  deleteVideo(videoId) {
    Videos.remove(videoId)
    this.refreshVideos()
  },

  render() {
    return (
      <div>
        <RecorderView
          {...this.props}
          {...this.state}
          save={this.save}
        />
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
        <VideosList
          list={this.state.videos}
          onSelect={this.loadVideo}
          onDelete={this.deleteVideo}
        />
      )}
      </div>

    )
  }
})

export default App
