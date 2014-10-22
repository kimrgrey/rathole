json.css do
  json.preview <<-CSS
    p {
      font-size: 12px;
    }

    img {
      display: none;
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
  CSS
end