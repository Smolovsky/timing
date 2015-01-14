class HelloController < ApplicationController
  def index
    @users = User.all
  end
end
