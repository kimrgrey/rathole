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
      picture = @user.pictures.build
      picture.image = tmp
      if picture.save
        result = {
          message: I18n.t('pictures.create.success'),
          urls: {
            original: full_image_url(picture.image_url),
            thumb: full_image_url(picture.image_url(:thumb)),
            destroy: destroy_picture_path(picture)
          }
        }
        render json: result, status: 200
      else
        result = {
          message: I18n.t('pictures.create.failed'),
          errors: picture.errors.full_messages
        }
        render json: result, status: 422
      end
    ensure
      tmp.close
      tmp.unlink
    end
  end

  def destroy
    picture = @user.pictures.find(params[:id])
    if picture.destroy 
      result = {
        message: I18n.t('pictures.destroy.success')
      }
      render json: result, status: 200
    else
      result = {
        message: I18n.t('pictures.destroy.failed')
      }
      render json: result, status: 422
    end
  end

  private

  def load_user
    @user = current_user
  end
end