const SectionNavigate = (props) => {
  return (
    <div style={{position: "relative", height: "40px"}}>
      <div style={{position: "absolute", top: 0, left: 0}}>
        <a
          href="#"
          onClick={(e) => {
            e.preventDefault
            props.sectionPrevious()
          }}
        >Previous Section</a>
      </div>
      <div style={{position: "absolute", top: 0, right: 0}}>
        <a
          href="#"
          onClick={(e) => {
            e.preventDefault
            props.sectionNext()
          }}
        >Next Section</a>
      </div>
    </div>
  )
}

export default SectionNavigate
