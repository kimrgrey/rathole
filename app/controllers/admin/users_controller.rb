class Admin::UsersController < Admin::AdminController
  def show
    @user = User.find(params[:id])
    @stickers = @user.stickers
    @posts = @user.posts
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = I18n.t('admin.users.destroy.success')
      redirect_to admin_root_path
    else
      flash[:error] = I18n.t('admin.users.destroy.failed')
      redirect_to admin_user_path(@user)
    end
  end
end