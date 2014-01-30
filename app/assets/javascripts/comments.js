function buildCommentCalendar(date) {
 var badge = $('<span>').addClass('badge pull-right');
 var icon = $('<i>').addClass('fa fa-calendar');
 badge.append(icon);
 badge.append('&nbsp;');
 badge.append(date);
 return badge;
}

function buildCommentProfile(author) {
  var badge = $('<span>').addClass('badge pull-right');
  var icon = $('<i>').addClass('fa fa-user');
  var link = $('<a>').attr('href', author.url);
  link.append(icon);
  link.append('&nbsp;');
  link.append(author.name);
  badge.append(link);
  return badge;
}

function buildCommentLink(id, url) {
  var badge = $('<span>').addClass('badge pull-right');
  var link = $('<a>').attr('href', url).addClass('public-link');
  var icon = $('<i>').addClass('fa fa-link');
  link.append(icon);
  badge.append(link);
  return badge;
}

function buildCommentHeader(id, url, date, author) {
  var calendar = buildCommentCalendar(date);
  var link = buildCommentLink(id, url);
  var profile = buildCommentProfile(author);
  var inner = $('<div>').addClass('col-md-12');
  inner.append(calendar);
  inner.append(link);
  inner.append(profile);
  var header = $('<div>').addClass('row header');
  header.append(inner);
  return header;
}

function buildCommentBody(author, text) {
  var avatar = $('<div>').addClass('col-md-3 col-sm-4 hidden-xs');
  avatar.append($('<img>').addClass('avatar').attr('src', author.avatar));
  var body = $('<div>').addClass('col-md-9 col-sm-8')
  body.append(text);
  var comment = $('<div>').addClass('row body');
  comment.append(avatar);
  comment.append(body);
  return comment;
}

function initCommentsForm() {
  var commentForm = $('.comments #comments-form')
  var url = commentForm.attr('action');
  commentForm.submit(function(event){
    event.preventDefault();
    var body = commentForm.find('#body').val();
    $.post(url, {body: body}, function(response){
      var comment = $('<div>').addClass('comment');
      comment.append(buildCommentHeader(response.id, response.url, response.date, response.author));
      comment.append(buildCommentBody(response.author, response.body));
      $('#comments-list').append(comment);
    });
    return false;
  });
}

$(document).ready(initCommentsForm);