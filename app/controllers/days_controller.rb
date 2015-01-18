class DaysController < ApplicationController

  def show(task_id)

    if task_id.nil?
      @days = Day.all
    else
      @days = Day.find_by_task_id(task_id)
    end
  end

  def ajax
    #@task = Task.where(id: )
    task_id = params[:task_id]

    @days = Day.find_by_task_id(task_id)#.order(:date)
    time = params[:time].to_time(:utc)


    respond_to do |format|

      format.js do
        @line = Day.find_or_initialize_by(date: Time.now.to_date, task_id: task_id )

        if @line.save_time(time)
          @days =Array Day.find_by_task_id(task_id)
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
