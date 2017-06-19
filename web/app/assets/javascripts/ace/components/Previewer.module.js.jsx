const Previewer = (props) => {
  return (
    <div>
      <iframe
        style={{
          width: "100%",
          height: "496px",
          border: 0,
        }}
        ref={props.previewerRef}
        id="output-frame"
        src="//localhost:8000/demos/simple/output.html"
        data-src="//localhost:8000/demos/"
      />
    </div>
  )
}

export default Previewer
