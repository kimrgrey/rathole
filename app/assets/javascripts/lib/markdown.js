window.Markdown = {
  image: function(text, url) {
    return '![' + text + ']' + '(' + url + ')';
  },

  bold: function(text) {
    return "**" + text + ":**";
  },


  blockquote: function(text) {
    return "> " + text;
  },
}