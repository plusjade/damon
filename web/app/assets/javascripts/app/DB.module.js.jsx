const DB = {
  course: {
    id: 1,
    title: "Hello World ^_^ [o_o]"
  },

  sections: [
    {
      id: 1,
      course_id: 1,
      "name": "What is a web page?",
    },
    {
      id: 2,
      course_id: 1,
      name: "Web page create and edit"
    },
    {
      id: 3,
      course_id: 1,
      name: "Update the look of your web page"
    },
    {
      id: 4,
      course_id: 1,
      name: "Update the structure of your web page"
    },
    {
      id: 5,
      course_id: 1,
      name: "User interactions on your web page"
    },
    {
      id: 6,
      course_id: 1,
      name: "Publish your web page to the Internet"
    },
    {
      id: 7,
      course_id: 1,
      name: "Web page animations"
    },
    {
      id: 8,
      course_id: 1,
      name: "Programming fundamentals"
    },
    {
      id: 9,
      course_id: 1,
      name: "Web applications"
    },
    {
      id: 10,
      course_id: 1,
      name: "What is a web page?"
    }
  ],

  lessons: [
    {
      course_id: 1,
      section_id: 1,
      level: 1,
      "content": [
        "A web page is just text, therefore a web page can be created by any text editor. To create a web page we just need to create a file with text in it.",
        "To edit a web page we just need to edit this page.",
        "But what then makes a web page different from any other text file?",
        "A web browser is used to read web pages. Let's try it. Open your web browser and place a text file in it. There it is, there's a web page. It's probably not what you had in mind but it's there."
      ]
    },

    {
      course_id: 1,
      section_id: 1,
      level: 2,
      "content": [
        "A web browser is used to read web pages. Let's try it. Open your web browser and place a text file in it. There it is, there's a web page. It's probably not what you had in mind but it's there.",
        "But what then makes a web page different from any other text file?"
      ]
    },
    {
      course_id: 1,
      section_id: 2,
      level: 1,
      "content": [
        "But what then makes a web page different from any other text file?",
        "A web browser is used to read web pages. Let's try it. Open your web browser and place a text file in it. There it is, there's a web page. It's probably not what you had in mind but it's there."

      ]
    },
    {
      course_id: 1,
      section_id: 2,
      level: 2,
      "content": [
        "But what then makes a web page different from any other text file?"
      ]
    },
    {
      course_id: 1,
      section_id: 2,
      level: 3,
      "content": [
        "A web page is just text, therefore a web page can be created by any text editor. To create a web page we just need to create a file with text in it.",
      ]
    },
    {
      course_id: 1,
      section_id: 3,
      level: 1,
      "content": [
        "A web browser is used to read web pages. Let's try it. Open your web browser and place a text file in it. There it is, there's a web page. It's probably not what you had in mind but it's there.",
        "But what then makes a web page different from any other text file?"
      ]
    }
  ],

  practices: {
    "section:1:lesson:1": [
      "Make a folder with hello.html",
      "Place another file named index.html (how is this different?)",
      "Add an image to the folder load this in your browser",
      "Drag a pdf file into the browser. What happens?",
      "Drag a .txt file into the browser. What happens. Why?",
      "What happens if you drag the entire folder into the web browser? Why?",
      "Drag an excel file into the browser.",
      "What does the web browser url bar say? Why? ",
      "Ask your friend to load this url on their computer. Does it work? Why or why not?"
    ]
  }
}

export default DB
