class DaysController < ApplicationController
  before_filter :authenticate_user!

  def show(task_id)
    binding.pry
    @days = Day.where(task_id: task_id).order(:date) unless task_id.nil?
  end

  def ajax
    task = Task.find_by(id: params[:task_id])
    @days = task.days.order(:date)
    time = params[:time].to_i
    date = params[:date].to_datetime

    @current_day = task.days.find_or_initialize_by(date: date.to_date)

    if @current_day.save_time(time, task.time_to_plan, date)
      table =  render_to_string partial: 'table', days: @days
      total_time = task.get_total_time

      render :json => { table: table, total_time: total_time}
    end

    # respond_to do |format|
    #   format.js do
    #   end
    #
    #   format.json do
    #     @user = User.find_by_authentication_token(params[:authentication_token])
    #     @line = @user.days.find_or_initialize_by(:date => Time.now.to_date)
    #
    #     if @line.save_time(time)
    #       render :json => { :success => true }, :status=>201
    #     end
    #   end
    # end
  end

  def list_days
    respond_to do |format|
      format.json do
        @user = User.find_by_authentication_token(request.headers['HTTP_X_ANDROID_TOKEN'])
        json = @user.days
        render :json => { days: json } unless @user.nil?
      end
    end
  end

end
