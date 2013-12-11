class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :load_current_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :load_other_user, only: [:index, :show]
  
  def show
  end

  private

  def load_current_user
    @user = current_user
  end

  def load_other_user
    if params[:user_name].present?
      @user = User.where(user_name: params[:user_name]).first || not_found
    elsif user_signed_in?
      @user = current_user
    else
      not_found
    end
  end
end