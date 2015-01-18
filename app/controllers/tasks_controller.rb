class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
   @tasks = Task.all
   respond_with(@tasks)
  end
  #"#{def index
    #{@user = current_user unless current_user.nil?
  #  @tasks = Task.where(:user_id => @user.id) unless @user.nil?
  #  #@days = Day.where(:task_id => @task.id)
  #end

  def show
    @days = Array(Day.find_by_task_id(@task.id))
    respond_with(@task, @days)
  end

  def new
    @task = Task.new
    @user = current_user unless current_user.nil?
    @task.user_id = @user.id
    respond_with(@task)
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    @task.save
    respond_with(@task)
  end

  def update
    @task.update(task_params)
    respond_with(@task)
  end

  def destroy
    @task.destroy
    respond_with(@task)
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :time_to_plan, :user_id)
    end
end
