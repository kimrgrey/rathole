if @sync.finished
  json.result(@sync.result)
  json.partial!('css') if @sync.post.blank?
else
  json.url api_v2_status_url(:token => @sync.token)
  json.method "get"
  json.timeout 3
end
