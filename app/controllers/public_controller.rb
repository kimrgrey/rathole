class PublicController < ApplicationController
  def overview
    @users = User.all
    @users = @users.order('users.last_published_at DESC NULLS LAST')
  end
end