class SectionsController < ApplicationController
  before_action :authenticate_user!
  
  authorize_actions_for Post
  
  before_action :load_user
  before_action :load_sections

  def new
    @section = @sections.build
  end

  def create
    @section = @sections.build(section_params)
    authorize_action_for(@section)
    if @section.save
      flash[:notice] = I18n.t('sections.create.success') 
      redirect_to user_path
    else
      render :new
    end
  end

  def edit
    authorize_action_for(@section)
    @section = @sections.find(params[:id])
  end

  def update
    @section = @sections.find(params[:id])
    authorize_action_for(@section)
    @section.attributes = section_params
    if @section.save
      flash[:notice] = I18n.t('sections.update.success') 
      redirect_to user_path
    else
      render :edit
    end
  end

  def destroy
    @section = @sections.find(params[:id])
    authorize_action_for(@section)
    if @section.destroy
      flash[:notice] = I18n.t('sections.destroy.success')
      redirect_to user_path
    else
      flash[:error] = @section.errors[:base].any? ? @section.errors[:base].join : I18n.t('sections.destroy.failed')
      redirect_to :back
    end
  end  

  private

  def section_params
    params.require(:section).permit(:name)
  end

  def load_user
    @user = current_user
  end

  def load_sections
    @sections = @user.sections
  end
end