class TasksController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  respond_to :html
  
  def index
    @user = current_user unless current_user.nil?
    @tasks = Task.where(user_id: @user.id)
    respond_with(@tasks)
  end

  def show
    @days = Day.where(task_id: @task.id)
    respond_with(@task, @days)
  end

  def new
    @task = Task.new
    @task.time_to_plan = Time.at(1.hours)
    respond_with(@task)
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    @user = current_user unless current_user.nil?
    @task.user_id = @user.id

    @task.save
    respond_with(@task)
  end

  def update
    @task.update(task_params)
    respond_with(@task)
  end

  def destroy
    @task.days.each { |day| day.session_of_timers.destroy_all }
    @task.days.destroy_all
    @task.destroy

    respond_with(@task)
  end

  private
    def set_task
      @task = Task.find_by_id(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :time_to_plan, :user_id)
    end
end
