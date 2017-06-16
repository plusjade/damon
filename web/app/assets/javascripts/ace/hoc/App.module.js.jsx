import Commands             from 'ace/lib/Commands'
import DB                   from 'ace/lib/DB'

import Player               from 'ace/hoc/Player'
import PlayerView           from 'ace/ui/PlayerView'

const View = Player(PlayerView)

const App = React.createClass({
  getInitialState() {
    return ({
      videoId: parseInt(window.location.hash.substring(1)),
      commands: [],
      videos: Object.keys(localStorage),
    })
  },

  componentWillMount() {
    if (this.state.videoId) {
      this.setState({commands: DB[this.state.videoId]})
    }
  },

  isPlayable() {
    return this.state.commands && this.state.commands.length > 0
  },

  clearCommands() {
    this.setState({commands: []})
  },

  playVideo(videoId) {
    console.log("playVideo")
    const json = localStorage.getItem(videoId)
    this.setState({commands: JSON.parse(json), test: videoId})
  },

  refreshVideos() {
    this.setState({videos: Object.keys(localStorage)})
  },

  render() {
    const data = this.isPlayable() ? Commands(this.state.commands) : {}
    const props = Object.assign({
      playVideo: this.playVideo,
      videos: this.state.videos,
      test: this.state.test,
    }, data)

    return (
      <View {...props}/>
    )
  }
})

export default App
