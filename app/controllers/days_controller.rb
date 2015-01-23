class DaysController < ApplicationController
  before_filter :authenticate_user!

  def show(task_id)
    @days = Day.where(task_id: task_id).order(:date) unless task_id.nil?

  end

  def ajax
    task = Task.find_by(id: params[:task_id])
    @days = Day.where(task_id: task.id).order(:date)
    time = params[:time].to_i
    is_new_day = params[:is_new_day] =='true'

    date = Time.now.to_date
    date -= 1.day if is_new_day

    @current_day = Day.find_or_initialize_by(date: date, task_id: task.id )

    if @current_day.save_time(time,task.time_to_plan, is_new_day)
      table =  render_to_string partial: 'table', days: @days
      total_time = task.get_total_time task

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
