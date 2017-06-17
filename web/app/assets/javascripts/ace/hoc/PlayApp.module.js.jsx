import Commands             from 'ace/lib/Commands'
import DB                   from 'ace/lib/DB'

import withPlay             from 'ace/hoc/withPlay'

import Player               from 'ace/ui/Player'
import Recordings           from 'ace/ui/Recordings'

const PlayerView = withPlay(Player)

const App = React.createClass({
  initialState() {
    return ({
      commands: [],
      videoId: parseInt(window.location.hash.substring(1)),
      videos: this.videosList(),
    })
  },

  getInitialState() {
    return (this.initialState())
  },

  componentWillMount() {
    if (this.state.videoId) {
      const commands = this.findVideo(this.state.videoId)
      if (commands) {
        this.setState({commands: commands})
      }
    }
  },

  isPlayable() {
    return this.state.commands && this.state.commands.length > 0
  },

  videosList() {
    return Object.keys(localStorage)
  },

  findVideo(videoId) {
    let json = localStorage.getItem(videoId)
    if (json) {
      return JSON.parse(json)
    } else if (DB[videoId]) {
      return DB[videoId]
    } else {
      return null
    }
  },

  loadVideo(videoId) {
    const commands = this.findVideo(videoId)
    if (commands) {
      this.setState({commands: commands, videoId: videoId})
    }
  },

  refreshVideos() {
    this.setState({videos: this.videosList()})
  },

  renderPlayer() {
    if (this.isPlayable()) {
      const props = Object.assign({
                      loadVideo: this.loadVideo,
                      videos: this.state.videos,
                      videoId: this.state.videoId,
                    }, Commands(this.state.commands))
      return (
        <PlayerView {...props} />
      )
    } else {
      return (
        <div style={{height: "60px"}}/>
      )
    }
  },

  render() {
    return (
      <div>
        {this.renderPlayer()}
        {this.state.videos && (
          <Recordings
            list={this.state.videos}
            onSelect={this.loadVideo}
          />
        )}
      </div>
    )
  }
})

export default App
