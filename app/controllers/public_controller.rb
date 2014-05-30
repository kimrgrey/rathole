class PublicController < ApplicationController
  def overview
    @users = User.all
    @users = @users.in_featured_order
  end
end