class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user

  def index
    @selected_period = period_name_is_acceptable? ? params[:period] : default_period_name
    @events = @user.events(Time.now - 1.send(@selected_period.to_sym), Time.now)
    if type_name_is_acceptable?
      @selected_type = params[:type]
      @events = @events.where(type: "Events::#{@selected_type.camelize}") 
    else
      @selected_type = default_type_name
    end
    @events = @events.order('events.updated_at DESC')
    @events = @events.page(params[:page]).per(params[:per])
  end

  private

  def event_type_names
    if @event_type_names.nil?
      @event_type_names = [
        'all_events', 'post_created_event', 'comment_created_event',
        'bug_rejected_event', 'bug_fixed_event', 'bug_rejected_event',
        'bug_created_event', 'bug_commented_event'

      ]
      @default_type_name = 'all_events'
      if @user.admin?
        @event_type_names << 'user_created_event'
      end
    end
    @event_type_names
  end 

  def default_type_name
    event_type_names.first
  end

  helper_method :event_type_names
  helper_method :default_type_name

  def period_names
    if @period_names.nil?
      @period_names = ['hour', 'day', 'week', 'month']
    end
    @period_names
  end

  def default_period_name
    period_names.second
  end

  helper_method :period_names
  helper_method :default_period_name

  def type_name_is_acceptable?
    params[:type].present? && event_type_names.include?(params[:type]) && params[:type] != default_type_name
  end

  def period_name_is_acceptable?
    params[:period].present? && period_names.include?(params[:period]) && params[:period] != default_period_name
  end


  def load_user
    @user = current_user
  end
end