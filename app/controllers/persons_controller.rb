class PersonsController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @users = User.all
    redirect_to(@users)
  end

  def im
    redirect_to :back
  end

  def show
    respond_with(@user)
  end

  def new
    @user = User.new
    respond_with(@user)
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.save
    respond_with(@user)
  end

  def update
    @user.update(user_params)
    redirect_to :back
  end

  def destroy
    @user.destroy
    respond_with(persons_path)
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      #user = User.find(params[:id])
      #binding.pry
      params.require(:user).permit(:username, :nickname, :provider, :url)
    end
end
