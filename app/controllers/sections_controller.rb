class SectionsController < ApplicationController
  before_action :authenticate_user!
    
  before_action :load_user
  before_action :load_sections

  def new
    authorize! :new, Section
    @section = @sections.build
  end

  def create
    authorize! :create, Section
    @section = @sections.build(section_params)
    if @section.save
      flash[:notice] = I18n.t('sections.create.success') 
      redirect_to user_path
    else
      render :new
    end
  end

  def edit
    @section = @sections.find(params[:id])
    authorize! :edit, @section
  end

  def update
    @section = @sections.find(params[:id])
    authorize! :update, @section
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
    authorize! :destroy, @section
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