import Commands             from 'ace/lib/Commands'
import VideosDB             from 'ace/lib/VideosDB'
import QueryParams          from 'ace/lib/QueryParams'

import withPlay             from 'ace/withPlay'

import AceEditor            from 'ace/components/AceEditor'
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
                      getEditor: this.getEditor
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

  editorRef(node) {
    this.editorNode = node
  },

  getEditor() {
    if (this.editor) { return this.editor }
    if (!this.editorNode) { return }
    this.editor = window.editor = ace.edit(this.editorNode)
    this.editor.setTheme("ace/theme/twilight")
    this.editor.getSession().setMode("ace/mode/javascript")
    this.editor.getSession().setUseSoftTabs(true)

    return this.editor
  },

  render() {
    return (
      <div>
        <AceEditor editorRef={this.editorRef} />
        <div id="panel">
          {this.renderPlayer()}
        {this.state.videos && (
          <VideosList
            list={this.state.videos}
            onSelect={this.loadVideo}
          />
        )}
        </div>
      </div>
    )
  }
})

export default App
