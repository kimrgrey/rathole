json.lsd @lsd.to_i
json.next_lsd @next_lsd.to_i

json.users @users do |user|
  json.partial! 'user', user: user
end

json.partial! 'post', post: @post