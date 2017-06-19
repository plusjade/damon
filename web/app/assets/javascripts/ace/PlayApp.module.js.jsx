import Commands             from 'ace/lib/Commands'
import throttle             from 'ace/lib/throttle'
import VideosDB             from 'ace/lib/VideosDB'
import QueryParams          from 'ace/lib/QueryParams'

import withPlay             from 'ace/withPlay'

import AceEditor            from 'ace/components/AceEditor'
import Player               from 'ace/components/Player'
import Previewer            from 'ace/components/Previewer'
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
    this.previewThrottled = throttle(this.preview, 100)
    if (this.state.videoId) {
      const commands = Video.find(this.state.videoId)
      if (commands) {
        this.loadCommands(commands)
      }
    }
  },

  isPlayable() {
    return this.state.commands && this.state.commands.length > 0
  },

  loadCommands(commands) {
    const state = Object.assign({commands: commands}, Commands(commands))
    this.setState(state)
  },

  loadVideo(videoId) {
    const commands = Video.find(videoId)
    if (commands) {
      history.replaceState({}, null, `/play?id=${videoId}`)
      this.loadCommands(commands)
      this.setState({videoId: videoId})
    }
  },

  refreshVideos() {
    this.setState({videos: Video.list()})
  },

  editorRef(node) {
    this.editorNode = node
  },

  previewerRef(node) {
    this.previewerNode = node
  },

  getEditor() {
    if (this.editor) { return this.editor }
    if (!this.editorNode) { return }
    this.editor = window.editor = ace.edit(this.editorNode)
    this.editor.setTheme("ace/theme/twilight")
    this.editor.getSession().setMode("ace/mode/javascript")
    this.editor.getSession().setUseSoftTabs(true)
    this.editor.session.doc.on("change", this.previewThrottled, true)

    return this.editor
  },

  previewData() {
    const code = this.getEditor().getValue()
    return ({
      "code": code,
      "cursor": {
        "start": 0,
        "end": 0
      },
      "validate": "",
      "noLint": false,
      "version": 4,
      "settings": {},
      "workersDir": "http://localhost:8000/build/workers/",
      "externalsDir": "http://localhost:8000/build/external/",
      "imagesDir": "http://localhost:8000/build/images/",
      "soundsDir": "../../sounds/",
      "jshintFile": "http://localhost:8000/build/external/jshint/jshint.js",
      "outputType": "",
      "enableLoopProtect": true
    })
  },

  preview() {
    console.log("preview")
    if (this.previewerNode) {
      const data = JSON.stringify(this.previewData())
      this
        .previewerNode
        .contentWindow
        .postMessage(data, "http://localhost:8000/demos/simple/output.html")
    }
  },

  render() {
    return (
      <div>
        <div style={{
            width: "100%",
            height: "500px",
          }}
        >
          <div style={{
              width: "40%",
              height: "inherit",
              border: "3px solid #444",
              position: "relative",
              display: "inline-block",
              verticalAlign: "top",
              boxSizing: "border-box",
            }}
          >
            <AceEditor editorRef={this.editorRef} />
          </div><div style={{
              height: "inherit",
              width: "40%",
              border: "3px solid #444",
              borderLeft: 0,
              display: "inline-block",
              verticalAlign: "top",
              boxSizing: "border-box",
            }}
          >
            <Previewer previewerRef={this.previewerRef} />
          </div><div style={{
              height: "400px",
              width: "20%",
              display: "inline-block",
              verticalAlign: "top",
              boxSizing: "border-box",
            }}
          >
          {this.state.videos && (
            <VideosList
              list={this.state.videos}
              onSelect={this.loadVideo}
            />
          )}
          </div>
        </div>

        <div style={{
            width: "80%",
            height: "60px",
            zIndex: 2,
            backgroundColor: "#222",
          }}
        >
        {this.isPlayable() && (
          <PlayerView
            videoId={this.state.videoId}
            getEditor={this.getEditor}
            chunksUpTo={this.state.chunksUpTo}
            nextChunk={this.state.nextChunk}
            timeDuration={this.state.timeDuration}
          />
        )}
        </div>
      </div>
    )
  }
})

export default App
