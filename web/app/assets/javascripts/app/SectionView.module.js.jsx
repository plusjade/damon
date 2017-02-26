import SectionNavigate from "app/SectionNavigate"

const SectionView = (props) => {

  function levelContent(level) {
    return (
      level.map((line, i) => {
        return (<p key={i}>{line}</p>)
      })
    )
  }

  return (
    <div className="section">
    {props.levels.map((level, i) => {
      const isAllowed = (props.level - 1) >= i
      let style = {}
      if (!isAllowed) {
        style.color = "#CCC"
      }

      return (
        <div key={i} style={{marginBottom: "10px"}}>
          {isAllowed && levelContent(level)}
          <div>
            {(props.level === i + 1) && (
              <SectionNavigate
                sectionNext={props.sectionNext}
                sectionPrevious={props.sectionPrevious}
              />
            )}
          </div>
        </div>
      )
    })}
    </div>
  )
}

export default SectionView
