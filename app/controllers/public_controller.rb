class PublicController < ApplicationController
  def welcome
    @posts = user_signed_in? ? Post.my_or_published(current_user) : Post.published_only
    @posts = @posts.tagged_with(params[:tag]) if params[:tag].present?
    @posts = @posts.visible_on_main 
    @posts = @posts.in_order
    @posts = @posts.page(params[:page]).per(params[:per])
  end

  def overview
    @users = User.all
    @users = @users.in_featured_order
  end

  def help
    respond_to do |format|
      format.html
    end
  end

  def claim
    @claim = Claim.new(claim_params)
    if @claim.save
      flash[:notice] = I18n.t('public.claim.success')
      respond_to do |format|
        format.html { redirect_to :back }
      end
    else
      respond_to do |format|
        format.html { render :help }
      end
    end
  end

  private

  def claim_params
    params.permit(:email, :body)
  end
end