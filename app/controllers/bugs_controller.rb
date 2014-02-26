class BugsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user

  def index
    
  end

  def create

  end

  private

  def load_user
    @user = current_user
  end
end