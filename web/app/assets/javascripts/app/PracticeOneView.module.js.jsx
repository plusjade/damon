const PracticeOneView = (props) => {
  return (
    <div>
      <h2>Make a folder with hello.html</h2>
      <p>
        A web browser is used to read web pages. Let's try it. Open your web browser and place a text file in it. There it is, there's a web page. It's probably not what you had in mind but it's there.
      </p>
      <p>
        But what then makes a web page different from any other text file?
      </p>
      <h2>Steps</h2>
      <ul>
        <li>
          Step one Drag a pdf file into the browser. What happens?
        </li>
        <li>
          Handle this step
        </li>
        <li>
          Then it goes here make sure to do this thing on the computer
        </li>
        <li>
          Finally, Ask your friend to load this url on their computer.
        </li>
      </ul>
      <a
        href="#"
        onClick={(e) => {
          e.preventDefault()
          props.setPractice(2)
        }}
      >
        Next exercise
      </a>
    </div>
  )
}

export default PracticeOneView
