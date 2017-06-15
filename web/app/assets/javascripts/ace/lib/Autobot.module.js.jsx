const Autobot = (editor) => {
  let handlers = {}

  function insertText(startRow, startCol, endRow, endCol, data) {
    const delta = {
      action: "insertText",
      range: makeRange(startRow, startCol, endRow, endCol),
      text: data
    }
    editor.session.doc.applyDeltas([delta])
  }

  function insertLines(startRow, startCol, endRow, endCol, data) {
    const delta = {
      action: "insertLines",
      range: makeRange(startRow, startCol, endRow, endCol),
      lines: data
    }
    editor.session.doc.applyDeltas([delta])
  }

  function removeText(startRow, startCol, endRow, endCol, data) {
    const delta = {
      action: "removeText",
      range: makeRange(startRow, startCol, endRow, endCol)
    }
    editor.session.doc.applyDeltas([delta])
  }

  function removeLines(startRow, startCol, endRow, endCol, data) {
    const delta = {
      action: "removeLines",
      range: makeRange(startRow, startCol, endRow, endCol)
    }
    editor.session.doc.applyDeltas([delta])
  }

  function select(startRow, startCol, endRow, endCol) {
    if (endRow == null) {
      endRow = startRow
    }

    if (endCol == null) {
      endCol = startCol
    }

    editor.selection.setSelectionRange(
      makeRange(startRow, startCol, endRow, endCol)
    )
  }

  function makeRange(startRow, startCol, endRow, endCol) {
    return ({
      start: {
        row: startRow,
        column: startCol
      },
      end: {
        row: endRow,
        column: endCol
      }
    })
  }

  // Set the cursor position on the editor
  function setCursor(cursorPos, focus) {
    editor.moveCursorToPosition(cursorPos)
    editor.clearSelection()

    if (focus !== false && this.autoFocus !== false) {
      editor.focus()
    }
  }

  handlers = {select, insertText, insertLines, removeText, removeLines}

  // Commands are stored in the format:
  // [time, name, arguments...]
  function runCommand(event) {
    const handler = handlers[event[1]]

    if (handler) {
      handler.apply(handlers, event.slice(2))
    } else {
      console.error("Command not found:", event[1])
    }
  }

  return({
    runCommand: runCommand,
    setCursor: setCursor
  })
}

export default Autobot
