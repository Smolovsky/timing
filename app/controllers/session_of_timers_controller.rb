class SessionOfTimersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_session_of_timer, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    date = params[:date].to_date
    @session_of_timers = SessionOfTimer.where start_time: (date.midnight..(date+1.day).midnight)

    respond_with(@session_of_timers)
  end

  def show
    respond_with(@session_of_timer)
  end

  def new
    @session_of_timer = SessionOfTimer.new
    respond_with(@session_of_timer)
  end

  def edit
  end

  def create
    @session_of_timer = SessionOfTimer.new(session_of_timer_params)
    @session_of_timer.save
    respond_with(@session_of_timer)
  end

  def update
    @session_of_timer.update(session_of_timer_params)
    respond_with(@session_of_timer)
  end

  def destroy
    @session_of_timer.destroy
    respond_with(@session_of_timer)
  end

  private
    def set_session_of_timer
      @session_of_timer = SessionOfTimer.find(params[:id])
    end

    def session_of_timer_params
      params.require(:session_of_timer).permit(:start_time, :day_id, :time_in_work)
    end
end
