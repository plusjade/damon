import Commands             from 'ace/lib/Commands'
import VideosDB             from 'ace/lib/VideosDB'
import QueryParams          from 'ace/lib/QueryParams'

import withPlay             from 'ace/withPlay'

import Player               from 'ace/components/Player'
import VideosList           from 'ace/components/VideosList'

const PlayerView = withPlay(Player)
const Video = VideosDB()
const QParams = QueryParams()

const App = React.createClass({
  initialState() {
    return ({
      commands: [],
      videoId: QParams.get("id"),
      videos: Video.list(),
    })
  },

  getInitialState() {
    return (this.initialState())
  },

  componentWillMount() {
    if (this.state.videoId) {
      const commands = Video.find(this.state.videoId)
      if (commands) {
        this.setState({commands: commands})
      }
    }
  },

  isPlayable() {
    return this.state.commands && this.state.commands.length > 0
  },

  loadVideo(videoId) {
    const commands = Video.find(videoId)
    if (commands) {
      history.replaceState({}, null, `/play?id=${videoId}`)
      this.setState({commands: commands, videoId: videoId})
    }
  },

  refreshVideos() {
    this.setState({videos: Video.list()})
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
          <VideosList
            list={this.state.videos}
            onSelect={this.loadVideo}
          />
        )}
      </div>
    )
  }
})

export default App
