import Commands             from 'ace/lib/Commands'
import DB                   from 'ace/lib/DB'

import Player               from 'ace/hoc/Player'
import Recorder             from 'ace/hoc/Recorder'

import PlayerView           from 'ace/ui/PlayerView'
import RecorderView         from 'ace/ui/RecorderView'

const App = React.createClass({

  getInitialState() {
    return ({
      videoId: parseInt(window.location.hash.substring(1)),
      commands: []
    })
  },

  componentWillMount() {
    window.commands = []
    window.editor = ace.edit("editor")
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
    if(this.state.commands.length > 0) {
      this.setState({commands: []})
    } else {
      this.setState({commands: DB[3]})
    }
  },

  isPlayable() {
    return this.state.commands.length > 0
  },

  render() {
    let props = {toggle: this.toggle}

    if (this.isPlayable()) {
      props = Object.assign(props, Commands(this.state.commands))
      component = this.PlayerView2
    } else {
      component = this.RecorderView2
    }
    return (
      React.createElement(component, props)
    )
  }
})

export default App
