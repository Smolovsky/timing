class DaysController < ApplicationController

  def show(task_id)
    @days = Day.where(task_id: task_id).order(:date) unless task_id.nil?
  end

  def ajax
    task = Task.find_by(id: params[:task_id])

    @days = Day.where(task_id: task.id).order(:date)
    time = params[:time].to_time

    respond_to do |format|

      format.js do
        @current_day = Day.find_or_initialize_by(date: Time.now.to_date, task_id: task.id )

        if @current_day.save_time(time,task.time_to_plan)
          render 'ajax',days: @days, format: :js
        end
      end

      format.json do
        @user = User.find_by_authentication_token(params[:authentication_token])
        @line = @user.days.find_or_initialize_by(:date => Time.now.to_date)

        if @line.save_time(time)
          render :json => { :success => true }, :status=>201
        end
      end
    end
  end


end
