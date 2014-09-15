class PicturesController < ApplicationController
  include RoutesHelper
  
  before_action :authenticate_user!
  before_action :load_user

  def upload
    @pictures = []
    params[:files].each do |file|
      picture = @user.pictures.build
      picture.image = file
      picture.save
      @pictures << picture
    end
  end

  def destroy
    picture = @user.pictures.find(params[:id])
    picture.hide ? head(200) : head(422)
  end

  private

  def load_user
    @user = current_user
  end
end