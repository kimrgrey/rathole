function createPublicLink(url) {
  link = $('<a>').addClass('public-link').attr('href', url);
  icon = $('<i>').addClass('fa').addClass('fa-link');
  link.append(icon);
  return link;
}

function createDeleteLink(url) {
  link = $('<a>').addClass('delete-link').attr('href', url)
  icon = $('<i>').addClass('fa').addClass('fa-times');
  link.append(icon);
  return link;
}

function createImage(thumbUrl) {
  img = $('<img>').attr('src', thumbUrl);
  return img;
}

function createItem(urls) {
  item = $('<div>').addClass('picture-item');
  item.append(createImage(urls.thumb));
  item.append(createPublicLink(urls.original));
  item.append(createDeleteLink(urls.destroy));
  return item;    
}

function startFileUpload(url, method, file, callback) {
  var xhr = new XMLHttpRequest();
  xhr.open(method, url, true);
  xhr.onload = function() {
    result = JSON.parse(xhr.responseText)
    if (this.status == 200) {
      callback(result);
    }
  };
  xhr.send(file);
}

function initUploadDialog() {
  var uploadDialog = $('#pictures-upload-dialog')
  uploadDialog.modal({show: false});
  var uploadForm = uploadDialog.find('#upload-form')
  uploadForm.submit(function(event){
    event.preventDefault();
    var files = uploadForm.find('#files').get(0).files;
    var url = uploadForm.attr('action');
    var method = uploadForm.attr('method');
    for (var i = 0; i < files.length; ++i) {
      startFileUpload(url, method, files[i], function(result) {
        item = createItem(result.urls);
        $('#pictures-list #content').append(item);
      });
    }
    return false;
  });
  uploadDialog.find('#upload').click(function(event) {
    event.preventDefault();
    uploadForm.submit();
    return false;
  });
  $('a#upload-picture').click(function(event) {
    event.preventDefault();
    uploadDialog.modal('show')
    return false;
  });
}

function initPictureUpload() {
  initUploadDialog();
  $('#pictures-list').on('click', '.delete-link', function(event) {
    event.preventDefault();
    item = $(this).parent('.picture-item')
    $.post($(this).attr('href'), function() {
      item.remove();
    });
    return false;
  });

  $('#pictures-list').on('click', '.public-link', function(event) {
    event.preventDefault();
    return false;
  });
}

function initAvatarUploadDialog() {
  var uploadDialog = $('#avatar-upload-dialog')
  uploadDialog.modal({show: false});
  var uploadForm = uploadDialog.find('#upload-form')
  uploadForm.submit(function(event){
    event.preventDefault();
    var files = uploadForm.find('#file').get(0).files;
    if (files.length > 0) {
      var file = files[0];
      var url = uploadForm.attr('action');
      var method = uploadForm.attr('method');
      startFileUpload(url, method, file, function(result){
        $('#avatar-picture').attr('src', result.urls.thumb);
      });
    }
    return false;
  });
  uploadDialog.find('#upload').click(function(event) {
    event.preventDefault();
    uploadForm.submit();
    return false;
  });
  $('a#upload-avatar').click(function(event) {
    event.preventDefault();
    uploadDialog.modal('show')
    return false;
  });
}

function initAvatarUpload() {
  initAvatarUploadDialog();
}

function initUpload() {
  initPictureUpload();
  initAvatarUpload();
}

$(document).ready(initUpload);