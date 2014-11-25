json.css do
  json.preview <<-CSS
    p {
      font-size: 12px;
    }

    img {
      display: none;
    }

    ul li {
      list-style-type: none;
    }

    ul li:before {
      content: "\2014";
      margin-right: 5px;
    }
  CSS

  json.post <<-CSS
    p {
      font-size: 17px;
    }

    img {
      display: block;
      margin: 10px auto;
      max-width: 200px;
    }

    img.emoji {
      margin: 0;
      display: inline;
      vertical-align: bottom;
    }

    ul li {
      list-style-type: none;
    }

    ul li:before {
      content: "\2014";
      margin-right: 5px;
    }
  CSS
  

  json.comment <<-CSS
    p { 
      font-size: 14px;
    }

    img {
      display: block;
      margin: 10px auto;
      max-width: 200px;
    }

    img.emoji {
      margin: 0;
      display: inline;
      vertical-align: bottom;
    }

    ul li {
      list-style-type: none;
    }

    ul li:before {
      content: "\2014";
      margin-right: 5px;
    }
  CSS
end