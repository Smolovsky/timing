class HelloController < ApplicationController
 # respond_to :js

  def index
    @days = Day.all.order(:date)
  end

end
