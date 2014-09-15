function uploadFiles(url, token, method, files, callback) {
  var formData = new FormData();
  
  for (var i = 0; i < files.length; ++i) {
    var file = files[i];
    if (!file.type.match('image.*')) {
      return;
    }
    formData.append('files[]', file, file.name);
  }
  formData.append('authenticity_token', token)

  var xhr = new XMLHttpRequest();
  xhr.open(method, url, true);
  xhr.setRequestHeader("Accept","application/json");
  xhr.onload = function() {
    result = JSON.parse(xhr.responseText)
    if (this.status == 200) {
      callback(result.pictures);
    }
  };
  xhr.send(formData);   
}
