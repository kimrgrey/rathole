module DropboxHelper
  def dropbox_javascript_tag
    url = 'https://www.dropbox.com/static/api/1/dropins.js'
    key = '3feh7nl2ziwhoz0'
    javascript_include_tag url, id: 'dropboxjs', 'data-app-key' => key
  end

  def dropbox_saver_link(url)
    content_tag :a, '', class: 'dropbox-saver', href: url
  end

  def dropbox_chooser_input
    options = {
      id: 'dropbox-chooser', 
      name: 'file', 
      type: 'dropbox-chooser', 
      data: {
        'link-type' => 'direct',
        'extension' => '.jpg .png .jpeg'
      }
    }
    content_tag :input, '', options
  end
end