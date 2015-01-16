class DaysController < ApplicationController
  def ajax
    @days = Day.all.order(:date)
    time = params[:time].to_time(:utc)

    respond_to do |format|

      format.js do
        @line = current_user.days.find_or_initialize_by(:date => Time.now.to_date)
        if @line.save_time(time)
          render 'ajax', format: :js
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
