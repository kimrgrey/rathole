class PicturesController < ApplicationController
  include RoutesHelper
  
  skip_before_action :verify_authenticity_token

  before_action :authenticate_user!
  before_action :load_user

  def upload
    input = request.body.read
    tmp = Tempfile.new('picture')
    begin  
      tmp.binmode
      tmp.write(input)
      tmp.rewind
      @picture = @user.pictures.build
      @picture.image = tmp
      @picture.save
    ensure
      tmp.close
      tmp.unlink
    end
  end

  def destroy
    picture = @user.pictures.find(params[:id])
    if picture.destroy 
      render nothing: true, status: 200
    else
      render nothing: true, status: 422
    end
  end

  private

  def load_user
    @user = current_user
  end
end