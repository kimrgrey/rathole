class ImportsController < ApplicationController
  before_action :authenticate_user!

  before_action :load_user
  before_action :load_imports

  def index
    @imports = @imports.in_order
    @imports = @imports.page(params[:page]).per(params[:per])
  end

  def new
    @import = @imports.build
  end

  def create
    @import = @imports.build(import_params)
    if @import.save
      flash[:notice] = I18n.t('imports.create.success')
      redirect_to user_imports_path
    else
      render :new
    end
  end

  private

  def load_user
    @user = current_user
  end

  def load_imports
    @imports = @user.imports
  end

  def import_params
    params.require(:import).permit(:lj_user)
  end
end